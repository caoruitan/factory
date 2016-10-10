package com.cd.user;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cd.dao.GridData;
import com.cd.database.Database;
import com.cd.database.DatabaseService;
import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="user/")
public class UserAction {
    
    @Autowired
    @Qualifier("UserService")
    UserService userService;
    
    @Autowired
    @Qualifier("DepartmentService")
    DepartmentService departmentService;
    
    @Autowired
    @Qualifier("PrivilegeService")
    PrivilegeService privilegeService;
    
    @Autowired
    @Qualifier("DatabaseService")
    DatabaseService databaseService;
    
    @RequestMapping(value="main")
    public String main() {
        return "/user/main";
    }
    
    @RequestMapping(value="getDepartments")
    public void getDepartments(HttpServletRequest request, HttpServletResponse response) {
        String parentId = request.getParameter("id");
        if(parentId == null) {
            parentId = "-1";
        }
        JSONArray departments = this.getSubDepartmentJSONArray(parentId);
        WebUtil.writeTOPage(response, departments);
    }
    
    private JSONArray getSubDepartmentJSONArray(String parentId) {
        List<Department> list = this.departmentService.getSubDepartments(parentId);
        if(list == null || list.size() <= 0) return null;
        JSONArray departments = new JSONArray();
        for(Department dep : list) {
            JSONObject obj = new JSONObject();
            obj.put("id", dep.getDepartmentId());
            obj.put("name", dep.getDepartmentName());
            obj.put("level", dep.getLevel());
            obj.put("icon", "../uiframe/images/jsb.png");
            JSONArray subList = this.getSubDepartmentJSONArray(dep.getDepartmentId());
            if(subList != null) {
                if(parentId.equals("-1")) {
                    obj.put("open", true);
                    obj.put("children", subList);
                } else {
                    obj.put("isParent", true);
                }
            } else {
                obj.put("isParent", false);
            }
            departments.add(obj);
        }
        return departments;
    }
    
    @RequestMapping(value="createDepartment")
    public void createDepartment(HttpServletRequest request, HttpServletResponse response) {
        String departmentName = request.getParameter("departmentName");
        String description = request.getParameter("description");
        String parentId = request.getParameter("parentId");
        this.departmentService.createDepartment(departmentName, description, parentId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="toUpdateDepartment")
    public String toUpdateDepartment(HttpServletRequest request, HttpServletResponse response) {
        String departmentId = request.getParameter("departmentId");
        Department dep = this.departmentService.getDepartment(departmentId);
        request.setAttribute("department", dep);
        return "/user/updateDep";
    }
    
    @RequestMapping(value="updateDepartment")
    public void updateDepartment(HttpServletRequest request, HttpServletResponse response) {
        String departmentId = request.getParameter("departmentId");
        String departmentName = request.getParameter("departmentName");
        String description = request.getParameter("description");
        Department dep = this.departmentService.updateDepartment(departmentId, departmentName, description);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        obj.put("department", JSONObject.fromObject(dep));
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="deleteDepartment")
    public void deleteDepartment(HttpServletRequest request, HttpServletResponse response) {
        String departmentId = request.getParameter("departmentId");
        JSONObject obj = new JSONObject();
        try {
            this.departmentService.deleteDepartment(departmentId);
            obj.put("success", true);
        } catch (Exception e) {
            obj.put("success", false);
            obj.put("msg", e.getMessage());
        }
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="userGrid")
    public String userGrid(HttpServletRequest request, HttpServletResponse response) {
        String start = request.getParameter("start");
        String limit = request.getParameter("limit");
        String departmentId = request.getParameter("departmentId");
        if(departmentId == null) {
            departmentId = "0";
        }
        GridData<User> grid = this.userService.getUserListByDepartment(departmentId, Integer.parseInt(start), Integer.parseInt(limit));
        request.setAttribute("gridData", grid);
        return "/user/userGrid";
    }
    
    @RequestMapping(value="createUser")
    public void createUser(HttpServletRequest request, HttpServletResponse response) {
        JSONObject obj = new JSONObject();
        String userName = request.getParameter("username");
        String loginName = request.getParameter("loginname");
        String sex = request.getParameter("sex");
        String university = request.getParameter("university");
        String title = request.getParameter("title");
        String phone = request.getParameter("phone");
        String departmentId = request.getParameter("departmentId");
        
        List<User> list = this.userService.getUserByLoginName(loginName);
        if(list.size() > 0) {
            obj.put("success", false);
            obj.put("msg", "该用户已经存在！");
            WebUtil.writeTOPage(response, obj);
            return;
        }
        this.userService.createUser(loginName, userName, sex, university, title, phone, departmentId);
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="toUpdateUser")
    public String toUpdateUser(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        User user = this.userService.getUser(userId);
        request.setAttribute("user", user);
        return "/user/updateUser";
    }
    
    @RequestMapping(value="toUpdateLoginInfo")
    public String toUpdateLoginInfo(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        User user = this.userService.getUser(userId);
        request.setAttribute("user", user);
        return "/user/updateLoginInfo";
    }
    
    @RequestMapping(value="updateUser")
    public void updateUser(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        String userName = request.getParameter("username");
        String sex = request.getParameter("sex");
        String university = request.getParameter("university");
        String title = request.getParameter("title");
        String phone = request.getParameter("phone");
        this.userService.updateUser(userId, userName, sex, university, title, phone);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="resetPassword")
    public void resetPassword(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        this.userService.resetPassword(userId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="updatePassword")
    public void updatePassword(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String password1 = request.getParameter("password1");
        try {
            this.userService.updatePassword(userId, password, password1);
        } catch (Exception e) {
            JSONObject obj = new JSONObject();
            obj.put("success", false);
            obj.put("msg", e.getMessage());
            WebUtil.writeTOPage(response, obj);
            return;
        }
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="deleteUser")
    public void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        this.userService.deleteUser(userId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
    @RequestMapping(value="toSetPrivilege")
    public String toSetPrivilege(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        List<Privilege> privilegeList = this.privilegeService.getPrivilegeOfUser(userId);
        List<String> privileges = new ArrayList<String>();
        for(Privilege privilege : privilegeList) {
            privileges.add(privilege.getModelId() + "_" + privilege.getFunctionId());
        }
        
        List<Database> databaseList = this.databaseService.getDatabaseList();
        Map<String, String> models = new LinkedHashMap<String, String>();
        for(Database database : databaseList) {
            models.put(database.getKey(), database.getName());
        }
        
        request.setAttribute("userId", userId);
        request.setAttribute("models", models);
        request.setAttribute("privileges", privileges);
        return "/user/setPrivilege";
    }
    
    @RequestMapping(value="setPrivilege")
    public void setPrivilege(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        Map<String, String[]> params = request.getParameterMap();
        Set<String> keySet = params.keySet();
        List<String> privileges = new ArrayList<String>();
        for(String key : keySet) {
            if(!key.equals("userId")) {
                String value = params.get(key)[0];
                if(value.equals("on")) {
                    privileges.add(key);
                }
            }
        }
        this.privilegeService.setPrivileges(userId, privileges);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
}
