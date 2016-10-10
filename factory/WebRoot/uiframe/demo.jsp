<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>user</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/ztree/css/zTreeStyle.css" rel="stylesheet" media="screen"/>
</head>
<body>
    <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/ztree/js/jquery.ztree.all-3.5.min.js"></script>
    <script type="text/javascript">
        var setting = {
            async: {
                enable: true,
                url:"getNodes.json",
                autoParam:["id", "name", "level"]
            },
            callback : {
                onClick : function(event, treeId, treeNode, clickFlag) {
                    alert(treeNode.id + "aaaa" + treeNode.name)
                }
            }
        };

        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting);
            $('#addUserForm').validate({
                rules: {
                    username: {
                        required: true
                    },
                    loginname: {
                        required: true
                    },
                    role: {
                        required: true
                    }
                    sex: {
                        required: true
                    }
                    phone: {
                        required: true
                    }
                },
                highlight: function(element) {
                    $(element).closest('.control-group').removeClass('success').addClass('error');
                },
                success: function(element) {
                    element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
                }
            });
        });
        function openaaa() {
            $('#myModal').modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "add.jsp"
            });
        }
        function save() {
            $('#addUserForm').submit();
        }
    </script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div class="span3">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
            <div class="span9">
                <div class="alert" id="testAlert">
                    <button type="button" class="close" onclick="javascript:$('#testAlert').hide()">&times;</button>
                    Best check yo self, you're not...
                </div>
                <div class="datagrid-header-left">
                   <button type="button" class="btn" onclick="javascript:$('#testAlert').show()">提示</button>
                   <button type="button" class="btn" onclick="javascript:$('#testAlert').hide()">隐藏提示</button>
                </div>
                <hr/>
                <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="myModalLabel">新建用户</h3>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" onclick="save()">保存</button>
                        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
                    </div>
                </div>
                <div class="datagrid-header-left">
                    <a href="#myModal" role="button" class="btn" data-toggle="modal">查看演示案例</a>
                    <a data-toggle="modal" href="main.jsp" data-target="#myModal">baidu</a>
                   <button type="button" class="btn" onclick="openaaa()">打开提示窗口</button>
                   <button type="button" class="btn" onclick="javascript:$('#testAlert').hide()">隐藏提示窗口</button>
                </div>
                <hr/>
                <form class="form-horizontal" action="#" name="addUserForm" id="addUserForm">
                    <fieldset>
                        <legend>Sample Contact Form <small>(will not submit any information)</small></legend>
                        <div class="control-group">
                            <label class="control-label" for="username">姓名</label>
                            <div class="controls">
                                <input type="text" id="username" name="username" placeholder="姓名" check-type="required" required-message="邮箱格式不正确！">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="loginname">登录名</label>
                            <div class="controls">
                                <input type="text" id="loginname" name="loginname" placeholder="登录名">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="sex">性别</label>
                            <div class="controls">
                                <input type="text" id="sex" name="sex" placeholder="性别">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="email">邮箱</label>
                            <div class="controls">
                                <input type="text" id="email" name="email" check-type="mail" mail-message="邮箱格式不正确！">
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" onclick="save()" class="btn btn-primary">Submit</button>
                            <button type="reset" class="btn">Cancel</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
