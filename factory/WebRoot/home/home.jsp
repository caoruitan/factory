<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>home</title>
</head>
<body>
<div class="container" style="margin-top:15px;">
    <div class="row-fluid">
        <div class="span6 offset1">
            <table class="table table-bordered table-condensed">
                <thead>
                    <tr><th class="panel-header">我下载的数据</th></tr>
                </thead>
                <tbody>
                    <tr><td>
                        <div style="height:500px;"></div>
                    </td></tr>
                </tbody>
            </table>
        </div>
        <div class="span4">
            <table class="table table-bordered table-condensed">
                <thead>
                    <tr><th class="panel-header">我上传的数据</th></tr>
                </thead>
                <tbody>
                    <tr><td>
                        <div style="height:220px;"></div>
                    </td></tr>
                </tbody>
            </table>
            <table class="table table-bordered table-condensed">
                <thead>
                    <tr><th class="panel-header">我的数据审核</th></tr>
                </thead>
                <tbody>
                    <tr><td>
                        <div style="height:220px;"></div>
                    </td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
