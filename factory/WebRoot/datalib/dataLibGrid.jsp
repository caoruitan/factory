<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<c:forEach var="dataLib" items="${gridData.list}" varStatus="status">
    <tr>
        <td>
            <c:if test="${status.index eq 0}">
            <input type="hidden" class="total" value="${gridData.total}"></input>
            </c:if>
            ${dataLib.thinKind }
        </td>
        <td>${dataLib.country}</td>
        <td>${dataLib.district}</td>
        <td>${dataLib.age}</td>
        <c:choose>
	        <c:when test="${canDownload }">
	        	<td><a href="${basePath }/attachment/downloadFile.sitemesh?fileId=${dataLib.physicalParamFileId }">${dataLib.physicalParamFileName}</a></td>
	        </c:when>
	        <c:otherwise>
	        	<td>${dataLib.physicalParamFileName}</td>
	        </c:otherwise>
        </c:choose>
        
        <td>${dataLib.instrumentName}</td>
        <td>${dataLib.instrumentVendor}</td>
        <td>${dataLib.instrumentType}</td>
        <td>${dataLib.testMethod}</td>
        <td>${dataLib.testWay}</td>
        
        <td>${dataLib.sampleQuantity}</td>
        <td>${dataLib.riseProgram}</td>
        <td>${dataLib.auraForm}</td>
        <td>${dataLib.auraRate}</td>
        
        <td>${dataLib.analyzeMethod}</td>
        <c:choose>
	        <c:when test="${canDownload }">
	        	<td><a href="${basePath }/attachment/downloadFile.sitemesh?fileId=${dataLib.chartFileId }">${dataLib.chartFileName}</a></td>
	        </c:when>
	        <c:otherwise>
        		<td>${dataLib.chartFileName}</td>
	        </c:otherwise>
        </c:choose>
        <td>${dataLib.activationEnergy}</td>
        <td>${dataLib.preExponentialFactor}</td>
        <td>${dataLib.reactionOrder}</td>
        <c:choose>
	        <c:when test="${canDownload }">
	        	<td><a href="${basePath }/attachment/downloadFileByZip.sitemesh?fileIds=${dataLib.originalDataFileIds }">${dataLib.originalDataFileNames}</a></td>
	        </c:when>
	        <c:otherwise>
				<td>${dataLib.originalDataFileNames}</td>
	        </c:otherwise>
        </c:choose>
        
        <td>${dataLib.author}</td>
        <td>${dataLib.org}</td>
        <td><fmt:formatDate value="${dataLib.uploadTime}" type="date"/></td>
        <td>${dataLib.linkInfo}</td>
        
        <td>${dataLib.status}&nbsp;<a href="javascript:approvalHistory(this, '${dataLib.id}', '${dataLib.libType}')">审核进度</a></td>
        <td>
            <c:if test="${canUpload }">
            <a class="btn btn-mini btn-info" href="javascript:sendApproval('${dataLib.id}')"><i class="icon-upload icon-white"></i> 送审</a>
            </c:if>
            <a class="btn btn-mini btn-info" href="javascript:updateDataLib('${dataLib.id}')"><i class="icon-pencil icon-white"></i> 编辑</a>
            <a class="btn btn-mini btn-danger" href="javascript:deleteDataLib('${dataLib.id}')"><i class="icon-trash icon-white"></i> 删除</a>
        </td>
    </tr>
</c:forEach>
