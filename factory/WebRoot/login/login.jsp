<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
        <title>登录</title>
        <link href="<%=basePath%>/login/css/login.css" rel="stylesheet" media="screen"/>
    </head>
    <body>
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/jquery-1.9.1.min.js"></script>
        <script type="text/javascript">
            function doLogin() {
                $.ajax({
                    type : 'POST',
                    url : '<%=basePath%>/login/doLogin.action',
                    data : $("#loginForm").serialize(),
                    dataType : 'json',
                    success : function(data) {
                        if(data.success == true) {
                            window.location.href = "<%=basePath%>" + data.url;
                        } else {
                            alert(data.msg);
                        }
                    }
                });
            }
        </script>
        <div id="container">
            <form id="loginForm" name="loginForm" method="post">
                <div class="login">登录</div>
                <div class="username-text">用户名:</div>
                <div class="password-text">密&nbsp;&nbsp;&nbsp;码:</div>
                <div class="username-field">
                    <input type="text" name="loginName"/>
                </div>
                <div class="password-field">
                    <input type="password" name="password"/>
                </div>
                <input type="button" name="button" onclick="doLogin()" value="登录" />
            </form>
        </div>
    </body>
</html>
