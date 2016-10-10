<%@ page language="java" pageEncoding="UTF-8"%>
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
        $('#createUserForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/createUser.action',
                    data : $("#createUserForm").serialize(),
                    dataType : 'json',
                    success : function(data) {
                        $("#createUserModal").modal('hide');
                        if(data.success == true) {
                            grid.reload();
                        } else {
                            $.messager.alert("提示", data.msg);
                        }
                    }
                });
            },
            rules: {
                username: {
                    required: true,
                    maxlength : 20
                },
                loginname: {
                    required: true,
                    maxlength : 20
                },
                role: {
                    required: true
                },
                university: {
                    maxlength : 30
                },
                title: {
                    maxlength : 20
                },
                phone: {
                    isTel : true
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
    <form class="form-horizontal" method="post" action="<%=basePath%>/user/createUser.action" name="createUserForm" id="createUserForm">
        <input type="hidden" name="departmentId" id="departmentId" value="${departmentId}">
        <div class="control-group">
            <label class="control-label" for="username">姓名</label>
            <div class="controls">
                <input type="text" name="username" id="username" placeholder="姓名">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="loginname">登录名</label>
            <div class="controls">
                <input type="text" name="loginname" id="loginname" placeholder="登录名">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="sex">性别</label>
            <div class="controls">
                <select name="sex" id="sex" placeholder="性别">
                    <option value="1">男</option>
                    <option value="2">女</option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="university">毕业院校</label>
            <div class="controls">
                <input type="text" name="university" id="university" placeholder="毕业院校">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="title">职称</label>
            <div class="controls">
                <input type="text" name="title" id="title" placeholder="职称">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="phone">联系电话</label>
            <div class="controls">
                <input type="text" name="phone" id="phone" placeholder="联系电话">
            </div>
        </div>
    </form>
</body>
</html>
