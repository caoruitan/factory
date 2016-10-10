<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加步骤</title>
<script type="text/javascript">
    $(document).ready(function(){
        // 添加步骤验证
        $('#addStepForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/flow/addStep.action',
                    data : $("#addStepForm").serialize(),
                    dataType : 'json',
                    success : function() {
                        $("#addStepModal").modal('hide');
                        $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${database}");
                    }
                });
            },
            rules: {
                stepName : {
                    required: true
                },
                stepUser : {
                    required: true
                }
            },
            highlight: function(element) {
                $(element).closest('.control-group').removeClass('success').addClass('error');
            },
            success: function(element) {
                element.addClass('valid').closest('.control-group').removeClass('error').addClass('success');
            }
        });

        $('.selectpicker').selectpicker({
            'selectedText': 'cat'
        });
    });
</script>
</head>
<body>
    <form class="form-horizontal" method="post" name="addStepForm" id="addStepForm">
        <input type="hidden" name="database" value="${database}"/>
        <div class="control-group">
            <label class="control-label" for="stepName">步骤名称</label>
            <div class="controls">
                <input type="text" name="stepName" id="stepName" placeholder="步骤名称">
            </div>
        </div>
        <div class="control-group" style="height:200px;">
            <label class="control-label" for="approvalUser">审批人员</label>
            <div class="controls">
                <select id="stepUser" name="stepUser" placeholder="审批人员" class="selectpicker" data-live-search="true">
                    <c:forEach items="${userList}" var="user">
                        <option value="${user.userId}">${user.userName}(${user.loginName})</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </form>
</body>
</html>
