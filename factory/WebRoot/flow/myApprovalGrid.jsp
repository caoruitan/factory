<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<input type="hidden" class="total" value="${gridData.total}"></input>
<c:forEach var="step" items="${gridData.list}" varStatus="status">
    <tr>
        <td>${datalibs[status.index].thinKind}-${datalibs[status.index].age}-${datalibs[status.index].country}-${datalibs[status.index].district}</td>
        <td>${step.stepName}</td>
        <td><fmt:formatDate value="${step.receiveTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
        <td><fmt:formatDate value="${step.approvalTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
        <td>
            <c:if test='${step.status eq "READY"}'><span style="width:45px;text-align:center;" class="badge">未审核</span></c:if>
            <c:if test='${step.status eq "RUNNING"}'><span style="width:45px;text-align:center;" class="badge badge-success">审核中</span></c:if>
            <c:if test='${step.status eq "PASS"}'><span style="width:45px;text-align:center;" class="badge badge-info">通&nbsp;过</span></c:if>
            <c:if test='${step.status eq "UNPASS"}'><span style="width:45px;text-align:center;" class="badge badge-important">不通过</span></c:if>
        </td>
        <td>
            <c:if test='${step.status eq "RUNNING"}'>
                <a class="btn btn-mini btn-info" href="javascript:approval('${step.stepInstanceId}')"><i class="icon-pencil icon-white"></i> 审核</a>
            </c:if>
            <c:if test='${step.status eq "PASS"}'>
                <a class="btn btn-mini btn-info" href="javascript:approval('${step.stepInstanceId}')"><i class="icon-pencil icon-white"></i> 查看</a>
            </c:if>
            <c:if test='${step.status eq "UNPASS"}'>
                <a class="btn btn-mini btn-info" href="javascript:approval('${step.stepInstanceId}')"><i class="icon-pencil icon-white"></i> 查看</a>
            </c:if>
        </td>
    </tr>
</c:forEach>
