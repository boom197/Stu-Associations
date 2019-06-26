<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="cn.util.Const"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <meta charset="utf-8">
  <title>添加新闻</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" type="image/png" href="<%=Const.ROOT%>assets/i/favicon.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="<%=Const.ROOT%>assets/css/amazeui.min.css"/>
  <link rel="stylesheet" href="<%=Const.ROOT%>assets/css/admin.css">
    <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/font.css"/>
  <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css">
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>添加新闻</small></div>
      </div>
      <hr>
   <form class="layui-form" action="<%=Const.ROOT%>news/add" enctype="multipart/form-data" method="post" style="padding-right: 10px">
   <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">新闻标题</label>
    <div class="layui-input-block">
      <input type="text" name="n_title" required lay-verify="required"  autocomplete="off" class="layui-input">    
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="width:100px;">上传图片</label>
    <div class="layui-input-block">
      <input type="file" name="pacFile" id="file0" accept="image/*" /><br>
      <img src="image/" id="img0" style="width: 20rem;height: 15rem;">
      </div>
    </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label" style="width:100px;">新闻内容</label>
    <div class="layui-input-block">
     <textarea id="demo" name="n_content" style="display: none;"></textarea>
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
    </div>
    <%@include file="footer.jsp" %>
  </div>
  <!-- content end -->
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>      
<script src="<%=Const.ROOT%>layui/layui.js" charset="utf-8"></script>
<script>
layui.use(['layedit','laydate', 'laypage', 'layer', 'table','upload'], function(){
  var layedit = layui.layedit
  ,laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table //表格
  ,upload=layui.upload;
  layedit.build('demo', {
  tool: ['left', 'center', 'right', '|', 'strong' ,'italic','underline','del']
});  
      $("#file0").change(function() {
				var objUrl = getObjectURL(this.files[0]); //获取文件信息  
				console.log("objUrl = " + objUrl);
				if (objUrl) {
					$("#img0").attr("src", objUrl);
				}
			});

			function getObjectURL(file) {
				var url = null;
				if (window.createObjectURL != undefined) {
					url = window.createObjectURL(file);
				} else if (window.URL != undefined) { // mozilla(firefox)  
					url = window.URL.createObjectURL(file);
				} else if (window.webkitURL != undefined) { // webkit or chrome  
					url = window.webkitURL.createObjectURL(file);
				}
				return url;
			}  
});
</script>

</body>
</html>
