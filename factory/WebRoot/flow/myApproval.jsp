<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags/uiframe" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>数据审核</title>
</head>
<body>
    <script type="text/javascript">
        // 审核按钮响应事件（按钮在列表中）
        var approval = function(stepInstanceId) {
            window.location = "toApproval.sitemesh?currentMenu=myApproval&stepInstanceId=" + stepInstanceId
        }
    </script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div class="span12">
                <d:grid id="myApprovalGrid" start="0" limit="10" loadurl="${basePath}/flowinstance/myApprovalGrid.action">
                    <jsp:attribute name="tbar"></jsp:attribute>
                    <jsp:attribute name="thead">
                        <th>审核数据</th>
                        <th>审批步骤</th>
                        <th>提交时间</th>
                        <th>审核时间</th>
                        <th>审核状态</th>
                        <th>操作</th>
                    </jsp:attribute>
                </d:grid>
            </div>
        </div>
    </div>
</body>
</html>
