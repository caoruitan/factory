<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.cd.flow.FlowStep"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    List<FlowStep> steps = (List<FlowStep>) request.getAttribute("steps");
    Map<String, String> userNames = (Map<String, String>) request.getAttribute("userNames");
%>
<script type="text/javascript">
    // 每次隐藏时，清除界面内容，下次打开重新加载
    $("#addStepModal").on("hidden", function() {
        $(this).removeData("modal");
    });
    // 添加步骤按钮事件
    $("#addStepBtn").on("click", function() {
        $("#addStepModal").modal({
            backdrop : true,
            keyboard : false,
            show : true,
            remote : "toAddStep.action?database=${database}"
        });
    });
    // 创建步骤表单保存按钮事件
    $("#addStepSaveBtn").on("click", function() {
        $("#addStepForm").submit();
    });

    // 每次隐藏时，清除界面内容，下次打开重新加载
    $("#updateStepModal").on("hidden", function() {
        $(this).removeData("modal");
    });
    // 修改步骤按钮响应事件（按钮在列表中）
    var updateStep = function(stepId) {
        $("#updateStepModal").modal({
            backdrop : true,
            keyboard : false,
            show : true,
            remote : "toUpdateStep.action?database=${database}&stepId=" + stepId
        });
    }
    // 修改步骤表单保存按钮事件
    $("#updateStepSaveBtn").on("click", function() {
        $("#updateStepForm").submit();
    });

    // 删除步骤按钮响应事件（按钮在列表中）
    var deleteStep = function(stepId) {
        $.messager.model = { 
            ok : { text: "确定", classed: 'btn-primary'},
            cancel : { text: "取消", classed: 'btn-default'}
        };
        $.messager.confirm("确认", "确定要删除这个步骤吗？步骤删除后将不能恢复！", function() { 
            $.ajax({
                type : 'POST',
                url : '${basePath}/flow/deleteStep.action',
                data : {stepId : stepId},
                dataType : 'json',
                success : function() {
                    $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${database}");
                }
            });
        });
    }

    // 上移按钮响应事件（按钮在列表中）
    var moveUpStep = function(stepId) {
        $.ajax({
            type : 'POST',
            url : '${basePath}/flow/moveUpStep.action',
            data : {stepId : stepId},
            dataType : 'json',
            success : function() {
                $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${database}");
            }
        });
    }

    // 下移按钮响应事件（按钮在列表中）
    var moveDownStep = function(stepId) {
        $.ajax({
            type : 'POST',
            url : '${basePath}/flow/moveDownStep.action',
            data : {stepId : stepId},
            dataType : 'json',
            success : function() {
                $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${database}");
            }
        });
    }

    
    // 每次隐藏时，清除界面内容，下次打开重新加载
    $("#sendApprovalModal").on("hidden", function() {
        $(this).removeData("modal");
    });
    // 送审按钮事件
    $("#sendApprovalBtn").on("click", function() {
        $("#sendApprovalModal").modal({
            backdrop : true,
            keyboard : false,
            show : true,
            remote : "../flowinstance/toSendApproval.action?database=${database}&dataId=123456"
        });
    });
    // 送审表单保存按钮事件
    $("#sendApprovalSaveBtn").on("click", function() {
        $.ajax({
            type : 'POST',
            url : '${basePath}/flowinstance/sendApproval.action',
            data : {
                database : "${database}",
                dataId : '123456'
            },
            dataType : 'json',
            success : function() {
                $("#sendApprovalModal").modal('hide');
                // $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${database}");
            }
        });
    });
</script>
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th colspan="4">
                <a id="addStepBtn" class="btn btn-small btn-info" href="#"><i class="icon-plus icon-white"></i> 添加步骤</a>
                <!-- <a id="sendApprovalBtn" class="btn btn-small btn-info" href="#"><i class="icon-plus icon-white"></i> 送审</a> -->
            </th>
        </tr>
        <tr>
            <th width="50">步骤</th>
            <th width="150">步骤名称</th>
            <th width="150">审批人</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
<%
for(FlowStep step : steps) {
%>
        <tr>
            <td><%=step.getStepNum() %></td>
            <td><%=step.getStepName() %></td>
            <td><%=userNames.get(step.getStepUser())%></td>
            <td>
                <a class="btn btn-mini btn-info" href="javascript:updateStep('<%=step.getStepId() %>')"><i class="icon-pencil icon-white"></i> 编辑</a>
                <a class="btn btn-mini btn-danger" href="javascript:deleteStep('<%=step.getStepId() %>')"><i class="icon-trash icon-white"></i> 删除</a>
                <a class="btn btn-mini btn-info" href="javascript:moveUpStep('<%=step.getStepId() %>')"><i class="icon-arrow-up icon-white"></i> 上移</a>
                <a class="btn btn-mini btn-info" href="javascript:moveDownStep('<%=step.getStepId() %>')"><i class="icon-arrow-down icon-white"></i> 下移</a>
            </td>
        </tr>
<%
}
%>
    </tbody>
</table>
    
<!-- 添加步骤窗口 -->
<div id="addStepModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addStepLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="addStepLabel">添加步骤</h3>
    </div>
    <div class="modal-body">
    </div>
    <div class="modal-footer">
        <button id="addStepSaveBtn" class="btn btn-primary">保存</button>
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>
    
<!-- 修改步骤窗口 -->
<div id="updateStepModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateStepLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="updateStepLabel">修改步骤</h3>
    </div>
    <div class="modal-body">
    </div>
    <div class="modal-footer">
        <button id="updateStepSaveBtn" class="btn btn-primary">保存</button>
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>
    
<!-- 送审窗口 -->
<div id="sendApprovalModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="sendApprovalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="sendApprovalLabel">送审</h3>
    </div>
    <div class="modal-body">
    </div>
    <div class="modal-footer">
        <button id="sendApprovalSaveBtn" class="btn btn-primary">送审</button>
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>