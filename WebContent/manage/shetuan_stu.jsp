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
					<h1>${requestScope.shetuan.t_society}</h1>
				</div>
			</div>
			<div class="layui-row" style="margin-top: 20px">
				<div class="layui-col-md12"">
					社团简介：${requestScope.shetuan.t_jianjie}
				</div>
			</div>
			<div class="layui-row" style="margin-top: 20px">
					<div class="layui-col-md12">
					社团成员：
						<table class="layui-table">
							<colgroup>
								<col width="80">
								<col width="150">
								<col width="150">
								<col width="150">
								<col width="150">
								<col width="150">
								<col width="200">
								<col>
							</colgroup>
							<thead>
								<tr>
								    <th>编号</th>
									<th>学号</th>
									<th>姓名</th>
									<th>班级</th>
									<th>年级</th>
									<th>学院</th>
									<th>电话号码</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${requestScope.list!=null}">
									<c:forEach items="${requestScope.list}" var="item"
										varStatus="st">
										<!-- 循环开始 -->
										<tr>
											<td>${st.count}</td>
											<td>${item.s_number}</td>
											<td>${item.s_name}</td>
											<td>${item.s_class}</td>
											<td>${item.s_grade}</td>
											<td>${item.s_college}</td>
											<td>${item.s_phone}</td>
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