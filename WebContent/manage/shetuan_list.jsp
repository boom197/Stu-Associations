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
  <script src="<%=Const.ROOT%>My97DatePicker/WdatePicker.js"></script>
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>社团信息编辑</small></div>
      </div>
      <hr>
   <form class="layui-form" action="<%=Const.ROOT%>shetuan/update" method="post">
   <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">社团账号</label>
    <div class="layui-input-inline">
      <input type="text" name="t_number" required lay-verify="required" value="${sessionScope.currentUser.t_number}" autocomplete="off" class="layui-input">    
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">社团名称</label>
    <div class="layui-input-inline">
      <input type="text" name="t_society" required lay-verify="required" value="${sessionScope.currentUser.t_society}" autocomplete="off" class="layui-input">    
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">管理员</label>
    <div class="layui-input-inline">
      <input type="text" name="t_name" required lay-verify="required" value="${sessionScope.currentUser.t_name}" autocomplete="off" class="layui-input">    
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label" style="width:100px;">社团简介</label>
    <div class="layui-input-block" style="margin-left: 100px;">
      <textarea name="t_jianjie" required lay-verify="required"  placeholder="${sessionScope.currentUser.t_jianjie}" class="layui-textarea"></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" type="submit">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
    </div>
    <%@include file="footer.jsp" %>
  </div>
  <!-- content end -->
</div>
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
    <c:if test="${msg!=null}">
     	<script>
     	layui.use(['form','layer'], function(){
     		  var form = layui.form;
     		  var layer = layui.layer;
  		   layer.msg('${msg}');
     		});
  	   </script>
  	   <%request.setAttribute("msg",null);%>
  	   </c:if>
<script>

layui.use(['form','layer'], function(){
  var form = layui.form;
  var layer = layui.layer;
  
});
</script>

</body>
</html>
