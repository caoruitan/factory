<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    String parentId = request.getParameter("parentId");
    request.setAttribute("parentId", parentId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>部门</title>
<script type="text/javascript">
    $(document).ready(function(){
        // 添加部门表单验证
        $('#createDepForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/createDepartment.action',
                    data : $("#createDepForm").serialize(),
                    dataType : 'json',
                    success : function() {
                        $("#createDepModal").modal('hide');
                        var treeObj = $.fn.zTree.getZTreeObj("depTree");
                        var treeNode = treeObj.getSelectedNodes()[0];
                        treeNode.isParent = true;
                        treeObj.reAsyncChildNodes(treeNode, "refresh");
                    }
                });
            },
            rules: {
                departmentName: {
                    required: true
                }
            },
            highlight: function(element) {
                $(element).closest('.control-group').removeClass('success').addClass('error');
            },
            success: function(element) {
                element.addClass('valid').closest('.control-group').removeClass('error').addClass('success');
            }
        });
    });
</script>
</head>
<body>
    <form class="form-horizontal" method="post" action="<%=basePath%>/user/createDep.action" name="createDepForm" id="createDepForm">
        <input type="hidden" name="parentId" id="parentId" value="${parentId}">
        <div class="control-group">
            <label class="control-label" for="departmentName">名称</label>
            <div class="controls">
                <input type="text" name="departmentName" id="departmentName" placeholder="名称">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="description">描述</label>
            <div class="controls">
                <textarea rows="3" name="description" id="description" placeholder="描述"></textarea>
            </div>
        </div>
    </form>
</body>
</html>
