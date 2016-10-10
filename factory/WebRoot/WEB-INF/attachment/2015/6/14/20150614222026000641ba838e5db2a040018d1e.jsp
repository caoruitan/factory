<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>上传数据</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload.css" rel="stylesheet" media="screen"/>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload-ui.css" rel="stylesheet" media="screen"/>
</head>
<body>

<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jquery-ui-1.10.4/js/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.iframe-transport.js"></script>
<script type="text/javascript">
    $(function() {
        $('#datetimepicker').datetimepicker({
            format: 'yyyy-MM-dd hh:mm',
            language: 'zh-CN',
            pickDate: true,
            pickTime: true,
            hourStep: 1,
            minuteStep: 15,
            secondStep: 30,
            inputMask: true
        });
        
        var tbIdx = 'tb';
        $("#tbFileuploadFile").fileupload({
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

            var text = "<tr id='fileTr" + tbIdx + "'><td id='fileName" + tbIdx + "' style='width:50%'>" + data.originalFiles[0].name + "</td><td style='width:20%'><div style='width:100%;height:16px;border:1px solid #04c'><div id='progressBar" + tbIdx + "' style='width:0%;height:16px;background:#006dcc'></div></div></td><td style='width:10%'><span style='float:right' id='progressLabel" + tbIdx + "'></span></td><td style='width:10%'>" + sizeText + "</td><td><a href='javascript:$(\"#fileTr" + tbIdx + "\").remove();'>删除</a></td></tr>"
            $("#tbFileUploadGrid").html(text);
        }).bind('fileuploadprogress', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $("#progressBar" + tbIdx).css('width', progress + '%');
            $("#progressLabel" + tbIdx).html(progress + '%');
        }).bind('fileuploaddone', function (e, data) {
            eval('var rs = ' + data.result);
            var fileName = rs.attachment.fileName;
            var fileId = rs.attachment.fileId;
            var download = "<a href='${basePath}/attachment/downloadFile.action?fileId=" + fileId + "'>" + fileName + "</a>";
            var hidden = "<input type='hidden' name='tb' value='" + fileId + "'/>";
            $("#fileName" + tbIdx).html(download + hidden);
        });
        
        var yssjIdx = 0;
        $("#yssjFileuploadFile").fileupload({
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
            var text = "<tr id='fileTr" + yssjIdx + "'><td id='fileName" + yssjIdx + "' style='width:50%'>" + data.originalFiles[0].name + "</td><td style='width:20%'><div style='width:100%;height:16px;border:1px solid #04c'><div id='progressBar" + yssjIdx + "' style='width:0%;height:16px;background:#006dcc'></div></div></td><td style='width:10%'><span style='float:right' id='progressLabel" + yssjIdx + "'></span></td><td style='width:10%'>" + sizeText + "</td><td><a href='javascript:$(\"#fileTr" + yssjIdx + "\").remove();'>删除</a></td></tr>"
            $("#yssjFileUploadGrid").append(text);
        }).bind('fileuploadprogress', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $("#progressBar" + yssjIdx).css('width', progress + '%');
            $("#progressLabel" + yssjIdx).html(progress + '%');
        }).bind('fileuploaddone', function (e, data) {
            eval('var rs = ' + data.result);
            var fileName = rs.attachment.fileName;
            var fileId = rs.attachment.fileId;
            var download = "<a href='${basePath}/attachment/downloadFile.action?fileId=" + fileId + "'>" + fileName + "</a>";
            var hidden = "<input type='hidden' name='yssj' value='" + fileId + "'/>";
            $("#fileName" + yssjIdx).html(download + hidden);
        });
    });
