<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>修改数据</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload.css" rel="stylesheet" media="screen"/>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload-ui.css" rel="stylesheet" media="screen"/>
</head>
<body>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.iframe-transport.js"></script>
<script type="text/javascript">
    $(function() {
        $('#datetimepicker2').datetimepicker({
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
        
        $('#updateDataLibForm').validate({
            submitHandler : function() {
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/datalib/updateDataLib.action',
                    data : $("#updateDataLibForm").serialize(),
                    dataType : 'json',
                    success : function() {
                        $("#updateDataLibModal").modal('hide');
                        grid.reload();
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
            <form class="form-horizontal" action="#" method="post" name="updateDataLibForm" id="updateDataLibForm" enctype="multipart/form-data">
                <input id="id" name="id" type="hidden" value="${dataLib.id}" />
                <input id="libType" name="libType" type="hidden" value="${dataLib.libType}" />
                <input id="status" name="status" type="hidden" value="${dataLib.status }" />
                <fieldset>
                    <legend><i class="icon-tasks icon-black" style="line-height:40px"></i> 反应物</legend>
                    <div class="control-group">
                        <label class="control-label" for="thinKind">类别</label>
                        <div class="controls">
                        	<select id='thinKind' name="thinKind">
                        		<c:if test="${dataLib.thinKind eq '煤' }">
	                                <option value="煤" selected="selected">煤</option>
	                                <option value="稻壳">稻壳</option>
	                                <option value="药渣">药渣</option>
	                                <option value="矿物盐">矿物盐</option>
	                                <option value="石油">石油</option>
	                                <option value="其他">其他</option>
                                </c:if>
                        		<c:if test="${dataLib.thinKind eq '稻壳' }">
	                                <option value="煤">煤</option>
	                                <option value="稻壳" selected="selected">稻壳</option>
	                                <option value="药渣">药渣</option>
	                                <option value="矿物盐">矿物盐</option>
	                                <option value="石油">石油</option>
	                                <option value="其他">其他</option>
                                </c:if>
                        		<c:if test="${dataLib.thinKind eq '药渣' }">
	                                <option value="煤">煤</option>
	                                <option value="稻壳">稻壳</option>
	                                <option value="药渣" selected="selected">药渣</option>
	                                <option value="矿物盐">矿物盐</option>
	                                <option value="石油">石油</option>
	                                <option value="其他">其他</option>
                                </c:if>
                        		<c:if test="${dataLib.thinKind eq '矿物盐' }">
	                                <option value="煤">煤</option>
	                                <option value="稻壳">稻壳</option>
	                                <option value="药渣">药渣</option>
	                                <option value="矿物盐" selected="selected">矿物盐</option>
	                                <option value="石油">石油</option>
	                                <option value="其他">其他</option>
                                </c:if>
                        		<c:if test="${dataLib.thinKind eq '石油' }">
	                                <option value="煤">煤</option>
	                                <option value="稻壳">稻壳</option>
	                                <option value="药渣">药渣</option>
	                                <option value="矿物盐">矿物盐</option>
	                                <option value="石油" selected="selected">石油</option>
	                                <option value="其他">其他</option>
                                </c:if>
                        		<c:if test="${dataLib.thinKind eq '其他' }">
	                                <option value="煤">煤</option>
	                                <option value="稻壳">稻壳</option>
	                                <option value="药渣">药渣</option>
	                                <option value="矿物盐">矿物盐</option>
	                                <option value="石油">石油</option>
	                                <option value="其他" selected="selected">其他</option>
                                </c:if>
                        	</select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="country">国别</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.country }">
                            	<input id="country" name="country" type="text" placeholder="国别" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.country }">
                            	<input id="country" name="country" type="text" value="${dataLib.country }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="district">地区</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.district }">
                            	<input id="district" name="district" type="text" placeholder="地区"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.district }">
                            	<input id="district" name="district" type="text" value="${dataLib.district }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="age">名称</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.age }">
                            	<input id="age" name="age" type="text" placeholder="名称"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.age }">
                            	<input id="age" name="age" type="text" value="${dataLib.age }"/>
                        	</c:if>
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
                                <tbody id="physicalParamFileUploadGrid">
                                	<c:if test="${not empty physicalParamFile }">
		                                <tr id='fileTr${dataLib.physicalParamFileId}'>
		            						<td id='fileName${dataLib.physicalParamFileId}' style='width:50%'>
		            							<a href='${basePath}/attachment/downloadFile.action?fileId=${dataLib.physicalParamFileId}'>${dataLib.physicalParamFileName}</a>
		            							<input type='hidden' name='physicalParamFileId' value='${dataLib.physicalParamFileId}'/>
		            						</td>
		            						<td style='width:20%'>
		            							<div style='width:100%;height:16px;border:1px solid #04c'>
		            								<div id='progressBar${dataLib.physicalParamFileId}' style='width:100%;height:16px;background:#006dcc'></div>
		            							</div>
		            						</td>
		            						<td style='width:10%'><span style='float:right' id='progressLabel${dataLib.physicalParamFileId}'>100%</span></td>
		            						<td style='width:10%'>${physicalParamFile.fileSize }</td>
		            						<td><a href='#' onclick='this.parentNode.parentNode.remove();'>删除</a></td>
	            					</tr>
	            					</c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试方法</legend>
                    <div class="control-group">
                        <label class="control-label" for="instrumentName">仪器名称</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.instrumentName }">
	                            <input id='instrumentName' name="instrumentName" type="text" placeholder="仪器名称"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.instrumentName }">
	                            <input id='instrumentName' name="instrumentName" type="text" value="${dataLib.instrumentName }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentVendor">仪器厂商</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.instrumentVendor }">
                            	<input id='instrumentVendor' name="instrumentVendor" type="text" placeholder="仪器厂商"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.instrumentVendor }">
                            	<input id='instrumentVendor' name="instrumentVendor" type="text" value="${dataLib.instrumentVendor }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentType">仪器型号</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.instrumentType }">
                            	<input id='instrumentType' name="instrumentType" type="text" placeholder="仪器型号" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.instrumentType }">
                            	<input id='instrumentType' name="instrumentType" type="text" value="${dataLib.instrumentType }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testMethod">实验方法</label>
                        <div class="controls">
                            <select id='testMethod' name="testMethod">
                                <c:if test="${dataLib.testMethod eq '等温' }">
	                                <option value="等温" selected="selected">等温</option>
	                                <option value="非等温">非等温</option>
                                </c:if>
                                <c:if test="${dataLib.testMethod eq '非等温' }">
	                                <option value="等温">等温</option>
	                                <option value="非等温" selected="selected">非等温</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testWay">检测手段</label>
                        <div class="controls">
                            <select id='testWay' name="testWay">
                                <c:if test="${dataLib.testWay eq '质谱' }">
	                                <option value="质谱" selected="selected">质谱</option>
	                                <option value="红外">红外</option>
	                                <option value="TPD/TPR">TPD/TPR</option>
	                                <option value="电化学">电化学</option>
	                                <option value="TCD">TCD</option>
                                </c:if>
                                <c:if test="${dataLib.testWay eq '红外' }">
	                                <option value="质谱">质谱</option>
	                                <option value="红外" selected="selected">红外</option>
	                                <option value="TPD/TPR">TPD/TPR</option>
	                                <option value="电化学">电化学</option>
	                                <option value="TCD">TCD</option>
                                </c:if>
                                <c:if test="${dataLib.testWay eq 'TPD/TPR' }">
	                                <option value="质谱">质谱</option>
	                                <option value="红外">红外</option>
	                                <option value="TPD/TPR" selected="selected">TPD/TPR</option>
	                                <option value="电化学">电化学</option>
	                                <option value="TCD">TCD</option>
                                </c:if>
                                <c:if test="${dataLib.testWay eq '电化学' }">
	                                <option value="质谱">质谱</option>
	                                <option value="红外">红外</option>
	                                <option value="TPD/TPR">TPD/TPR</option>
	                                <option value="电化学" selected="selected">电化学</option>
	                                <option value="TCD">TCD</option>
                                </c:if>
                                <c:if test="${dataLib.testWay eq 'TCD' }">
	                                <option value="质谱">质谱</option>
	                                <option value="红外">红外</option>
	                                <option value="TPD/TPR">TPD/TPR</option>
	                                <option value="电化学">电化学</option>
	                                <option value="TCD" selected="selected">TCD</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试条件</legend>
                    <div class="control-group">
                        <label class="control-label" for="sampleQuantity">样品量</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.sampleQuantity }">
                            	<input id="sampleQuantity" name="sampleQuantity" type="text" placeholder="样品量"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.sampleQuantity }">
                            	<input id="sampleQuantity" name="sampleQuantity" type="text" value="<fmt:formatNumber value="${dataLib.sampleQuantity}" pattern="#,##0.#"></fmt:formatNumber>"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="riseProgram">升温程序</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.riseProgram }">
                            	<input id="riseProgram" name="riseProgram" type="text" placeholder="升温程序" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.riseProgram }">
                            	<input id="riseProgram" name="riseProgram" type="text" value="${dataLib.riseProgram }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraForm">气氛组成</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.auraForm }">
                            	<input id="auraForm" name="auraForm" type="text" placeholder="气氛组成" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.auraForm }">
                            	<input id="auraForm" name="auraForm" type="text" value="${dataLib.auraForm }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraRate">气体流量</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.auraRate }">
                            	<input id="auraRate" name="auraRate" type="text" placeholder="气体流量" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.auraRate }">
                            	<input id="auraRate" name="auraRate" type="text" value="<fmt:formatNumber value="${dataLib.auraRate}" pattern="#,##0.#"></fmt:formatNumber>"/>
                        	</c:if>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试结果</legend>
                    <div class="control-group">
                        <label class="control-label" for="analyzeMethod">动力学解析方法</label>
                        <div class="controls">
                            <select id="analyzeMethod" name="analyzeMethod">
                                <c:if test="${dataLib.analyzeMethod eq '等转化率法' }">
	                                <option value="等转化率法" selected="selected">等转化率法</option>
	                                <option value="模型法">模型法</option>
	                                <option value="以公式或图片形式上传">以公式或图片形式上传</option>
	                            </c:if>
                                <c:if test="${dataLib.analyzeMethod eq '模型法' }">
	                                <option value="等转化率法">等转化率法</option>
	                                <option value="模型法" selected="selected">模型法</option>
	                                <option value="以公式或图片形式上传">以公式或图片形式上传</option>
	                            </c:if>
                                <c:if test="${dataLib.analyzeMethod eq '以公式或图片形式上传' }">
	                                <option value="等转化率法">等转化率法</option>
	                                <option value="模型法">模型法</option>
	                                <option value="以公式或图片形式上传" selected="selected">以公式或图片形式上传</option>
	                            </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="chart">图表</label>
                        <div class="controls">
                            <input class="btn btn-primary" type="button" value="上传附件" onclick="document.getElementById('chartFileuploadFile').click()"></input>
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
                                <tbody id="chartFileUploadGrid">
                                	<c:if test="${not empty chartFile }">
	                                	<tr id='fileTr${chartFile.fileId}'>
			            						<td id='fileName${chartFile.fileId}' style='width:50%'>
			            							<a href='${basePath}/attachment/downloadFile.action?fileId=${chartFile.fileId}'>${chartFile.fileName}</a>
			            							<input type='hidden' name='chartFileId' value='${chartFile.fileId}'/>
			            						</td>
			            						<td style='width:20%'>
			            							<div style='width:100%;height:16px;border:1px solid #04c'>
			            								<div id='progressBar${chartFile.fileId}' style='width:100%;height:16px;background:#006dcc'></div>
			            							</div>
			            						</td>
			            						<td style='width:10%'><span style='float:right' id='progressLabel${chartFile.fileId}'>100%</span></td>
			            						<td style='width:10%'>${chartFile.fileSize }</td>
			            						<td><a href='#' onclick='this.parentNode.parentNode.remove();'>删除</a></td>
			            				</tr>
		            				</c:if>
                                </tbody>
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
                            	<c:if test="${empty dataLib.activationEnergy }">
                                	<input id="activationEnergy" name="activationEnergy" type="text" placeholder="活化能" />
                            	</c:if>
                            	<c:if test="${not empty dataLib.activationEnergy }">
                                	<input id="activationEnergy" name="activationEnergy" type="text" value="<fmt:formatNumber value="${dataLib.activationEnergy}" pattern="#,##0.#"></fmt:formatNumber>"/>
                            	</c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="preExponentialFactor">指前因子</label>
                            <div class="controls">
                            	<c:if test="${empty dataLib.preExponentialFactor }">
                                	<input id="preExponentialFactor" name="preExponentialFactor" type="text" placeholder="指前因子" />
                            	</c:if>
                            	<c:if test="${not empty dataLib.preExponentialFactor }">
                                	<input id="preExponentialFactor" name="preExponentialFactor" type="text" value="<fmt:formatNumber value="${dataLib.preExponentialFactor}" pattern="#,##0.#"></fmt:formatNumber>"/>
                            	</c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="reactionOrder">反应级数</label>
                            <div class="controls">
                            	<c:if test="${empty dataLib.reactionOrder }">
                                	<input id="reactionOrder" name="reactionOrder" type="text" placeholder="反应级数" />
                            	</c:if>
                            	<c:if test="${not empty dataLib.reactionOrder }">
                                	<input id="reactionOrder" name="reactionOrder" type="text" value="<fmt:formatNumber value="${dataLib.reactionOrder}" pattern="#,##0.#"></fmt:formatNumber>"/>
                            	</c:if>
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
                                <tbody id="originalDataFileUploadGrid">
                                	<c:forEach var="attachment" items="${originalDataFileList}" varStatus="status">
                                		<tr id='fileTr${attachment.fileId}'>
		            						<td id='fileName${attachment.fileId}' style='width:50%'>
		            							<a href='${basePath}/attachment/downloadFile.action?fileId=${attachment.fileId}'>${attachment.fileName}</a>
		            							<input type='hidden' name='originalDataFileIdStr' value='${attachment.fileId}'/>
		            						</td>
		            						<td style='width:20%'>
		            							<div style='width:100%;height:16px;border:1px solid #04c'>
		            								<div id='progressBar${attachment.fileId}' style='width:100%;height:16px;background:#006dcc'></div>
		            							</div>
		            						</td>
		            						<td style='width:10%'><span style='float:right' id='progressLabel${attachment.fileId}'>100%</span></td>
		            						<td style='width:10%'>${attachment.fileSize}</td>
		            						<td><a href='#' onclick='this.parentNode.parentNode.remove();'>删除</a></td>
		            					</tr>
                                	</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 实验信息</legend>
                    <div class="control-group">
                        <label class="control-label" for="author">作者</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.author }">
	                            <input id="author" name="author" type="text" placeholder="作者" />
                        	</c:if>
                        	<c:if test="${not empty dataLib.author }">
	                            <input id="author" name="author" type="text" value="${dataLib.author }" />
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="org">单位</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.org }">
	                            <input id="org" name="org" type="text" placeholder="单位"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.org }">
	                            <input id="org" name="org" type="text" value="${dataLib.org }"/>
                        	</c:if>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="uploadTime">上传时间</label>
                        <div class="controls">
                            <div id="datetimepicker2" class="input-append date">
                                <input type="text" id="uploadTime" name="uploadTime" value="${dataLib.uploadTime }" class="add-on" style="width:209px; text-align:left;" readonly></input>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="linkInfo">联系方式</label>
                        <div class="controls">
                        	<c:if test="${empty dataLib.linkInfo }">
	                            <input id="linkInfo" name="linkInfo" type="text" placeholder="联系方式"/>
                        	</c:if>
                        	<c:if test="${not empty dataLib.linkInfo }">
	                            <input id="linkInfo" name="linkInfo" type="text" value="${dataLib.linkInfo }"/>
                        	</c:if>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>
