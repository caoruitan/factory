<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cd.login.LoginSessionKey"%>
<%@ page import="com.cd.login.LoginUser"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String currentMenu = request.getParameter("currentMenu");
    LoginUser loginUser = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
    request.setAttribute("currentMenu", currentMenu);
    request.setAttribute("basePath", basePath);
    request.setAttribute("loginUser", loginUser);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title><decorator:title default="cdsoft"/></title>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <link href="<%=basePath%>/uiframe/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
        <link href="<%=basePath%>/uiframe/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen"/>
        <link href="<%=basePath%>/uiframe/jquery/plugin/bootstrap-plugin/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen"/>
        <link href="<%=basePath%>/uiframe/bootstrap/css/extend.css" rel="stylesheet" media="screen"/>
        <decorator:head/>
    </head>
    <body class="devpreview sourcepreview">
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <![endif]-->
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/bootstrap/js/bootstrap-collapse.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/bootstrap-plugin/bootstrap.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/bootstrap-plugin/bootstrap-datetimepicker.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/bootstrap-plugin/bootstrap-datetimepicker.zh-CN.js"></script>
        <script type="text/javascript" src="<%=basePath%>/uiframe/jquery/plugin/validate/jquery.validate.min.js"></script>
        <script type="text/javascript">
            $(function() {
                jQuery.extend(jQuery.validator.messages, {
                    required: "必选字段",
                    remote: "请修正该字段",
                    email: "请输入正确格式的电子邮件",
                    url: "请输入合法的网址",
                    date: "请输入合法的日期",
                    dateISO: "请输入合法的日期 (ISO).",
                    number: "请输入合法的数字",
                    digits: "只能输入整数",
                    creditcard: "请输入合法的信用卡号",
                    equalTo: "请再次输入相同的值",
                    accept: "请输入拥有合法后缀名的字符串",
                    maxlength: jQuery.validator.format("请输入一个 长度最多是 {0} 的字符串"),
                    minlength: jQuery.validator.format("请输入一个 长度最少是 {0} 的字符串"),
                    rangelength: jQuery.validator.format("请输入 一个长度介于 {0} 和 {1} 之间的字符串"),
                    range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
                    max: jQuery.validator.format("请输入一个最大为{0} 的值"),
                    min: jQuery.validator.format("请输入一个最小为{0} 的值")
                });
                
                jQuery.validator.addMethod("isMobile", function(value, element) {    
                    var length = value.length;    
                    return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));    
                }, "请正确填写您的手机号码。");

                // 电话号码验证    
                jQuery.validator.addMethod("isPhone", function(value, element) {    
                    var tel = /^(\d{3,4}-?)?\d{7,9}$/g;    
                    return this.optional(element) || (tel.test(value));    
                }, "请正确填写您的电话号码。");

                // 联系电话(手机/电话皆可)验证   
                jQuery.validator.addMethod("isTel", function(value,element) {   
                    var length = value.length;   
                    var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;   
                    var tel = /^(\d{3,4}-?)?\d{7,9}$/g;       
                    return this.optional(element) || tel.test(value) || (length==11 && mobile.test(value));   
                }, "请正确填写您的联系电话"); 

                // 每次隐藏时，清除界面内容，下次打开重新加载
                $("#updateLoginInfoModal").on("hidden", function() {
                    $(this).removeData("modal");
                });
                // 修改个人信息按钮事件
                $("#updateLoginInfoBtn").on("click", function() {
                    $("#updateLoginInfoModal").modal({
                        backdrop : true,
                        keyboard : false,
                        show : true,
                        remote : "${basePath}/user/toUpdateLoginInfo.action?userId=${loginUser.userId}"
                    });
                });
                // 修改个人信息保存按钮事件
                $("#updateLoginInfoSaveBtn").on("click", function() {
                    $('#updateLoginInfoForm').submit();
                });

                // 每次隐藏时，清除界面内容，下次打开重新加载
                $("#updatePasswordModal").on("hidden", function() {
                    $(this).removeData("modal");
                });
                // 修改密码按钮事件
                $("#updatePasswordBtn").on("click", function() {
                    $("#updatePasswordModal").modal({
                        backdrop : true,
                        keyboard : false,
                        show : true,
                        remote : "${basePath}/user/updatePassword.jsp?userId=${loginUser.userId}"
                    });
                });
                // 修改密码保存按钮事件
                $("#updatePasswordSaveBtn").on("click", function() {
                    $("#updatePasswordForm").submit();
                });
                
                // 退出登录按钮事件
                $("#logoutBtn").on("click", function() {
                    window.location.href = "${basePath}/login/doLogout.action";
                });
            });
        </script>
        <!-- 导航栏 -->
        <div class="navbar navbar-static-top navbar-inverse">
            <div class="navbar-inner">
                <div class="container" style="width:95%">
                    <button class="btn btn-navbar" data-target=".nav-collapse" data-toggle="collapse" type="button">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#">中国科学院过程工程研究所</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <!-- 首页导航 -->
                            <!-- 
                            <c:if test='${currentMenu=="home" || currentMenu=="" || currentMenu == null}'>
                                <li class="active"><a href="<%=basePath%>/home/home.sitemesh?currentMenu=home">首页</a></li>
                            </c:if>
                            <c:if test='${currentMenu!="home" && currentMenu!="" && currentMenu != null}'>
                                <li><a href="<%=basePath%>/home/home.sitemesh?currentMenu=home">首页</a></li>
                            </c:if>
                             -->
                            <!-- 用户管理导航 -->
                            <c:set var="userPrivilege" value="false"/>
                            <c:forEach items="${loginUser.privileges}" var="privilege">
                                <c:if test='${privilege eq "SYSTEM_USER"}'>
                                    <c:set var="userPrivilege" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:if test='${userPrivilege eq "true"}'>
                                <c:if test='${currentMenu=="user" }'>
                                    <li class="active"><a href="<%=basePath%>/user/main.sitemesh?currentMenu=user">用户管理</a></li>
                                </c:if>
                                <c:if test='${currentMenu!="user" }'>
                                    <li><a href="<%=basePath%>/user/main.sitemesh?currentMenu=user">用户管理</a></li>
                                </c:if>
                            </c:if>
                            
                            <!-- 流程管理导航 -->
                            <c:set var="flowPrivilege" value="false"/>
                            <c:forEach items="${loginUser.privileges}" var="privilege">
                                <c:if test='${privilege eq "SYSTEM_FLOW"}'>
                                    <c:set var="flowPrivilege" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:if test='${flowPrivilege eq "true"}'>
                                <c:if test='${currentMenu=="flow" }'>
                                    <li class="active"><a href="<%=basePath%>/flow/main.sitemesh?currentMenu=flow">流程管理</a></li>
                                </c:if>
                                <c:if test='${currentMenu!="flow" }'>
                                    <li><a href="<%=basePath%>/flow/main.sitemesh?currentMenu=flow">流程管理</a></li>
                                </c:if>
                            </c:if>
                            
                            <!-- 数据审核导航 -->
                            <c:set var="approvalPrivilege" value="false"/>
                            <c:forEach items="${loginUser.privileges}" var="privilege">
                                <c:if test='${fn:endsWith(privilege, "_APPROVAL")}'>
                                    <c:set var="approvalPrivilege" value="true"/>
                                </c:if>
                                <c:if test='${fn:endsWith(privilege, "_EXPERT")}'>
                                    <c:set var="approvalPrivilege" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:if test='${approvalPrivilege eq "true"}'>
                                <c:if test='${currentMenu=="myApproval" }'>
                                    <li class="active"><a href="<%=basePath%>/flowinstance/myApproval.sitemesh?currentMenu=myApproval">数据审批</a></li>
                                </c:if>
                                <c:if test='${currentMenu!="myApproval" }'>
                                    <li><a href="<%=basePath%>/flowinstance/myApproval.sitemesh?currentMenu=myApproval">数据审批</a></li>
                                </c:if>
                            </c:if>
                            
                            <!-- 数据库导航 -->
                            <c:forEach items="${DATABASE_KEY}" var="entry">
                                <c:if test='${entry.key eq "DL"}'>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">动力学数据库
                                            <b class="caret"></b>
                                        </a>
                                        <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu">
                                            <c:forEach items="${entry.value}" var="database">
                                                <c:if test='${database.key eq "MFBRADLXSJK"}'>
                                                    <li><a tabindex="-1" href="<%=basePath%>/datalib/main.sitemesh?currentMenu=MFBRADLXSJK">MFBRA动力学数据库</a></li>
                                                </c:if>
                                                <c:if test='${database.key eq "NHXQXCJDLXSJK"}'>
                                                    <li><a tabindex="-1" href="<%=basePath%>/datalib/main.sitemesh?currentMenu=NHXQXCJDLXSJK">化学气相沉积动力学数据库(MFB-CVD)</a></li>
                                                </c:if>
                                                <c:if test='${database.key eq "RZLDLXSJK"}'>
                                                    <li><a tabindex="-1" href="<%=basePath%>/datalib/main.sitemesh?currentMenu=RZLDLXSJK">热重力学数据库</a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                                <c:if test='${entry.key eq "WX"}'>
                                    <li><a href="<%=basePath%>/datalib/main.sitemesh?currentMenu=WX">物性参数数据库</a></li>
                                </c:if>
                            </c:forEach>
                            <c:set var="approvalPrivilege" value="false"/>
                            <c:forEach items="${loginUser.privileges}" var="privilege">
                                <c:if test='${fn:endsWith(privilege, "_APPROVAL")}'>
                                    <c:set var="approvalPrivilege" value="true"/>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-white icon-user"></i> ${loginUser.userName}
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu">
                                    <li><a id="updateLoginInfoBtn" tabindex="-1" href="#"><i class="icon-cog"></i> 修改个人信息</a></li>
                                    <li><a id="updatePasswordBtn" tabindex="-1" href="#"><i class="icon-asterisk"></i> 修改密码</a></li>
                                    <li><a id="logoutBtn" tabindex="-1" href="#"><i class="icon-share"></i> 退出</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <decorator:body/>
        
        <!-- 修改个人信息窗口 -->
        <div id="updateLoginInfoModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateLoginInfoLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="updateLoginInfoLabel">修改个人信息</h3>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button id="updateLoginInfoSaveBtn" class="btn btn-primary">保存</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
        
        <!-- 修改密码窗口 -->
        <div id="updatePasswordModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updatePasswordLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="updatePasswordLabel">修改密码</h3>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button id="updatePasswordSaveBtn" class="btn btn-primary">保存</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </body>
</html>