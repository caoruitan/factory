<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.cd.login.LoginSessionKey"%>
<%@ page import="com.cd.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<c:forEach var="user" items="${gridData.list}" varStatus="status">
    <tr>
        <td>
            <c:if test="${status.index eq 0}">
            <input type="hidden" class="total" value="${gridData.total}"></input>
            </c:if>
            ${user.userName}
        </td>
        <td>${user.loginName}</td>
        <td>
            <c:if test="${user.sex eq 1}">男</c:if>
            <c:if test="${user.sex eq 2}">女</c:if>
        </td>
        <td>${user.university}</td>
        <td>${user.title}</td>
        <td>${user.phoneNumber}</td>
        <td>
            <a class="btn btn-mini btn-info" href="javascript:updateUser('${user.userId}')"><i class="icon-pencil icon-white"></i> 编辑</a>
            <a class="btn btn-mini btn-info" href="javascript:resetPassword('${user.userId}')"><i class="icon-wrench icon-white"></i> 重置密码</a>
            <a class="btn btn-mini btn-info" href="javascript:setPrivilege('${user.userId}')"><i class="icon-th-list icon-white"></i> 授权</a>
            <a class="btn btn-mini btn-danger" href="javascript:deleteUser('${user.userId}')"><i class="icon-trash icon-white"></i> 删除</a>
        </td>
    </tr>
</c:forEach>
