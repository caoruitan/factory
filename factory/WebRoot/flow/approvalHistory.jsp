<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cd.flow.FlowStepInstance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    List<FlowStepInstance> steps = (List<FlowStepInstance>) request.getAttribute("steps");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>数据审核进度</title>
</head>
<body>
<table class="table table-hover table-condensed">
    <thead>
        <tr>
            <th>序号</th>
            <th>步骤</th>
            <th>审批人</th>
            <th>接收时间</th>
            <th>审核时间</th>
            <th>状态</th>
            <th>审核意见</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${steps}" var="st">
            <c:if test='${st.stepType eq "1"}'>
                <tr>
                    <td>${st.stepNum}</td>
                    <td>${st.stepName}</td>
                    <td>${st.stepUserName}</td>
                    <td><fmt:formatDate value="${st.receiveTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                    <td><fmt:formatDate value="${st.approvalTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                    <td>
                        <c:if test='${st.status eq "READY"}'><span style="width:45px;text-align:center;" class="badge">未审核</span></c:if>
                        <c:if test='${st.status eq "RUNNING"}'><span style="width:45px;text-align:center;" class="badge badge-success">审核中</span></c:if>
                        <c:if test='${st.status eq "PASS"}'><span style="width:45px;text-align:center;" class="badge badge-info">通&nbsp;过</span></c:if>
                        <c:if test='${st.status eq "UNPASS"}'><span style="width:45px;text-align:center;" class="badge badge-important">不通过</span></c:if>
                    </td>
                    <td>${st.memo}</td>
                </tr>
            </c:if>
            <c:if test='${st.stepType eq "2"}'>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>专家</td>
                    <td><fmt:formatDate value="${st.receiveTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                    <td><fmt:formatDate value="${st.approvalTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                    <td>
                        <c:if test='${st.status eq "READY"}'><span style="width:45px;text-align:center;" class="badge">未审核</span></c:if>
                        <c:if test='${st.status eq "RUNNING"}'><span style="width:45px;text-align:center;" class="badge badge-success">审核中</span></c:if>
                        <c:if test='${st.status eq "PASS"}'><span style="width:45px;text-align:center;" class="badge badge-info">通&nbsp;过</span></c:if>
                        <c:if test='${st.status eq "UNPASS"}'><span style="width:45px;text-align:center;" class="badge badge-important">不通过</span></c:if>
                    </td>
                    <td>${st.memo}</td>
                </tr>
            </c:if>
        </c:forEach>
    </tbody>
</table>
</body>
</html>
