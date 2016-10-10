<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>查询数据</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload.css" rel="stylesheet" media="screen"/>
    <link href="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/css/jquery.fileupload-ui.css" rel="stylesheet" media="screen"/>
</head>
<body>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/jQuery-File-Upload-9.10.0/js/jquery.iframe-transport.js"></script>
<script type="text/javascript">
    $(function() {
        $('#datetimepicker0').datetimepicker({
            format: 'yyyy-MM-dd',
            language: 'zh-CN',
            pickDate: true,
            pickTime: true,
            hourStep: 1,
            minuteStep: 15,
            secondStep: 30,
            inputMask: true
        });
        
        $('#datetimepicker1').datetimepicker({
            format: 'yyyy-MM-dd',
            language: 'zh-CN',
            pickDate: true,
            pickTime: true,
            hourStep: 1,
            minuteStep: 15,
            secondStep: 30,
            inputMask: true
        });
        
        $.fn.serializeObject=function(){  
            var hasOwnProperty=Object.prototype.hasOwnProperty;  
            return this.serializeArray().reduce(function(data,pair){  
                if(!hasOwnProperty.call(data,pair.name)){  
                    data[pair.name]=pair.value;  
                }  
                return data;  
            },{});  
        };  
        
        $('#searchDataLibForm').validate({
            submitHandler : function() {
            	grid.load($("#searchDataLibForm").serializeObject());
            	$("#searchDataLibModal").modal('hide');
            	
            },
            rules:{
            	sampleQuantityStart:{
            		number:true,
                    maxlength : 25
            	},
            	sampleQuantityEnd:{
            		number:true,
                    maxlength : 25
            	},
            	auraRateStart:{
            		number:true,
                    maxlength : 25
            	},
            	auraRateEnd:{
            		number:true,
                    maxlength : 25
            	},
            	reactiontStart:{
            		number:true,
                    maxlength : 25
            	},
            	reactiontEnd:{
            		number:true,
                    maxlength : 25
            	},
            	reactionTimeStart:{
            		number:true,
                    maxlength : 25
            	},
            	reactionTimeEnd:{
            		number:true,
                    maxlength : 25
            	},
            	negativePressureStart:{
            		number:true,
                    maxlength : 25
            	},
            	negativePressureEnd:{
            		number:true,
                    maxlength : 25
            	},
            	forwardPressureStart:{
            		number:true,
                    maxlength : 25
            	},
            	forwardPressureEnd:{
            		number:true,
                    maxlength : 25
            	},
            	activationEnergyStart:{
            		number:true,
                    maxlength : 25
            	},
            	activationEnergyEnd:{
            		number:true,
                    maxlength : 25
            	},
            	preExponentialFactorStart:{
            		number:true,
                    maxlength : 25
            	},
            	preExponentialFactorEnd:{
            		number:true,
                    maxlength : 25
            	},
            	reactionOrderStart:{
            		number:true,
                    maxlength : 25
            	},
            	reactionOrderEnd:{
            		number:true,
                    maxlength : 25
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
            <form class="form-horizontal" action="#" method="post" name="searchDataLibForm" id="searchDataLibForm" enctype="multipart/form-data">
                <input id="start" name="start" type="hidden" value="0" />
                <input id="limit" name="limit" type="hidden" value="10" />
                <div class="control-group">
                    <label class="control-label" for="status">状态</label>
                    <div class="controls">
                        <select id='status' name="status">
                                <option value="" style="font-style: italic;">—全部—</option>
                                <option value="编辑中">编辑中</option>
                                <option value="审核中">审核中</option>
                                <option value="审核通过">审核通过</option>
                                <option value="审核未通过">审核未通过</option>
                            </select>
                    </div>
                </div>
                <fieldset>
                    <legend><i class="icon-tasks icon-black" style="line-height:40px"></i> 反应物</legend>
                    <div class="control-group">
                        <label class="control-label" for="thinKind">类别</label>
                        <div class="controls">
                            <select id='thinKind' name="thinKind">
                                <option value="" style="font-style: italic;">—全部—</option>
                                <option value="煤">煤</option>
                                <option value="稻壳">稻壳</option>
                                <option value="药渣">药渣</option>
                                <option value="矿物盐">矿物盐</option>
                                <option value="石油">石油</option>
                                <option value="其他">其他</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="country">国别</label>
                        <div class="controls">
                            <input id="country" name="country" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="district">地区</label>
                        <div class="controls">
                            <input id="district" name="district" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="age">名称</label>
                        <div class="controls">
                            <input id="age" name="age" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="physicalParamFileName">物性参数</label>
                        <div class="controls">
                            <input id="physicalParamFileName" name="physicalParamFileName" type="text"/>（文件名称格式：？？？）
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试方法</legend>
                    <div class="control-group">
                        <label class="control-label" for="instrumentName">仪器名称</label>
                        <div class="controls">
                            <input id='instrumentName' name="instrumentName" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentVendor">仪器厂商</label>
                        <div class="controls">
                            <input id='instrumentVendor' name="instrumentVendor" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="instrumentType">仪器型号</label>
                        <div class="controls">
                            <input id='instrumentType' name="instrumentType" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testMethod">实验方法</label>
                        <div class="controls">
                            <select id='testMethod' name="testMethod">
                                <option value="" style="font-style: italic;">—全部—</option>
                                <option value="等温">等温</option>
                                <option value="非等温">非等温</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="testWay">检测手段</label>
                        <div class="controls">
                            <select id='testWay' name="testWay">
                                <option value="" style="font-style: italic;">—全部—</option>
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
                            <input id="sampleQuantityStart" name="sampleQuantityStart" type="text" style="width:150px;"/>
                            （至）
                            <input id="sampleQuantityEnd" name="sampleQuantityEnd" type="text" style="width:150px;"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="riseProgram">升温程序</label>
                        <div class="controls">
                            <input id="riseProgram" name="riseProgram" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraForm">气氛组成</label>
                        <div class="controls">
                            <input id="auraForm" name="auraForm" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="auraRate">气体流量</label>
                        <div class="controls">
                            <input id="auraRateStart" name="auraRateStart" type="text" style="width:150px"/>
                            （至）
                            <input id="auraRateEnd" name="auraRateEnd" type="text" style="width:150px"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="catalystKind">催化剂种类</label>
                        <div class="controls">
                            <select id='catalystKind' name="catalystKind">
                                <option value="" style="font-style: italic;">—全部—</option>
                                <option value="催化剂种类1">催化剂种类1</option>
                                <option value="催化剂种类2">催化剂种类2</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="reactiont">反应温度</label>
                        <div class="controls">
                            <input id="reactiontStart" name="reactiontStart" type="text" style="width:150px"/>
                            （至）
                            <input id="reactiontEnd" name="reactiontEnd" type="text" style="width:150px"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="reactionTime">反应时间</label>
                        <div class="controls">
                            <input id="reactionTimeStart" name="reactionTimeStart" type="text" style="width:150px"/>
                            （至）
                            <input id="reactionTimeEnd" name="reactionTimeEnd" type="text" style="width:150px"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="negativePressure">负压</label>
                        <div class="controls">
                            <input id="negativePressureStart" name="negativePressureStart" type="text" style="width:150px"/>
                            （至）
                            <input id="negativePressureEnd" name="negativePressureEnd" type="text" style="width:150px"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="forwardPressure">偏压</label>
                        <div class="controls">
                            <input id="forwardPressureStart" name="forwardPressureStart" type="text" style="width:150px"/>
                            （至）
                            <input id="forwardPressureEnd" name="forwardPressureEnd" type="text" style="width:150px"/>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 测试结果</legend>
                    <div class="control-group">
                        <label class="control-label" for="analyzeMethod">动力学解析方法</label>
                        <div class="controls">
                            <select id="analyzeMethod" name="analyzeMethod">
                                <option value="" style="font-style: italic;">—全部—</option>
                                <option value="等转化率法">等转化率法</option>
                                <option value="模型法">模型法</option>
                                <option value="以公式或图片形式上传">以公式或图片形式上传</option>
                            </select>
                        </div>
                    </div>
                    <!-- 
                    <div class="control-group">
                        <label class="control-label" for="chartFileName">图表（文件名称）</label>
                        <div class="controls">
                            <input id="chartFileName" name="chartFileName" type="text"/>
                        </div>
                    </div>
                     -->
                    <div class="control-group" style="border:1px dashed #CDCDCD">
                        <div class="control-group">
                            <label class="control-label">实际数值</label>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="activationEnergy">活化能</label>
                            <div class="controls">
                                <input id="activationEnergyStart" name="activationEnergyStart" type="text" style="width:150px"/>
                                （至）
                                <input id="activationEnergyEnd" name="activationEnergyEnd" type="text" style="width:150px"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="preExponentialFactor">指前因子</label>
                            <div class="controls">
                                <input id="preExponentialFactorStart" name="preExponentialFactorStart" type="text" style="width:150px"/>
                                （至）
                                <input id="preExponentialFactorEnd" name="preExponentialFactorEnd" type="text" style="width:150px"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="reactionOrder">反应级数</label>
                            <div class="controls">
                                <input id="reactionOrderStart" name="reactionOrderStart" type="text" style="width:150px"/>
                                （至）
                                <input id="reactionOrderEnd" name="reactionOrderEnd" type="text" style="width:150px"/>
                            </div>
                        </div>
                    </div>
                    <!-- 
                    <div class="control-group">
                        <label class="control-label" for="originalDataFileNames">原始数据（文件名称）</label>
                        <div class="controls">
                            <input id="originalDataFileNames" name="originalDataFileNames" type="text"/>
                        </div>
                    </div>
                     -->
                </fieldset>
                <fieldset>
                    <legend><i class="icon-tasks icon-black"></i> 实验信息</legend>
                    <div class="control-group">
                        <label class="control-label" for="author">作者</label>
                        <div class="controls">
                            <input id="author" name="author" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="org">单位</label>
                        <div class="controls">
                            <input id="org" name="org" type="text"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="uploadTime">上传时间</label>
                        <div class="controls">
                            <div id="datetimepicker0" class="input-append date"  style="float:left; display:inline;">
                                <input type="text" id="uploadTimeStart" name="uploadTimeStart" class="add-on" style="width:150px" readonly></input>
                            </div>
                            <div style="float:left; display:inline; vertical-align: baseline;">&nbsp;（至）&nbsp;</div>
                            <div id="datetimepicker1" class="input-append date" style="float:left; display:inline;">
                                <input type="text" id="uploadTimeEnd" name="uploadTimeEnd" class="add-on" style="width:150px" readonly></input>
                            </div>
                        </div>
                    </div>
                    <!-- 
                    <div class="control-group">
                        <label class="control-label" for="linkInfo">联系方式</label>
                        <div class="controls">
                            <input id="linkInfo" name="linkInfo" type="text"/>
                        </div>
                    </div>
                     -->
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>
