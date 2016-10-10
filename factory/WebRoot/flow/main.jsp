<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cd.database.Database"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags/uiframe" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    Database database = ((List<Database>) request.getAttribute("databaseList")).get(0);
    request.setAttribute("firstDatabase", database);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>流程管理</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/silviomoreto-bootstrap/bootstrap-select.min.css" rel="stylesheet" media="screen"/>
</head>
<body>
    <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/silviomoreto-bootstrap/bootstrap-select.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=${firstDatabase.key}");
        });

        var clickDatabase = function(key) {
            $("#" + key).siblings(".active").removeClass('active');
            $("#" + key).addClass('active');
            $("#stepGridDiv").load("${basePath}/flow/stepGrid.action?database=" + key);
        }
    </script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div class="span3">
                <ul class="nav nav-list">
                    <li class="nav-header">数据库</li>
                    <c:forEach items="${databaseList}" var="database" varStatus="status">
                        <c:if test="${status.index eq 0}">
                            <li id="${database.key}" class="active"><a href="javascript:clickDatabase('${database.key}');">${database.name}</a></li>
                        </c:if>
                        <c:if test="${status.index > 0}">
                            <li id="${database.key}"><a href="javascript:clickDatabase('${database.key}');">${database.name}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="span9" id="stepGridDiv"></div>
        </div>
    </div>
</body>
</html>
