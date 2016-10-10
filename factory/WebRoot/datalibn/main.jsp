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
    <title>数据库管理</title>
    <link href="<%=basePath%>/datalib/css/form.css" rel="stylesheet" media="screen"/>
    <style type="text/css">
	th{
		background-color: #E7E7E7;
		text-align: center;
	}
  </style>
</head>
<body>
    <script type="text/javascript">
        $(function() {
             // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#createDataLibModal").on("hidden", function() {
                $(this).removeData("modal");
            });
             
            // 创建数据按钮事件
            $("#createDataLibBtn").on("click", function() {
                $("#createDataLibModal").modal({
                    backdrop : true,
                    keyboard : false,
                    show : true,
                    remote : "createDataLib.jsp?libType=${param.currentMenu}"
                });
            });
            
            // 创建数据表单保存按钮事件
            $("#createDataLibSaveBtn").on("click", function() {
                $("#createDataLibForm").submit();
            });
            
             // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#searchDataLibModal").on("hidden", function() {
                $(this).removeData("modal");
            });
             
            // 查询数据按钮事件
            $("#searchDataLibBtn").on("click", function() {
                $("#searchDataLibModal").modal({
                    backdrop : true,
                    keyboard : false,
                    show : true,
                    remote : "searchDataLib.jsp?libType=${param.currentMenu}"
                });
            });
            
            // 查询数据表单保存按钮事件
            $("#searchDataLibSaveBtn").on("click", function() {
                $("#searchDataLibForm").submit();
            });

            
            
            ///////////////////////////////
            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#updateDataLibModal").on("hidden", function() {
                $(this).removeData("modal");
            });

            // 修改用户表单保存按钮事件
            $("#updateDataLibSaveBtn").on("click", function() {
                $("#updateDataLibForm").submit();
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#setPrivilegeModal").on("hidden", function() {
                $(this).removeData("modal");
            });

            // 送审按钮事件
            $("#sendApprovalSaveBtn").on("click", function() {
                $("#sendApprovalForm").submit();
            });

            // 每次隐藏时，清除界面内容，下次打开重新加载
            $("#approvalHistoryModal").on("hidden", function() {
                $(this).removeData("modal");
            });
        });
        
        // 修改数据按钮响应事件（按钮在列表中）
        var updateDataLib = function(dataLibId) {
            $("#updateDataLibModal").modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "toUpdateDataLib.action?id=" + dataLibId
            });
        }
        
        // 送审按钮响应事件（按钮在列表中）
        var sendApproval = function(dataLibId) {
            $("#sendApprovalModal").modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "<%=basePath%>/flowinstance/toSendApproval.action?database=${param.currentMenu}&dataId=" + dataLibId
            });
        }

        // 删除数据按钮相应事件（按钮在列表中）
        var deleteDataLib = function(dataLibId) {
            $.messager.model = { 
                ok : { text: "确定", classed: 'btn-primary'},
                cancel : { text: "取消", classed: 'btn-default'}
            };
            $.messager.confirm("确认", "确定要删除这个数据吗？删除后不可恢复。", function() { 
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/datalib/deleteDataLib.action',
                    data : {id : dataLibId},
                    dataType : 'json',
                    success : function() {
                        grid.reload();
                    }
                });
            });
        }

        // 审批进度按钮事件（按钮在列表中）
        function approvalHistory(obj, dataId, database) {
            $("#approvalHistoryModal").modal({
                backdrop : true,
                keyboard : false,
                show : true,
                remote : "<%=basePath%>/flowinstance/approvalHistory.action?database=" + database + "&dataId=" + dataId
            });
        }
    </script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div id="gridDiv">
                <d:ScrollGrid id="dataLibGrid" start="0" limit="10" width="2800" loadurl="${basePath}/datalib/dataLibGrid.action?libType=${param.currentMenu}">
                    <jsp:attribute name="tbar">
                        <th colspan="31">
                            <a id="createDataLibBtn" class="btn btn-small btn-info" href="#"><i class="icon-plus icon-white"></i>新建</a>
                            <a id="searchDataLibBtn" class="btn btn-small btn-info" href="#"><i class="icon-search icon-white"></i>查询</a>
                        </th>
                    </jsp:attribute>
                    <jsp:attribute name="thead">
                        <th width="60" style="text-align:center;">反应物</th>
                        <th width="60" style="text-align:center;">国别</th>
                        <th width="60" style="text-align:center;">地区</th>
                        <th width="60" style="text-align:center;">名称</th>
                        <th width="170" style="text-align:center;">物性参数</th>
                        
                        <th width="80" style="text-align:center;">仪器名称</th>
                        <th width="80" style="text-align:center;">仪器厂商</th>
                        <th width="80" style="text-align:center;">仪器型号</th>
                        <th width="80" style="text-align:center;">实验方法</th>
                        <th width="100" style="text-align:center;">检测手段</th>
                        
                        <th width="70" style="text-align:center;">样品量</th>
                        <th width="150" style="text-align:center;">升温程序</th>
                        <th width="250" style="text-align:center;">气氛组成</th>
                        <th width="100" style="text-align:center;">气体流量</th>
                        <th width="100" style="text-align:center;">催化剂种类</th>
                        <th width="80" style="text-align:center;">反应温度</th>
                        <th width="80" style="text-align:center;">反应时间</th>
                        <th width="80" style="text-align:center;">负压</th>
                        <th width="80" style="text-align:center;">偏压</th>
                        
                        <th width="120" style="text-align:center;">解析方法</th>
                        <th width="200" style="text-align:center;">图表</th>
                        <th width="100" style="text-align:center;">活化能</th>
                        <th width="100" style="text-align:center;">指前因子</th>
                        <th width="100" style="text-align:center;">反应级数</th>
                        <th width="350" style="text-align:center;">原始数据</th>
                        
                        <th width="80" style="text-align:center;">作者</th>
                        <th width="120" style="text-align:center;">单位</th>
                        <th width="70" style="text-align:center;">上传时间</th>
                        <th width="100" style="text-align:center;">联系方式</th>
                        
                        <th width="180" style="text-align:center;">状态</th>
                        <th width="250" align="center" style="text-align:center;">操作</th>
                    </jsp:attribute>
                </d:ScrollGrid>
            </div>
        </div>
    </div>
    
    <!-- 创建用户窗口 -->
    <div id="createDataLibModal" class="modal hide fade"  tabindex="-1" role="dialog" aria-labelledby="createDataLibLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="createDataLibLabel">新建数据</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="createDataLibSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 查询用户窗口 -->
    <div id="searchDataLibModal" class="modal hide fade"  tabindex="-1" role="dialog" aria-labelledby="searchDataLibLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="searchDataLibLabel">查询数据</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="searchDataLibSaveBtn" class="btn btn-primary">确定</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
        </div>
    </div>
    
    <!-- 修改用户窗口 -->
    <div id="updateDataLibModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateDataLibLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="updateDataLibLabel">编辑数据</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="updateDataLibSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
    
    <!-- 送审窗口 -->
    <div id="sendApprovalModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="sendApprovalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="sendApprovalLabel">送审</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="sendApprovalSaveBtn" class="btn btn-primary">确定</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
        </div>
    </div>
    
    <!-- 审核进度窗口 -->
    <div id="approvalHistoryModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="approvalHistoryLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="approvalHistoryLabel">审核进度</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
        </div>
    </div>
</body>
</html>
