<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户管理</title>
<script type="text/javascript">
    $(document).ready(function(){
        $('#setPrivilegeForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/setPrivilege.action',
                    data : $("#setPrivilegeForm").serialize(),
                    dataType : 'json',
                    success : function(data) {
                        $("#setPrivilegeModal").modal('hide');
                    }
                });
            }
        });
    });
</script>
</head>
<body>
    <form class="form-horizontal" method="post" name="setPrivilegeForm" id="setPrivilegeForm">
        <input type="hidden" name="userId" value="${userId}"/>
        <fieldset>
            <legend>系统管理 </legend>
            <label class="checkbox">用户管理 
                <c:set var="userPrivilege" value=""></c:set>
                <c:forEach items="${privileges}" var="privilege">
                    <c:if test='${privilege eq "SYSTEM_USER"}'>
                        <c:set var="userPrivilege" value="checked"></c:set>
                    </c:if>
                </c:forEach>
                <input type="checkbox" name="SYSTEM_USER" ${userPrivilege}>
            </label>
            <label class="checkbox">流程管理 
                <c:set var="flowPrivilege" value=""></c:set>
                <c:forEach items="${privileges}" var="privilege">
                    <c:if test='${privilege eq "SYSTEM_FLOW"}'>
                        <c:set var="flowPrivilege" value="checked"></c:set>
                    </c:if>
                </c:forEach>
                <input type="checkbox" name="SYSTEM_FLOW" ${flowPrivilege}>
            </label>
        </fieldset>
        <c:forEach items="${models}" var="model">
            <fieldset>
                <legend>${model.value} </legend>
                <label class="checkbox">数据审批 
                    <c:set var="approvalPrivilege" value=""></c:set>
                    <c:forEach items="${privileges}" var="privilege">
                        <c:set var="key" value="${model.key}_APPROVAL"></c:set>
                        <c:if test='${privilege eq key}'>
                            <c:set var="approvalPrivilege" value="checked"></c:set>
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="${model.key}_APPROVAL" ${approvalPrivilege}>
                </label>
                <label class="checkbox">专家（审核）
                    <c:set var="expertPrivilege" value=""></c:set>
                    <c:forEach items="${privileges}" var="privilege">
                        <c:set var="key" value="${model.key}_EXPERT"></c:set>
                        <c:if test='${privilege eq key}'>
                            <c:set var="expertPrivilege" value="checked"></c:set>
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="${model.key}_EXPERT" ${expertPrivilege}>
                </label>
                <label class="checkbox">数据查看 
                    <c:set var="viewPrivilege" value=""></c:set>
                    <c:forEach items="${privileges}" var="privilege">
                        <c:set var="key" value="${model.key}_VIEW"></c:set>
                        <c:if test='${privilege eq key}'>
                            <c:set var="viewPrivilege" value="checked"></c:set>
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="${model.key}_VIEW" ${viewPrivilege}>
                </label>
                <label class="checkbox">数据下载 
                    <c:set var="downloadPrivilege" value=""></c:set>
                    <c:forEach items="${privileges}" var="privilege">
                        <c:set var="key" value="${model.key}_DOWNLOAD"></c:set>
                        <c:if test='${privilege eq key}'>
                            <c:set var="downloadPrivilege" value="checked"></c:set>
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="${model.key}_DOWNLOAD" ${downloadPrivilege}>
                </label>
                <label class="checkbox">数据上传 
                    <c:set var="uploadPrivilege" value=""></c:set>
                    <c:forEach items="${privileges}" var="privilege">
                        <c:set var="key" value="${model.key}_UPLOAD"></c:set>
                        <c:if test='${privilege eq key}'>
                            <c:set var="uploadPrivilege" value="checked"></c:set>
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="${model.key}_UPLOAD" ${uploadPrivilege}>
                </label>
            </fieldset>
        </c:forEach>
    </form>
</body>
</html>