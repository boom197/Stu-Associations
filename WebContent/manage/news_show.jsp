<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>学生社团管理系统</title>
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" type="image/png" href="<%=Const.ROOT%>assets/i/favicon.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
  <link rel="stylesheet" href="<%=Const.ROOT%>assets/css/amazeui.min.css"/>
  <link rel="stylesheet" href="<%=Const.ROOT%>assets/css/admin.css">
  <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/font.css"/>
</head>
<body>
<%@include file="top.jsp" %>
<div class="am-cf admin-main">
  <!-- sidebar start -->
  <%@include file="navigation.jsp" %>
  <!-- sidebar end -->

  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>新闻详细信息</small></div>
      </div>
		<hr>
		<div class="layui-container">
			<div class="layui-row">
				<div class="layui-col-md12" style="text-align: center;">
					<h1>${requestScope.news.n_title}</h1>
				</div>
			</div>
			<div class="layui-row" style="margin-top: 5px">
				<div class="layui-col-md12" style="text-align: center;">
					发布人：${requestScope.news.n_user}&nbsp;&nbsp;&nbsp;时间：${requestScope.news.n_time}
				</div>
			</div>
			<c:if test="${requestScope.news.n_pic!=null}">
			<div class="layui-row" style="margin-top: 10px">
				<div class="layui-col-md12">
				    <img alt="请检查图片格式！" src="/pic/${requestScope.news.n_pic}" style="width:1100px;height: 560px">
				</div>
			</div>
			</c:if>
			<div class="layui-row" style="margin-top: 10px">
				<div class="layui-col-md12">
				    <p >${requestScope.news.n_content}</p>
				</div>
			</div>
		</div>
	</div>
    <%@include file="footer.jsp" %>
  </div>
  <!-- content end -->
</div>
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
<script>

layui.use(['form','layer'], function(){
  var form = layui.form;
  var layer = layui.layer;
  
});
</script>

</body>
</html>
