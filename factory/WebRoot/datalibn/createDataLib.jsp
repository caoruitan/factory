<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.cd.login.LoginSessionKey"%>
<%@ page import="com.cd.login.LoginUser"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    
    LoginUser user = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
    String currentUser  = user.getUserName();
    String currentTime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    pageContext.setAttribute("userName", currentUser);
    pageContext.setAttribute("currentTime", currentTime);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>新建数据</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload.css" rel="stylesheet" media="screen"/>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload-ui.css" rel="stylesheet" media="screen"/>
</head>
<body>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.iframe-transport.js"></script>
<script type="text/javascript">
    $(function() {
        $('#datetimepicker').datetimepicker({
            format: 'yyyy-MM-dd',
            language: 'zh-CN',
            pickDate: true,
            pickTime: true,
            hourStep: 1,
            minuteStep: 15,
            secondStep: 30,
            inputMask: true
        });
        
        var wxcsIdx = 'physicalParam';
        $("#physicalParamFileuploadFile").fileupload({
            url: '${basePath}/attachment/uploadFile.action',
            sequentialUploads: false,
            singleFileUploads: false,
            limitMultiFileUploads: 10,
            limitMultiFileUploadSize: 512,
        }).bind('fileuploadsend', function(e, data) {
            var sizeText = "";
            var size = data.originalFiles[0].size/(1024 * 1024 * 1024);
            if(size < 1) {
                size = data.originalFiles[0].size/(1024 * 1024);
                if(size < 1) {
                    size = data.originalFiles[0].size/(1024);
                    if(size < 1) {
                        size = data.originalFiles[0].size;
                        sizeText = Math.round(size) + "B";
                    } else {
                        sizeText = Math.round(size) + "K";
                    }
                } else {
                    sizeText = Math.round(size) + "M";
                }
            } else {
                sizeText = Math.round(size) + "G";
            }

            var text = "<tr id='fileTr" + wxcsIdx + "'><td id='fileName" + wxcsIdx + "' style='width:50%'>" + data.originalFiles[0].name + "</td><td style='width:20%'><div style='width:100%;height:16px;border:1px solid #04c'><div id='progressBar" + wxcsIdx + "' style='width:0%;height:16px;background:#006dcc'></div></div></td><td style='width:10%'><span style='float:right' id='progressLabel" + wxcsIdx + "'></span></td><td style='width:10%'>" + sizeText + "</td><td><a href='#' onclick='javascript:$(\"#fileTr" + wxcsIdx + "\").remove();'>删除</a></td></tr>"
            $("#physicalParamFileUploadGrid").html(text);
        }).bind('fileuploadprogress', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $("#progressBar" + wxcsIdx).css('width', progress + '%');
            $("#progressLabel" + wxcsIdx).html(progress + '%');
        }).bind('fileuploaddone', function (e, data) {
            eval('var rs = ' + data.result);
            var fileName = rs.attachment.fileName;
            var fileId = rs.attachment.fileId;
            var download = "<a href='${basePath}/attachment/downloadFile.action?fileId=" + fileId + "'>" + fileName + "</a>";
            var hidden = "<input type='hidden' name='physicalParamFileId' value='" + fileId + "'/>";
            $("#fileName" + wxcsIdx).html(download + hidden);
        });
        
        var tbIdx = 'chart';
        $("#chartFileuploadFile").fileupload({
            url: '${basePath}/attachment/uploadFile.action',
            sequentialUploads: false,
            singleFileUploads: false,
            limitMultiFileUploads: 10,
            limitMultiFileUploadSize: 512,
        }).bind('fileuploadsend', function(e, data) {
            var sizeText = "";
            var size = data.originalFiles[0].size/(1024 * 1024 * 1024);
            if(size < 1) {
                size = data.originalFiles[0].size/(1024 * 1024);
                if(size < 1) {
                    size = data.originalFiles[0].size/(1024);
                    if(size < 1) {
                        size = data.originalFiles[0].size;
                        sizeText = Math.round(size) + "B";
                    } else {
                        sizeText = Math.round(size) + "K";
                    }
                } else {
                    sizeText = Math.round(size) + "M";
                }
            } else {
                sizeText = Math.round(size) + "G";
            }

            var text = "<tr id='fileTr" + tbIdx + "'><td id='fileName" + tbIdx + "' style='width:50%'>" + data.originalFiles[0].name + "</td><td style='width:20%'><div style='width:100%;height:16px;border:1px solid #04c'><div id='progressBar" + tbIdx + "' style='width:0%;height:16px;background:#006dcc'></div></div></td><td style='width:10%'><span style='float:right' id='progressLabel" + tbIdx + "'></span></td><td style='width:10%'>" + sizeText + "</td><td><a href='#' onclick='javascript:$(\"#fileTr" + tbIdx + "\").remove();'>删除</a></td></tr>"
            $("#chartFileUploadGrid").html(text);
        }).bind('fileuploadprogress', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $("#progressBar" + tbIdx).css('width', progress + '%');
            $("#progressLabel" + tbIdx).html(progress + '%');
        }).bind('fileuploaddone', function (e, data) {
            eval('var rs = ' + data.result);
            var fileName = rs.attachment.fileName;
            var fileId = rs.attachment.fileId;
            var download = "<a href='${basePath}/attachment/downloadFile.action?fileId=" + fileId + "'>" + fileName + "</a>";
            var hidden = "<input type='hidden' name='chartFileId' value='" + fileId + "'/>";
            $("#fileName" + tbIdx).html(download + hidden);
        });
        
        var yssjIdx = 0;
        $("#originalDataFileuploadFile").fileupload({
            url: '${basePath}/attachment/uploadFile.action',
            sequentialUploads: false,
            singleFileUploads: false,
            limitMultiFileUploads: 10,
            limitMultiFileUploadSize: 512,
        }).bind('fileuploadsend', function(e, data) {
            var sizeText = "";
            var size = data.originalFiles[0].size/(1024 * 1024 * 1024);
            if(size < 1) {
                size = data.originalFiles[0].size/(1024 * 1024);
                if(size < 1) {
                    size = data.originalFiles[0].size/(1024);
                    if(size < 1) {
                        size = data.originalFiles[0].size;
                        sizeText = Math.round(size) + "B";
                    } else {
                        sizeText = Math.round(size) + "K";
                    }
                } else {
                    sizeText = Math.round(size) + "M";
                }
            } else {
                sizeText = Math.round(size) + "G";
            }

            yssjIdx = yssjIdx + 1;
            var text = "<tr id='fileTr" + yssjIdx + "'><td id='fileName" + yssjIdx + "' style='width:50%'>" + data.originalFiles[0].name + "</td><td style='width:20%'><div style='width:100%;height:16px;border:1px solid #04c'><div id='progressBar" + yssjIdx + "' style='width:0%;height:16px;background:#006dcc'></div></div></td><td style='width:10%'><span style='float:right' id='progressLabel" + yssjIdx + "'></span></td><td style='width:10%'>" + sizeText + "</td><td><a href='#' onclick='javascript:$(\"#fileTr" + yssjIdx + "\").remove();'>删除</a></td></tr>"
            $("#originalDataFileUploadGrid").append(text);
        }).bind('fileuploadprogress', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $("#progressBar" + yssjIdx).css('width', progress + '%');
            $("#progressLabel" + yssjIdx).html(progress + '%');
        }).bind('fileuploaddone', function (e, data) {
            eval('var rs = ' + data.result);
            var fileName = rs.attachment.fileName;
            var fileId = rs.attachment.fileId;
            var download = "<a href='${basePath}/attachment/downloadFile.action?fileId=" + fileId + "'>" + fileName + "</a>";
            var hidden = "<input type='hidden' name='originalDataFileIdStr' value='" + fileId + "'/>";
            $("#fileName" + yssjIdx).html(download + hidden);
        });
        
        $('#createDataLibForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/datalib/createDataLib.action',
                    data : $("#createDataLibForm").serialize(),
                    dataType : 'json',
                    success : function(data) {
                        $("#createDataLibModal").modal('hide');
                        if(data.success == true) {
                        	window.location.reload();
                            // grid.reload();
                        } else {
                            $.messager.alert("提示", data.msg);
                        }
                    }
                });
            },
            rules: {
            	country:{
            		required:true,
                    maxlength : 50
            	},
            	district:{
            		required:true,
                    maxlength : 50
            	},
            	age:{
            		required:true,
                    maxlength : 50
            	},
            	
            	instrumentName:{
            		required:true,
                    maxlength : 50
            	},
            	testMethod:{
            		required:true,
                    maxlength : 50
            	},
            	testWay:{
            		required:true,
                    maxlength : 50
            	},

            	sampleQuantity:{
            		required:true,
            		number:true,
                    maxlength : 25
            	},
            	riseProgram:{
            		required:true,
                    maxlength : 50
            	},
            	auraForm:{
            		required:true,
                    maxlength : 50
            	},
            	auraRate:{
            		required:true,
            		number:true,
                    maxlength : 25
            	},
            	catalystKind:{
            		required:true
            	},
            	reactiont:{
            		number:true,
                    maxlength : 25
            	},
            	reactionTime:{
            		number:true,
                    maxlength : 25
            	},
            	negativePressure:{
            		number:true,
                    maxlength : 25
            	},
            	forwardPressure:{
            		number:true,
                    maxlength : 25
            	},
            	
            	btnUploadFile:{
            		required:true
            	},
            	activationEnergy:{
            		required:true,
            		number:true,
                    maxlength : 25
            	},
            	preExponentialFactor:{
            		required:true,
            		number:true,
                    maxlength : 25
            	},
            	reactionOrder:{
            		required:true,
            		number:true,
                    maxlength : 25
            	},
            	
                author: {
                    required: true,
                    maxlength : 50
                },
                org:{
            		required:true,
                    maxlength : 100
            	},
            	uploadTime:{
            		required:true,
                    maxlength : 50
            	},
            	linkInfo:{
            		required:true,
                    maxlength : 50
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
<div class="container" style="margin-top:15px;">
    <div class="row-fluid">
        <div class="span8 offset2">
            <form class="form-horizontal" action="#" method="post" name="createDataLibForm" id="createDataLibForm" enctype="multipart/form-data">
                <input id="libType" name="libType" type="hidden" value="${param.libType}" />
                <input id="status" name="status" type="hidden" value="编辑中" />
                <fieldset>
                    <legend><i class="icon-tasks icon-black" style="line-height:40px"></i> 反应物</legend>
                    <div class="control-group">
                        <label class="control-label" for="thinKind">类别</label>
                        <div class="controls">
                            <select id='thinKind' name="thinKind">
                                <option value="煤">煤</option>
                                <option value="稻壳">稻壳</option>
                                <option value="药渣">药渣</option>
                                <option value="矿物盐">矿物盐</option>
                                <option value="石油">石油</option>
                                <option value="碳纳米管">碳纳米管</option>
                                <option value="类金刚石薄膜">类金刚石薄膜</option>
                                <option value="氟碳薄膜">氟碳薄膜</option>
                                <option value="其他">其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="country">国别</label>
                        <div class="controls">
                            <input id="country" name="country" type="text" placeholder="国别"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="district">地区</label>
                        <div class="controls">
                            <input id="district" name="district" type="text" placeholder="地区"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="age">名称</label>
                        <div class="controls">
                            <input id="age" name="age" type="text" placeholder="名称"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="physicalParam">物性参数</label>
                        <div class="controls">
                            <input class="btn btn-primary" type="button" value="上传附件" onclick="document.getElementById('physicalParamFileuploadFile').click()"></input>
                            <input id="physicalParamFileuploadFile" name="uploadFile" type="file" style="display:none;"/>
                        </div>
                    </div>
                    <div class="control-group">
                          <div style="width:90%;float:right;">
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th colspan="2">上传进度</th>
                                        <th>大小</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="physicalParamFileUploadGrid"></tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试方法</legend>
                    <div class="control-group">
                        <label class="control-label" for="instrumentName">仪器名称</label>
                        <div class="controls">
                            <input id='instrumentName' name="instrumentName" type="text" placeholder="仪器名称"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentVendor">仪器厂商</label>
                        <div class="controls">
                            <input id='instrumentVendor' name="instrumentVendor" type="text" placeholder="仪器厂商"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentType">仪器型号</label>
                        <div class="controls">
                            <input id='instrumentType' name="instrumentType" type="text" placeholder="仪器型号"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testMethod">实验方法</label>
                        <div class="controls">
                            <select id='testMethod' name="testMethod">
                                <option value="等温">等温</option>
                                <option value="非等温">非等温</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testWay">检测手段</label>
                        <div class="controls">
                            <select id='testWay' name="testWay">
                                <option value="质谱">质谱</option>
                                <option value="红外">红外</option>
                                <option value="TPD/TPR">TPD/TPR</option>
                                <option value="电化学">电化学</option>
                                <option value="TCD">TCD</option>
                            </select>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试条件</legend>
                    <div class="control-group">
                        <label class="control-label" for="sampleQuantity">样品量</label>
                        <div class="controls">
                            <input id="sampleQuantity" name="sampleQuantity" type="text" placeholder="样品量"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="riseProgram">升温程序</label>
                        <div class="controls">
                            <input id="riseProgram" name="riseProgram" type="text" placeholder="升温程序"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraForm">气氛组成</label>
                        <div class="controls">
                            <input id="auraForm" name="auraForm" type="text" placeholder="气氛组成"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraRate">气体流量</label>
                        <div class="controls">
                            <input id="auraRate" name="auraRate" type="text" placeholder="气体流量"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="catalystKind">催化剂种类</label>
                        <div class="controls">
                            <select id='catalystKind' name="catalystKind">
                                <option value="催化剂种类1">催化剂种类1</option>
                                <option value="催化剂种类2">催化剂种类2</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="reactiont">反应温度</label>
                        <div class="controls">
                            <input id="reactiont" name="reactiont" type="text" placeholder="反应温度"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="reactionTime">反应时间</label>
                        <div class="controls">
                            <input id="reactionTime" name="reactionTime" type="text" placeholder="反应时间"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="negativePressure">负压</label>
                        <div class="controls">
                            <input id="negativePressure" name="negativePressure" type="text" placeholder="负压"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="forwardPressure">偏压</label>
                        <div class="controls">
                            <input id="forwardPressure" name="forwardPressure" type="text" placeholder="偏压"/>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试结果</legend>
                    <div class="control-group">
                        <label class="control-label" for="analyzeMethod">动力学解析方法</label>
                        <div class="controls">
                            <select id="analyzeMethod" name="analyzeMethod">
                                <option value="等转化率法">等转化率法</option>
                                <option value="模型法">模型法</option>
                                <option value="以公式或图片形式上传">以公式或图片形式上传</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="chart">图表</label>
                        <div class="controls">
                            <input class="btn btn-primary" type="button" name="btnUploadFile" value="上传附件" onclick="document.getElementById('chartFileuploadFile').click()"></input>
                            <input id="chartFileuploadFile" name="uploadFile" type="file" style="display:none;"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div style="width:90%;float:right;">
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th colspan="2">上传进度</th>
                                        <th>大小</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="chartFileUploadGrid"></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="control-group" style="border:1px dashed #CDCDCD">
                        <div class="control-group">
                            <label class="control-label">实际数值</label>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="activationEnergy">活化能</label>
                            <div class="controls">
                                <input id="activationEnergy" name="activationEnergy" type="text" placeholder="活化能"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="preExponentialFactor">指前因子</label>
                            <div class="controls">
                                <input id="preExponentialFactor" name="preExponentialFactor" type="text" placeholder="指前因子"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="reactionOrder">反应级数</label>
                            <div class="controls">
                                <input id="reactionOrder" name="reactionOrder" type="text" placeholder="反应级数"/>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="originalData">原始数据</label>
                        <div class="controls">
                            <input id="fileupload" class="btn btn-primary" type="button" value="添加附件" onclick="document.getElementById('originalDataFileuploadFile').click()"></input>
                            <input id="originalDataFileuploadFile" name="uploadFile" type="file" style="display:none;"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <div style="width:90%;float:right;">
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th colspan="2">上传进度</th>
                                        <th>大小</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="originalDataFileUploadGrid"></tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 实验信息</legend>
                    <div class="control-group">
                        <label class="control-label" for="author">作者</label>
                        <div class="controls">
                            <input id="author" name="author" type="text" value="${userName }" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="org">单位</label>
                        <div class="controls">
                            <input id="org" name="org" type="text" placeholder="单位"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="uploadTime">上传时间</label>
                        <div class="controls">
                            <div id="datetimepicker" class="input-append date">
                                <input type="text" id="uploadTime" name="uploadTime" value="${currentTime }" class="add-on" style="width:209px; text-align:left;" readonly></input>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="linkInfo">联系方式</label>
                        <div class="controls">
                            <input id="linkInfo" name="linkInfo" type="text" placeholder="联系方式"/>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>
