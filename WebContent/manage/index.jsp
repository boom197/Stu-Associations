<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js fixed-layout">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>后台管理系统</title>
		<meta name="description" content="这是一个 index 页面">
		<meta name="keywords" content="index">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="renderer" content="webkit">
		<meta http-equiv="Cache-Control" content="no-siteapp" />
		<link rel="icon" type="image/png"
			href="<%=Const.ROOT %>assets/i/favicon.png">
		<link rel="apple-touch-icon-precomposed"
			href="<%=Const.ROOT %>assets/i/app-icon72x72@2x.png">
		<meta name="apple-mobile-web-app-title" content="Amaze UI" />
		<link rel="stylesheet"
			href="<%=Const.ROOT %>assets/css/amazeui.min.css" />
		<link rel="stylesheet" href="<%=Const.ROOT %>assets/css/admin.css">
		<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
	</head>
	<body>
		<%@include file="top.jsp"%>
		<div class="am-cf admin-main">
			<!-- sidebar start -->
			<%@include file="navigation.jsp"%>
			<!-- sidebar end -->

			<!-- content start -->
			<div class="admin-content">
				<div class="admin-content-body">
					<div class="am-cf am-padding">
						<div class="am-fl am-cf">
							<strong class="am-text-primary am-text-lg">首页</strong>
						</div>
					</div>
					<div class="am-g">
						<div class="am-u-sm-12 am-text-center">
							<h1>
								欢迎使用学生社团管理系统
							</h1>
						</div>
					</div>
                     <br/>
					<div class="layui-container">
						<div class="layui-row">
							<div class="layui-col-md12">
								<h2>最新新闻  <i class="layui-icon" style="color: red">&#xe756;</i> </h2>
							</div>
						</div>
					</div>
					<br/>
					<div class="layui-container">
						  <c:forEach items="${requestScope.list}" var="item" varStatus="st">
						  <div class="layui-row">
							<div class="layui-col-md12" style="margin-bottom: 5px">
							<div style="float:left;"><a href="<%=Const.ROOT%>news/show?id=${item.n_id}" style="font-size:15px;">${item.n_title}</a></div>
							<div style="float:right;color:#1E9FFF">${item.n_time}</div>
						    <hr class="layui-bg-gray">
							</div>
						</div>
						</c:forEach> 
					</div>
				</div>
			</div>
			<%@include file="footer.jsp"%>
		</div>
	</body>
	<script src="<%=Const.ROOT %>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT %>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT %>assets/js/app.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
	<script>
layui.use(['laydate', 'laypage', 'layer', 'table'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table; //表格
  
  
});
</script>
</html>
