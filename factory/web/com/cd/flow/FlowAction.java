package com.cd.flow;

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

import com.cd.database.Database;
import com.cd.database.DatabaseService;
import com.cd.user.PrivilegeService;
import com.cd.user.User;
import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="flow/")
public class FlowAction {

    @Autowired
    @Qualifier("PrivilegeService")
    private PrivilegeService privilegeService;
    
    @Autowired
    @Qualifier("DatabaseService")
    DatabaseService databaseService;
    
    @Autowired
    @Qualifier("FlowStepService")
    FlowStepService flowStepService;
    
    @RequestMapping(value="main")
    public String main(HttpServletRequest request) {
        List<Database> databaseList = this.databaseService.getDatabaseList();
        request.setAttribute("databaseList", databaseList);
        return "/flow/main";
    }
    
    @RequestMapping(value="stepGrid")
    public String stepGrid(HttpServletRequest request) {
        String database = request.getParameter("database");
        List<FlowStep> steps = this.flowStepService.getStepsByDatabase(database);
        List<User> userList = privilegeService.findUsersByPrivilege(database, "APPROVAL");
        Map<String, String> userNames = new HashMap<String, String>();
        for(User user : userList) {
            userNames.put(user.getUserId(), user.getUserName());
        }
        request.setAttribute("userNames", userNames);
        request.setAttribute("steps", steps);
        request.setAttribute("database", database);
        return "/flow/stepGrid";
    }

    @RequestMapping(value="toAddStep")
    public String toAddStep(HttpServletRequest request) {
        String database = request.getParameter("database");
        List<User> userList = privilegeService.findUsersByPrivilege(database, "APPROVAL");
        request.setAttribute("userList", userList);
        request.setAttribute("database", database);
        return "/flow/addStep";
    }

    @RequestMapping(value="addStep")
    public void addStep(HttpServletRequest request, HttpServletResponse response) {
        String database = request.getParameter("database");
        String stepName = request.getParameter("stepName");
        String stepUser = request.getParameter("stepUser");
        this.flowStepService.addStep(database, stepName, stepUser);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="toUpdateStep")
    public String toUpdateStep(HttpServletRequest request) {
        String database = request.getParameter("database");
        String stepId = request.getParameter("stepId");
        FlowStep step = this.flowStepService.getFlowStep(stepId);
        List<User> userList = privilegeService.findUsersByPrivilege(database, "APPROVAL");
        request.setAttribute("step", step);
        request.setAttribute("userList", userList);
        request.setAttribute("database", database);
        return "/flow/updateStep";
    }

    @RequestMapping(value="updateStep")
    public void updateStep(HttpServletRequest request, HttpServletResponse response) {
        String stepId = request.getParameter("stepId");
        String stepName = request.getParameter("stepName");
        String stepUser = request.getParameter("stepUser");
        this.flowStepService.updateStep(stepId, stepName, stepUser);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="deleteStep")
    public void deleteStep(HttpServletRequest request, HttpServletResponse response) {
        String stepId = request.getParameter("stepId");
        this.flowStepService.deleteStep(stepId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="moveUpStep")
    public void moveUpStep(HttpServletRequest request, HttpServletResponse response) {
        String stepId = request.getParameter("stepId");
        this.flowStepService.moveUpStep(stepId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

    @RequestMapping(value="moveDownStep")
    public void moveDownStep(HttpServletRequest request, HttpServletResponse response) {
        String stepId = request.getParameter("stepId");
        this.flowStepService.moveDownStep(stepId);
        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }
    
}
