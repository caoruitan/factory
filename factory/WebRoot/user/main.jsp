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
    <title>用户管理</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/ztree/css/zTreeStyle.css" rel="stylesheet" media="screen"/>
</head>
<body>
    <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/ztree/js/jquery.ztree.all-3.5.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/ztree/js/jquery.ztree.exhide-3.5.min.js"></script>
    <script type="text/javascript">
        $(function() {
            // 初始化部门树
            var setting = {
                async: {
                    enable : true,
                    url : "<%=basePath%>/user/getDepartments.action",
                    autoParam : ["id", "name"]
                },
                callback : {
                    onClick : function(event, treeId, treeNode, clickFlag) {
                        var treeObj = $.fn.zTree.getZTreeObj("depTree");
                        var nodes = treeObj.getSelectedNodes();
                        grid.load({departmentId : nodes[0].id});
                    }
                }
            };
            $.fn.zTree.init($("#depTree"), setting, {id:'0', name:'组织管理', isParent:true, icon:"../uiframe/images/jsb.png"});
            var treeObj = $.fn.zTree.getZTreeObj("depTree");
            treeObj.selectNode(treeObj.getNodes()[0]);
            treeObj.expandNode(treeObj.getNodes()[0]);
            $("#depTree").width($("#depTree").width());

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#createDepModal").on("hidden", function() {
                $(this).removeData("modal");
            });
            // 创建部门按钮事件
            $("#createDepBtn").on("click", function() {
                var treeObj = $.fn.zTree.getZTreeObj("depTree");
                var nodes = treeObj.getSelectedNodes();
                if(nodes.length == 0) {
                    $.messager.alert("提示", "请选择一个部门添加子部门!");
                    return;
                }
                $("#createDepModal").modal({
                    backdrop : true,
                    keyboard : false,
                    show : true,
                    remote : "createDep.jsp?parentId=" + nodes[0].id
                });
            });
            // 创建部门表单保存按钮事件
            $("#createDepSaveBtn").on("click", function() {
                $("#createDepForm").submit();
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#updateDepModal").on("hidden", function() {
                $(this).removeData("modal");
            });
            // 修改部门按钮事件
            $("#updateDepBtn").on("click", function() {
                var treeObj = $.fn.zTree.getZTreeObj("depTree");
                var nodes = treeObj.getSelectedNodes();
                if(nodes.length == 0) {
                    $.messager.alert("提示", "请选择一个部门再进行编辑!");
                    return;
                }
                $("#updateDepModal").modal({
                    backdrop : true,
                    keyboard : false,
                    show : true,
                    remote : "toUpdateDepartment.action?departmentId=" + nodes[0].id
                });
            });

            // 修改部门表单保存按钮事件
            $("#updateDepSaveBtn").on("click", function() {
                $("#updateDepForm").submit();
            });

            // 删除部门按钮事件
            $("#deleteDepBtn").on("click", function() {
                var treeObj = $.fn.zTree.getZTreeObj("depTree");
                var nodes = treeObj.getSelectedNodes();
                if(nodes.length == 0) {
                    $.messager.alert("提示", "请选择一个部门再进行删除!");
                    return;
                }
                if(nodes[0].id == '0') {
                    $.messager.alert("提示", "顶层部门不能删除!");
                    return;
                }
                $.messager.model = { 
                    ok : { text: "确定", classed: 'btn-primary'},
                    cancel : { text: "取消", classed: 'btn-default'}
                };
                $.messager.confirm("确认", "确定要删除这个部门吗？部门删除后将不能恢复！", function() { 
                    $.ajax({
                        type : 'POST',
                        url : '${basePath}/user/deleteDepartment.action',
                        data : {departmentId : nodes[0].id},
                        dataType : 'json',
                        success : function(obj) {
                            if(obj.success) {
                                var treeObj = $.fn.zTree.getZTreeObj("depTree");
                                var parentNode = treeObj.getSelectedNodes()[0].getParentNode();
                                treeObj.reAsyncChildNodes(parentNode, "refresh");
                                treeObj.selectNode(parentNode);
                                grid.load({departmentId : parentNode.id});
                            } else {
                                $.messager.alert("提示", obj.msg);
                            }
                        }
                    });
                });
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#createUserModal").on("hidden", function() {
                $(this).removeData("modal");
            });
            // 创建用户按钮事件
            $("#createUserBtn").on("click", function() {
                var treeObj = $.fn.zTree.getZTreeObj("depTree");
                var nodes = treeObj.getSelectedNodes();
                if(nodes.length == 0) {
                    $.messager.alert("提示", "请先选择一个部门再添加用户!");
                    return;
                }
                if(nodes[0].id == 0) {
                    $.messager.alert("提示", "顶层部门不能创建用户!");
                    return;
                }
                $("#createUserModal").modal({
                    backdrop : true,
                    keyboard : false,
                    show : true,
                    remote : "createUser.jsp?departmentId=" + nodes[0].id
                });
            });
            // 创建用户表单保存按钮事件
            $("#createUserSaveBtn").on("click", function() {
                $("#createUserForm").submit();
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#updateUserModal").on("hidden", function() {
                $(this).removeData("modal");
            });

            // 修改用户表单保存按钮事件
            $("#updateUserSaveBtn").on("click", function() {
                $("#updateUserForm").submit();
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#setPrivilegeModal").on("hidden", function() {
                $(this).removeData("modal");
            });

            // 设置权限表单保存按钮事件
            $("#setPrivilegeSaveBtn").on("click", function() {
                $("#setPrivilegeForm").submit();
            });
        });
        
        // 修改用户按钮响应事件（按钮在列表中）
        var updateUser = function(userId) {
            $("#updateUserModal").modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "toUpdateUser.action?userId=" + userId
            });
        }
        
        // 授权按钮响应事件（按钮在列表中）
        var setPrivilege = function(userId) {
            $("#setPrivilegeModal").modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "toSetPrivilege.action?userId=" + userId
            });
        }

        // 删除用户按钮相应事件（按钮在列表中）
        var deleteUser = function(userId) {
            $.messager.model = { 
                ok : { text: "确定", classed: 'btn-primary'},
                cancel : { text: "取消", classed: 'btn-default'}
            };
            $.messager.confirm("确认", "确定要删除这个用户吗？用户删除后将不能恢复！", function() { 
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/deleteUser.action',
                    data : {userId : userId},
                    dataType : 'json',
                    success : function() {
                        grid.reload();
                    }
                });
            });
        }

        // 重置密码按钮相应事件（按钮在列表中）
        var resetPassword = function(userId) {
            $.messager.model = { 
                ok : { text: "确定", classed: 'btn-primary'},
                cancel : { text: "取消", classed: 'btn-default'}
            };
            $.messager.confirm("确认", "确认将该用户的密码重置为“123456”吗？", function() { 
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/user/resetPassword.action',
                    data : {userId : userId},
                    dataType : 'json',
                    success : function() {
                        grid.reload();
                    }
                });
            });
        }
        
    </script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div class="span3">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>
                                <a id="createDepBtn" class="btn btn-small btn-info" href="#"><i class="icon-plus icon-white"></i> 新建</a>
                                <a id="updateDepBtn" class="btn btn-small btn-info" href="#"><i class="icon-pencil icon-white"></i> 编辑</a>
                                <a id="deleteDepBtn" class="btn btn-small btn-danger" href="#"><i class="icon-trash icon-white"></i> 删除</a>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <ul id="depTree" class="ztree" style="overfolw-x:auto;overflow-y:hidden"></ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="span9" id="gridDiv">
                <d:grid id="userGrid" start="0" limit="10" loadurl="${basePath}/user/userGrid.action">
                    <jsp:attribute name="tbar">
                        <th colspan="5">
                            <a id="createUserBtn" class="btn btn-small btn-info" href="#"><i class="icon-plus icon-white"></i> 新建</a>
                        </th>
                    </jsp:attribute>
                    <jsp:attribute name="thead">
                        <th>姓名</th>
                        <th>登录名</th>
                        <th>性别</th>
                        <th>毕业院校</th>
                        <th>职称</th>
                        <th>联系电话</th>
                        <th>操作</th>
                    </jsp:attribute>
                </d:grid>
            </div>
        </div>
    </div>
    
    <!-- 创建用户窗口 -->
    <div id="createUserModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="createUserLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="createUserLabel">创建用户</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="createUserSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 修改用户窗口 -->
    <div id="updateUserModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateUserLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="updateUserLabel">编辑用户</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="updateUserSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 创建部门窗口 -->
    <div id="createDepModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="createDepLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="createDepLabel">创建部门</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="createDepSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 修改部门窗口 -->
    <div id="updateDepModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateDepLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="updateDepLabel">编辑部门</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="updateDepSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 授权窗口 -->
    <div id="setPrivilegeModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="setPrivilegeLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="setPrivilegeLabel">授权</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="setPrivilegeSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
</body>
</html>
