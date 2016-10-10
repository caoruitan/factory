<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.cd.login.LoginSessionKey"%>
<%@ page import="com.cd.user.User"%>
<%@ page import="com.cd.utils.MD5Util"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    String userId = request.getParameter("userId");
    request.setAttribute("userId", userId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改密码</title>
<script type="text/javascript">
    $(document).ready(function(){
        $.validator.addMethod("isNewPasswordSame", function(value, element) {
            var password1 = $("#password1").val();
            var password2 = $("#password2").val();
            return password1 == password2;
        }, "两次密码输入不一致，请重新输入");
        $.validator.addMethod("isNewAndOldPasswordNotSame", function(value, element) {
            var password = $("#password").val();
            var password1 = $("#password1").val();
            return password != password1;
        }, "新密码不能与原密码相同");
        
        // 修改密码表单验证
        $('#updatePasswordForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    data : $("#updatePasswordForm").serialize(),
                    url : '${basePath}/user/updatePassword.action',
                    dataType : 'json',
                    success : function(obj) {
                        if(obj.success == true) {
                            $("#updatePasswordModal").modal('hide');
                            alert("密码修改成功，请重新登录！");
                            window.location.href = "${basePath}/login/doLogout.action";
                        } else {
                            alert(obj.msg);
                        }
                    }
                });
            },
            rules: {
                password: {
                    required: true
                },
                password1: {
                    required : true,
                    isNewAndOldPasswordNotSame : true
                },
                password2: {
                    required: true,
                    isNewPasswordSame : true
                }
            },
            messages: {  
                password : "请输入旧密码",
                password1 : {  
                    required : "请输入新密码",
                    isNewAndOldPasswordNotSame : "新密码不能与原密码相同"
                },  
                password2 : {  
                    required : "请再次输入新密码",  
                    isNewPasswordSame : "两次密码输入不一致，请重新输入"
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
    <form class="form-horizontal" method="post" action="<%=basePath%>/user/updatePassword.action" name="updatePasswordForm" id="updatePasswordForm">
        <input type="hidden" name="userId" id="userId" value="${userId}">
        <div class="control-group">
            <label class="control-label" for="password">旧密码</label>
            <div class="controls">
                <input type="password" name="password" id="password" placeholder="旧密码">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="password1">新密码</label>
            <div class="controls">
                <input type="password" name="password1" id="password1" placeholder="新密码">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="password2">密码确认</label>
            <div class="controls">
                <input type="password" name="password2" id="password2" placeholder="密码确认">
            </div>
        </div>
    </form>
</body>
</html>
