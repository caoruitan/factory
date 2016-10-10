<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    String departmentId = request.getParameter("departmentId");
    request.setAttribute("departmentId", departmentId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户管理</title>
<script type="text/javascript">
    $(document).ready(function(){
        // 添加用户表单验证
        $('#updateUserForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/updateUser.action',
                    data : $("#updateUserForm").serialize(),
                    dataType : 'json',
                    success : function() {
                        $("#updateUserModal").modal('hide');
                        grid.reload();
                    }
                });
            },
            rules: {
                username: {
                    required: true,
                    maxlength : 20
                },
                university: {
                    maxlength : 30
                },
                title: {
                    maxlength : 20
                },
                phone: {
                    isTel : 50
                }
            },
            highlight: function(element) {
                $(element).closest('.control-group').removeClass('success').addClass('error');
            },
            success: function(element) {
                element.addClass('valid').closest('.control-group').removeClass('error').addClass('success');
            }
        });
    });
</script>
</head>
<body>
    <form class="form-horizontal" method="post" action="<%=basePath%>/user/updateUser.action" name="updateUserForm" id="updateUserForm">
        <input type="hidden" name="userId" id="userId" value="${user.userId}">
        <div class="control-group">
            <label class="control-label" for="username">姓名</label>
            <div class="controls">
                <input type="text" name="username" id="username" value="${user.userName}" placeholder="姓名">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="sex">性别</label>
            <div class="controls">
                <select name="sex" id="sex" placeholder="性别">
                    <c:if test="${user.sex eq 1}">
                        <option value="1" selected="selected">男</option>
                        <option value="2">女</option>
                    </c:if>
                    <c:if test="${user.sex eq 2}">
                        <option value="1">男</option>
                        <option value="2" selected="selected">女</option>
                    </c:if>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="university">毕业院校</label>
            <div class="controls">
                <input type="text" name="university" id="university" value="${user.university}" placeholder="毕业院校">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="title">职称</label>
            <div class="controls">
                <input type="text" name="title" id="title" value="${user.title}" placeholder="职称">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="phone">联系电话</label>
            <div class="controls">
                <input type="text" name="phone" id="phone" value="${user.phoneNumber}" placeholder="联系电话">
            </div>
        </div>
    </form>
</body>
</html>
