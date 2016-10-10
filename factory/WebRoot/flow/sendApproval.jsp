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
    $(document).ready(function(){
        // 添加步骤验证
        $('#sendApprovalForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/flowinstance/sendApproval.action',
                    data : $("#sendApprovalForm").serialize(),
                    dataType : 'json',
                    success : function() {
                        $("#sendApprovalModal").modal('hide');
                    }
                });
            }
        });
    });
</script>
<form class="form-horizontal" method="post" name="sendApprovalForm" id="sendApprovalForm">
    <input type="hidden" name="database" value="${database}"/>
    <input type="hidden" name="dataId" value="${dataId}"/>
</form>
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th width="30">步骤</th>
            <th width="100">步骤名称</th>
            <th width="100">审批人</th>
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
        </tr>
<%
}
%>
    </tbody>
</table>