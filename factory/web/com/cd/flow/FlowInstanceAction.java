package com.cd.flow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cd.dao.GridData;
import com.cd.datalib.DataLib;
import com.cd.datalib.DataLibService;
import com.cd.login.LoginSessionKey;
import com.cd.login.LoginUser;
import com.cd.user.PrivilegeService;
import com.cd.user.User;
import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="flowinstance/")
public class FlowInstanceAction {

    @Autowired
    @Qualifier("PrivilegeService")
    private PrivilegeService privilegeService;

    @Autowired
    @Qualifier("FlowStepService")
    FlowStepService flowStepService;

    @Autowired
    @Qualifier("FlowStepInstanceService")
    FlowStepInstanceService flowStepInstanceService;

    @Autowired
    @Qualifier("DataLibService")
    DataLibService dataLibService;

    @RequestMapping(value="toSendApproval")
    public String toSendApproval(HttpServletRequest request) {
        String database = request.getParameter("database");
        String dataId = request.getParameter("dataId");
        List<FlowStep> steps = this.flowStepService.getStepsByDatabase(database);
        List<User> userList = this.privilegeService.findUsersByPrivilege(database, "APPROVAL");
        Map<String, String> userNames = new HashMap<String, String>();
        for(User user : userList) {
            userNames.put(user.getUserId(), user.getUserName());
        }
        request.setAttribute("userNames", userNames);
        request.setAttribute("database", database);
        request.setAttribute("dataId", dataId);
        request.setAttribute("steps", steps);
        return "/flow/sendApproval";
    }

    @RequestMapping(value="sendApproval")
    public void sendApproval(HttpServletRequest request, HttpServletResponse response) {
        String database = request.getParameter("database");
        String dataId = request.getParameter("dataId");
        this.flowStepInstanceService.sendApproval(database, dataId);
        request.setAttribute("database", database);
        request.setAttribute("dataId", dataId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="myApproval")
    public String myApproval(HttpServletRequest request, HttpServletResponse response) {
        return "/flow/myApproval";
    }

    @RequestMapping(value="myApprovalGrid")
    public String myApprovalGrid(HttpServletRequest request, HttpServletResponse response) {
        LoginUser user = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
        int start = Integer.parseInt(request.getParameter("start"));
        int limit = Integer.parseInt(request.getParameter("limit"));
        GridData<FlowStepInstance> steps = this.flowStepInstanceService.getFlowStepByUser(user.getUserId(), start, limit);
		List<DataLib> datalibs = new ArrayList<DataLib>();
		if (steps.getList() != null) {
			for (FlowStepInstance step : steps.getList()) {
				DataLib datalib = this.dataLibService.getDataLib(step.getDataId());
				datalibs.add(datalib);
			}
		}
		request.setAttribute("datalibs", datalibs);
        request.setAttribute("gridData", steps);
        return "/flow/myApprovalGrid";
    }

    @RequestMapping(value="approvalHistory")
    public String approvalHistory(HttpServletRequest request, HttpServletResponse response) {
        String database = request.getParameter("database");
        String dataId = request.getParameter("dataId");
        List<FlowStepInstance> steps = this.flowStepInstanceService.getFlowStepInstanceByDataId(database, dataId);
        request.setAttribute("steps", steps);
        return "/flow/approvalHistory";
    }

    @RequestMapping(value="toApproval")
    public String toApproval(HttpServletRequest request, HttpServletResponse response) {
        String stepInstanceId = request.getParameter("stepInstanceId");
        FlowStepInstance step = this.flowStepInstanceService.getFlowStepInstance(stepInstanceId);
        DataLib data = this.dataLibService.getDataLib(step.getDataId());
        List<FlowStepInstance> steps = this.flowStepInstanceService.getFlowStepInstanceByDataId(step.getDatabaseKey(), step.getDataId());
        request.setAttribute("data", data);
        request.setAttribute("step", step);
        request.setAttribute("steps", steps);
        return "/flow/approval";
    }

    @RequestMapping(value="approval")
    public String approval(HttpServletRequest request, HttpServletResponse response) {
        String stepInstanceId = request.getParameter("stepInstanceId");
        String result = request.getParameter("result");
        String memo = request.getParameter("memo");
        this.flowStepInstanceService.approval(stepInstanceId, result.equals("1"), memo);
        return "redirect:/flowinstance/myApproval.sitemesh";
    }

    @RequestMapping(value = "toInvitExpert")
    public String toInvitExpert(HttpServletRequest request, HttpServletResponse response) {
        String stepInstanceId = request.getParameter("stepInstanceId");
        FlowStepInstance instance = this.flowStepInstanceService.getFlowStepInstance(stepInstanceId);
        String databaseKey = instance.getDatabaseKey();
        List<User> userList = this.privilegeService.findUsersByPrivilege(databaseKey, "EXPERT");
        request.setAttribute("userList", userList);
        request.setAttribute("stepInstanceId", stepInstanceId);
        return "/flow/invitExpert";
    }

    @RequestMapping(value = "invitExpert")
    public void invitExpert(HttpServletRequest request, HttpServletResponse response) {
        String stepInstanceId = request.getParameter("stepInstanceId");
        String[] experts = request.getParameterValues("expert");
        this.flowStepInstanceService.invitExpert(stepInstanceId, experts);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
}
