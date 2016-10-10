<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cd.flow.FlowStepInstance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    List<FlowStepInstance> steps = (List<FlowStepInstance>) request.getAttribute("steps");
    FlowStepInstance st = (FlowStepInstance) request.getAttribute("step");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>数据审核</title>
    <link href="<%=basePath%>/uiframe/jquery/plugin/ystep/css/ystep.css" rel="stylesheet" media="screen"/>
</head>
<body>
<script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/ystep/js/ystep.js"></script>
<script type="text/javascript">
    $(function() {
        // 每次隐藏时，清除界面内容，下次打开重新加载
        $("#invitExpertModal").on("hidden", function() {
            $(this).removeData("modal");
        });
        // 创建用户表单保存按钮事件
        $("#invitExpertSaveBtn").on("click", function() {
            $("#invitExpertForm").submit();
        });
    });
    
    // 邀请专家审核按钮响应事件
    var invitExpert = function() {
        $("#invitExpertModal").modal({
            backdrop : true,
            keyboard : false,
            show : true,
            remote : "toInvitExpert.action?stepInstanceId=<%=st.getStepInstanceId() %>"
        });
    }
</script>
    <div class="container" style="margin-top:15px;">
        <div class="row-fluid">
            <div class="span8 offset2">
                <form class="form-horizontal" action="<%=basePath%>/flowinstance/approval.action" method="post" name="approvalForm" id="approvalForm">
                    <input type="hidden" name="stepInstanceId" value="${step.stepInstanceId}"/>
                    <fieldset>
                        <legend>审核数据 </legend>
                        <table class="table table-bordered table-condensed">
                            <tbody>
                                <tr class="info"><td colspan="3" style="background-color:#CBE8F7;height:30px;line-height:30px;text-align:center;font-weight:bold;font-size:20px;">数据报告</td></tr>
                                <tr class="info">
                                    <td colspan="3" style="font-weight:bold;">反应物</td>
                                </tr>
                                <tr>
                                    <td colspan="3">名称：&nbsp;${data.thinKind}</td>
                                </tr>
                                <tr class="info">
                                    <td colspan="3" style="font-weight:bold;">测试方法</td>
                                </tr>
                                <tr>
                                    <td>仪器名称：&nbsp;${data.instrumentName}</td>
                                    <td>仪器厂商：&nbsp;${data.instrumentVendor}</td>
                                    <td>仪器型号：&nbsp;${data.instrumentType}</td>
                                </tr>
                                <tr>
                                    <td>实验方法：&nbsp;${data.testMethod}</td>
                                    <td colspan="2">检测手段：&nbsp;${data.testWay}</td>
                                </tr>
                                <tr class="info">
                                    <td colspan="3" style="font-weight:bold;">测试条件</td>
                                </tr>
                                <tr>
                                    <td>样品量：&nbsp;${data.sampleQuantity}</td>
                                    <td>气氛组成：&nbsp;${data.auraForm}</td>
                                    <td>气体流量：&nbsp;${data.auraRate}</td>
                                </tr>
                                <tr>
                                    <td colspan="3">升温程序：&nbsp;${data.riseProgram}</td>
                                </tr>
                                <tr class="info">
                                    <td colspan="3" style="font-weight:bold;">结果</td>
                                </tr>
                                <tr>
                                    <td>活化能：&nbsp;${data.activationEnergy}</td>
                                    <td>指前因子：&nbsp;${data.preExponentialFactor}</td>
                                    <td>反应级数：&nbsp;${data.reactionOrder}</td>
                                </tr>
                                <tr>
                                    <td colspan="3">动力学解析方法：&nbsp;${data.analyzeMethod}</td>
                                </tr>
                                <tr>
                                    <td colspan="3">图表：&nbsp;<a href='${basePath}/attachment/downloadFile.action?fileId=${data.chartFileId}'>${data.chartFileName}</a></td>
                                </tr>
                                <tr class="info">
                                    <td colspan="3" style="font-weight:bold;">上传者信息</td>
                                </tr>
                                <tr>
                                    <td>作者：&nbsp;${data.author}</td>
                                    <td>单位：&nbsp;${data.org}</td>
                                    <td>上传时间：&nbsp;${data.uploadTime}</td>
                                </tr>
                                <tr>
                                    <td colspan="3">联系方式：&nbsp;${data.linkInfo}</td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align:center;">
                                        <br/><a href="/datalib/gotoDataLibReport.sitemesh?id=${step.dataId}&download=true">数据报告下载（PDF/WORD）</a>
                                        <!-- <br/><a href="#">原始数据下载（格式与上传的数据一致）</a> -->
                                        <br/>&nbsp;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
                    <c:if test='${step.stepType eq "1"}'>
                        <fieldset>
                            <legend>审核记录 </legend>
                            <table class="table table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>步骤</th>
                                        <th>审批人</th>
                                        <th>接收时间</th>
                                        <th>审核时间</th>
                                        <th>状态</th>
                                        <th>审核意见</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${steps}" var="st">
                                        <c:if test='${st.stepType eq "1"}'>
                                            <tr>
                                                <td>${st.stepNum}</td>
                                                <td>${st.stepName}</td>
                                                <td>${st.stepUserName}</td>
                                                <td><fmt:formatDate value="${st.receiveTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                                                <td><fmt:formatDate value="${st.approvalTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                                                <td>
                                                    <c:if test='${st.status eq "READY"}'><span style="width:45px;text-align:center;" class="badge">未审核</span></c:if>
                                                    <c:if test='${st.status eq "RUNNING"}'><span style="width:45px;text-align:center;" class="badge badge-success">审核中</span></c:if>
                                                    <c:if test='${st.status eq "PASS"}'><span style="width:45px;text-align:center;" class="badge badge-info">通&nbsp;过</span></c:if>
                                                    <c:if test='${st.status eq "UNPASS"}'><span style="width:45px;text-align:center;" class="badge badge-important">不通过</span></c:if>
                                                </td>
                                                <td>${st.memo}</td>
                                            </tr>
                                        </c:if>
                                        <c:if test='${st.stepType eq "2"}'>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>${st.stepUserName}(专家)</td>
                                                <td><fmt:formatDate value="${st.receiveTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                                                <td><fmt:formatDate value="${st.approvalTime}" type="both" dateStyle="medium" timeStyle="medium"/></td>
                                                <td>
                                                    <c:if test='${st.status eq "READY"}'><span style="width:45px;text-align:center;" class="badge">未审核</span></c:if>
                                                    <c:if test='${st.status eq "RUNNING"}'><span style="width:45px;text-align:center;" class="badge badge-success">审核中</span></c:if>
                                                    <c:if test='${st.status eq "PASS"}'><span style="width:45px;text-align:center;" class="badge badge-info">通&nbsp;过</span></c:if>
                                                    <c:if test='${st.status eq "UNPASS"}'><span style="width:45px;text-align:center;" class="badge badge-important">不通过</span></c:if>
                                                </td>
                                                <td>${st.memo}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </fieldset>
                    </c:if>
                    <c:if test='${step.status eq "RUNNING"}'>
                        <fieldset>
                            <legend>审核 </legend>
                            <div class="control-group">
                                <label class="control-label" for="result">审核结果</label>
                                <div class="controls">
                                    <label class="radio inline">
                                        <input name="result" type="radio" value="1" checked="checked"> 通过
                                    </label>
                                    <label class="checkbox inline">
                                        <input name="result" type="radio" value="2"> 不通过
                                    </label>
                                    <label class="checkbox inline">
                                        <c:if test='${step.stepType eq "1"}'><a href="javascript:invitExpert();">邀请专家审核</a></c:if>
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="memo">审核结果</label>
                                <div class="controls">
                                    <textarea style="width:90%" name="memo" rows="5"></textarea>
                                </div>
                            </div>
                        </fieldset>
                    </c:if>
                    <div class="form-actions">
                        <c:if test='${step.status eq "RUNNING"}'>
                            <button type="submit" class="btn btn-primary">确定</button>
                            <button type="button" class="btn" onclick="javascript:history.go(-1);">取消</button>
                        </c:if>
                        <c:if test='${step.status ne "RUNNING"}'>
                            <button type="button" class="btn" onclick="javascript:history.go(-1);">返回</button>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- 邀请专家审核窗口 -->
    <div id="invitExpertModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="invitExpertLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="invitExpertLabel">邀请专家审核</h3>
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
            <button id="invitExpertSaveBtn" class="btn btn-primary">保存</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </div>
</body>
</html>