</script>
<div class="container" style="margin-top:15px;">
    <div class="row-fluid">
        <div class="span8 offset2">
            <form class="form-horizontal" action="#" method="get" name="approvalForm" id="approvalForm" enctype="multipart/form-data">
                <fieldset>
                    <legend><i class="icon-tasks icon-black" style="line-height:40px"></i> 反应物</legend>
                    <div class="control-group">
                        <label class="control-label" for="lx">类型</label>
                        <div class="controls">
                            <label class="radio inline">
                                <input name="lx" type="radio" checked="checked"> 煤
                            </label>
                            <label class="checkbox inline">
                                <input name="lx" type="radio"> 生物质
                            </label>
                            <label class="checkbox inline">
                                <input name="lx" type="radio"> 矿物盐
                            </label>
                            <label class="checkbox inline">
                                <input name="lx" type="radio"> 石油
                            </label>
                            <label class="checkbox inline">
                                <input name="lx" type="radio"> 其它
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="gb">国别</label>
                        <div class="controls">
                            <input id="gb" name="gb" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="nl">年龄</label>
                        <div class="controls">
                            <input id="nl" name="nl" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="wxcs">物性参数</label>
                        <div class="controls">
                            <input id='wxcs' name="wxcs" type="text"/>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试方法</legend>
                    <div class="control-group">
                        <label class="control-label" for="yqmc">仪器名称</label>
                        <div class="controls">
                            <input id='yqmc' name="yqmc" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="yqcs">仪器厂商</label>
                        <div class="controls">
                            <input id='yqcs' name="yqcs" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="yqxh">仪器型号</label>
                        <div class="controls">
                            <input id='yqxh' name="yqxh" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="syff">实验方法</label>
                        <div class="controls">
                            <select id='syff' name="syff">
                                <option value="1">等温</option>
                                <option value="2">非等温</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="jcsd">检测手段</label>
                        <div class="controls">
                            <select id='jcsd' name="jcsd">
                                <option value="1">质谱</option>
                                <option value="2">红外</option>
                                <option value="3">TPD/TPR</option>
                                <option value="4">电化学</option>
                                <option value="5">TCD</option>
                            </select>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试条件</legend>
                    <div class="control-group">
                        <label class="control-label" for="ypl">样品量</label>
                        <div class="controls">
                            <input id="ypl" name="ypl" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="swcx">升温程序</label>
                        <div class="controls">
                            <input id="swcx" name="swcx" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="qfzc">气氛组成</label>
                        <div class="controls">
                            <input id="qfzc" name="qfzc" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="qtll">气体流量</label>
                        <div class="controls">
                            <input id="qtll" name="qtll" type="text"/>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试结果</legend>
                    <div class="control-group">
                        <label class="control-label" for="dlxjxff">动力学解析方法</label>
                        <div class="controls">
                            <select id="dlxjxff" name="dlxjxff">
                                <option value="1">等转化率法</option>
                                <option value="2">模型法</option>
                                <option value="3">以公式或图片形式上传</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="tb">图表</label>
                        <div class="controls">
                            <input class="btn btn-primary" type="button" value="上传附件" onclick="document.getElementById('tbFileuploadFile').click()"></input>
                            <input id="tbFileuploadFile" name="uploadFile" type="file" style="display:none;"/>
                            <br/><br/>
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th colspan="2">上传进度</th>
                                        <th>大小</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="tbFileUploadGrid"></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="control-group" style="border:1px dashed #CDCDCD">
                        <div class="control-group">
                            <label class="control-label">实际数值</label>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="hhn">活化能</label>
                            <div class="controls">
                                <input id="hhn" name="hhn" type="text"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="zqyz">指前因子</label>
                            <div class="controls">
                                <input id="zqyz" name="zqyz" type="text"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="fyjs">反应级数</label>
                            <div class="controls">
                                <input id="fyjs" name="fyjs" type="text"/>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="yssj">原始数据</label>
                        <div class="controls">
                            <input id="fileupload" class="btn btn-primary" type="button" value="添加附件" onclick="document.getElementById('yssjFileuploadFile').click()"></input>
                            <input id="yssjFileuploadFile" name="uploadFile" type="file" style="display:none;"/>
                            <br/><br/>
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th colspan="2">上传进度</th>
                                        <th>大小</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="yssjFileUploadGrid"></tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 实验信息</legend>
                    <div class="control-group">
                        <label class="control-label" for="zz">作者</label>
                        <div class="controls">
                            <input id="zz" name="zz" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="dw">单位</label>
                        <div class="controls">
                            <input id="dw" name="dw" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="scsj">上传时间</label>
                        <div class="controls">
                            <div id="datetimepicker" class="input-append date">
                                <input type="text" id="scsj" name="scsj" class="add-on" style="width:209px" readonly></input>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="lxfs">联系方式</label>
                        <div class="controls">
                            <input id="lxfs" name="lxfs" type="text"/>
                        </div>
                    </div>
                </fieldset>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
