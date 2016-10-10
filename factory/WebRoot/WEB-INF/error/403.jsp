<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    long uuid = new Date().getTime();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>拒绝访问</title>
</head>
<body>
<div id="error403">
    <div class="uiframe-pointPageLayout">
        <div class="uiframe-pointPage">
            <div class="uiframe-pointPageMain">
                <div class="uiframe-pointPageMain-title">对不起，您没有权限访问该页面</div>
                <div class="uiframe-pointPageMain-contant">对不起，您没有权限访问该页面</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>