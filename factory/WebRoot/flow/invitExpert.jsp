<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="d" tagdir="/WEB-INF/tags/uiframe" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>邀请专家审核</title>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#invitExpertForm').validate({
                submitHandler : function() {
                    $.ajax({
                        type : 'POST',
                        url : '${basePath}/flowinstance/invitExpert.action',
                        data : $("#invitExpertForm").serialize(),
                        dataType : 'json',
                        success : function(data) {
                            $("#invitExpertModal").modal('hide');
                            window.location.reload();
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
    <form class="form-horizontal" method="post" name="invitExpertForm" id="invitExpertForm">
        <input type="hidden" name="stepInstanceId" value="${stepInstanceId}"/>
        <table class="table table-hover table-condensed">
            <thead>
                <tr>
                    <th>选择</th>
                    <th>专家</th>
                    <th>毕业院校</th>
                    <th>职称</th>
                    <th>联系电话</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${userList}" var="user">
                    <tr>
                        <td><input type="checkbox" name="expert" value="${user.userId}"></td>
                        <td>${user.userName}</td>
                        <td>${user.university}</td>
                        <td>${user.title}</td>
                        <td>${user.phoneNumber}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>
</body>
</html>
