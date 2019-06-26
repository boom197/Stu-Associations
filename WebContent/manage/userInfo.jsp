<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>个人资料修改</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=Const.ROOT%>assets/i/favicon.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=Const.ROOT%>assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=Const.ROOT%>assets/css/admin.css">

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
				<div class="am-cf am-padding am-padding-bottom-0">
					<div class="am-fl am-cf">
						<strong class="am-text-primary am-text-lg">首页</strong> / <small>个人资料修改</small>
					</div>
				</div>
				<hr>

				<div class="am-g">
					<div class="am-u-sm-12">
						<form action="<%=Const.ROOT%>user/updateInfo" method="post" onsubmit="return checkall()">
							<table class="am-table am-table-striped am-table-hover table-main">
								<input type="hidden" name="s_id" value="${currentUser.s_id}"/>
								<tr>
									<td>学号：</td>
									<td><input type="text" id="s_number" name="s_number" value="${currentUser.s_number}" readonly="readonly"/></td>
								</tr>
								<tr>
									<td>姓名：</td>
									<td><input type="text" id="s_name" name="s_name" value="${currentUser.s_name}" readonly="readonly"/></td>
								</tr>
								<tr>
									<td>班级：</td>
									<td><input type="text" name="s_class" id="phone" value="${currentUser.s_class}" required/></td>
								</tr>
								<tr>
									<td>年级：</td>
									<td><input type="text" name="s_grade" id="phone" value="${currentUser.s_grade}" required/></td>
								</tr>
								<tr>
									<td>学院：</td>
									<td><input type="text" name="s_college" id="phone" value="${currentUser.s_college}" required/></td>
								</tr>
								<tr>
									<td>电话：</td>
									<td><input type="text" name="s_phone" id="phone" value="${currentUser.s_phone}" required/></td>
								</tr>
								
								<tr>
									<td colspan="2"  style="text-align:center;">
										<div class="am-btn-toolbar">
											<div class="am-btn-group am-btn-group-xs" >
												<button type="submit"
													class="am-btn am-btn-default am-btn-xs am-text-secondary">
													<span class="am-btn-default"></span> 提交保存
												</button>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<%@include file="footer.jsp"%>
		</div>
		<!-- content end -->
	</div>

	<!--<![endif]-->
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
	<c:if test="${msg!=null}">
     	<script>
  		   alert("${msg}");
  	   </script>
    </c:if>
</body>
</html>
