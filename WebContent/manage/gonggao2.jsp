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
  <link rel="icon" type="image/png" href="<%=Const.ROOT %>assets/i/favicon.png">
  <link rel="apple-touch-icon-precomposed" href="<%=Const.ROOT %>assets/i/app-icon72x72@2x.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
  <link rel="stylesheet" href="<%=Const.ROOT %>assets/css/amazeui.min.css"/>
  <link rel="stylesheet" href="<%=Const.ROOT %>assets/css/admin.css">
  <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
  以获得更好的体验！</p>
<![endif]-->

<%@include file="top.jsp" %>

<div class="am-cf admin-main">
  <!-- sidebar start -->
 <%@include file="navigation.jsp" %>
  <!-- sidebar end -->

  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>社团公告</small></div>
      </div>
				<div class="layui-row">
					<div class="layui-col-md12">
						<table class="layui-table" style="text-align: center;">
							<colgroup>
								<col width="150" >
								<col width="300" >
								<col width="300" >
								<col width="200" >
								<col>
							</colgroup>
							<thead>
								<tr>
									<th style="text-align: center;">编号</th>
									<th style="text-align: center;">社团名称</th>
									<th style="text-align: center;">发布时间</th>
									<th style="text-align: center;">公告内容</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${requestScope.list2!=null}">
									<c:forEach items="${requestScope.list2}" var="item"
										varStatus="st">
										<!-- 循环开始 -->
										<tr>
											<td>${st.count}</td>
											<td>${item.g_name}</td>
											<td>${item.g_time}</td>
											<td><button class="layui-btn layui-btn-sm"
													onclick="show('${item.g_id}')">查看</button></td>
										</tr>
										<!-- 循环结束 -->
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
      </div>
    <%@include file="footer.jsp" %>
  </div>
  <div id="notice" style="padding:20px; line-height: 22px; background-color: #F0F0F0; color: #2F4056; font-weight: 300;"></div>
<script src="<%=Const.ROOT%>js/jquery-3.1.1.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
	<script src="<%=Const.ROOT%>js/ajaxfileupload.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
<script>
  //执行一个 table 实例
   function show(id){
layui.use(['laydate', 'laypage', 'layer', 'table'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table; //表格
	$.getJSON("<%=Const.ROOT%>gonggao/show",{"id":id},function(data){
	 $("#notice").html(data.g_content);
	 console.log(data.g_content);
      layer.open({
        type: 1
        ,title: '公告内容' //不显示标题栏
        ,closeBtn: false
        ,area: '300px;'
        ,shade: 0.8
        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
        ,btn: '我知道了'
        ,btnAlign: 'c'
        ,moveType: 1 //拖拽模式，0或者1
        ,content: $('#notice')
        ,success: function(layero){
          var btn = layero.find('.layui-layer-btn');
          btn.find('.layui-layer-btn0').attr({
          target: '_blank'
          });
        }
      });
	});
});
    }

  

</script>
</body>
</html>
