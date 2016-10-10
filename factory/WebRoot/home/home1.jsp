<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>home</title>
</head>
<body>
<div class="container" style="margin-top:15px;">
    <div class="row-fluid">
        <div class="span2 offset1">
            <ul class="nav nav-list">
                <li class="nav-header">反应物</li>
                <li><a href="#">煤</a></li>
                <li><a href="#">稻壳</a></li>
                <li><a href="#">中药渣</a></li>
                <li><a href="#">矿物盐</a></li>
                <li><a href="#">石油</a></li>
                <li class="active"><a href="#">乙醇</a></li>
                <li><a href="#">煤油</a></li>
            </ul>
            <br/>
            <a href="#" style="font-size:10px;">&nbsp;&nbsp;+&nbsp;新建反应物模型</a>
        </div>
        <div class="span8">
            <div class="tabbable"> <!-- Only required for left/right tabs -->
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab1" data-toggle="tab">反应物</a></li>
					<li><a href="#tab2" data-toggle="tab">测试方法</a></li>
					<li><a href="#tab3" data-toggle="tab">测试条件</a></li>
					<li><a href="#tab4" data-toggle="tab">测试结果</a></li>
					<li><a href="#tab5" data-toggle="tab">测试信息</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<p></p>
					</div>
					<div class="tab-pane" id="tab2">
						<p></p>
					</div>
				</div>
			</div>
        </div>
    </div>
</div>
</body>
</html>
