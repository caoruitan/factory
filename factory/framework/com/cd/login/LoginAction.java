package com.cd.login;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cd.database.Database;
import com.cd.database.DatabaseService;
import com.cd.user.Privilege;
import com.cd.user.PrivilegeService;
import com.cd.user.User;
import com.cd.user.UserService;
import com.cd.utils.MD5Util;
import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="login/")
public class LoginAction {

    @Autowired
    @Qualifier("UserService")
    UserService userService;

    @Autowired
    @Qualifier("PrivilegeService")
    PrivilegeService privilegeService;

    @Autowired
    @Qualifier("DatabaseService")
    DatabaseService databaseService;

    @RequestMapping(value="doLogin")
	public void doLogin(User user, HttpServletRequest request,
			HttpServletResponse response) throws IllegalAccessException,
			InvocationTargetException {
        JSONObject obj = new JSONObject();
        List<User> list = this.userService.getUserByLoginName(user.getLoginName());
        if(list == null || list.size() <= 0) {
            obj.put("success", false);
			obj.put("msg", "用户不存在！");
            WebUtil.writeTOPage(response, obj);
            return;
        }
        User user1 = list.get(0);
        if(!user1.getPassword().equals(MD5Util.MD5Encode(user.getPassword()))) {
            obj.put("success", false);
			obj.put("msg", "密码错误！");
            WebUtil.writeTOPage(response, obj);
            return;
        }

        LoginUser loginUser = new LoginUser();
        BeanUtils.copyProperties(loginUser, user1);

        List<Privilege> privilegeList = this.privilegeService.getPrivilegeOfUser(loginUser.getUserId());

        List<String> privileges = new ArrayList<String>();
        for(Privilege privilege : privilegeList) {
            privileges.add(privilege.getModelId() + "_" + privilege.getFunctionId());
        }
        loginUser.setPrivileges(privileges);

        request.getSession(true).setAttribute(LoginSessionKey.LOGIN_SESSION_KEY, loginUser);

        List<Database> databaseList = this.databaseService.getDatabaseList();
		Map<String, List<Database>> databaseMap = new LinkedHashMap<String, List<Database>>();
        for(Database database : databaseList) {
            boolean isHavePrivilege = false;
            for(Privilege privilege : privilegeList) {
                if(database.getKey().equals(privilege.getModelId()) && !"APPROVAL".equals(privilege.getFunctionId())) {
                    isHavePrivilege = true;
                    break;
                }
            }
            if(isHavePrivilege) {
                String type = database.getType();
                List<Database> dblist = databaseMap.get(type);
                if(dblist == null) {
                    dblist = new ArrayList<Database>();
                }
                dblist.add(database);
                databaseMap.put(type, dblist);
            }
        }
        request.getSession(true).setAttribute(LoginSessionKey.DATABASE_KEY, databaseMap);

        if(!databaseMap.isEmpty()) {
			Database database = databaseMap.entrySet().iterator().next().getValue().get(0);
			obj.put("url", "/datalib/main.sitemesh?currentMenu=" + database.getKey());
        } else {
        	if(privilegeList.isEmpty()) {
        		obj.put("success", false);
				obj.put("msg", "没有权限");
                WebUtil.writeTOPage(response, obj);
        		return;
        	}
        	Privilege privilege = privilegeList.get(0);
        	if(privilege.getFunctionId().equals("APPROVAL")) {
         		obj.put("url", "/flowinstance/myApproval.sitemesh?currentMenu=myApproval");
         	} else if(privilege.getFunctionId().equals("EXPERT")) {
         		obj.put("url", "/flowinstance/myApproval.sitemesh?currentMenu=myApproval");
         	} else if(privilege.getFunctionId().equals("USER")) {
        		obj.put("url", "/user/main.sitemesh?currentMenu=user");
        	} else if(privilege.getFunctionId().equals("FLOW")) {
        		obj.put("url", "/flow/main.sitemesh?currentMenu=flow");
        	}
        }

        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="doLogout")
    public String doLogout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession(true).removeAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
        return "/login/login";
    }

}
