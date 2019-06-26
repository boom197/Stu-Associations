<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>修改密码</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=Const.ROOT%>assets/i/favicon.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=Const.ROOT%>assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=Const.ROOT%>assets/css/admin.css">
<script>
function update(){
	var oldpassword=$("#oldPassword").val();
	var newpass=$("#newpass").val();
	var newpass2=$("#newpass2").val();
	if(oldPassword!=""){
		if(newpass==""){
			alert("新密码不能为空");
			return false;
		}
		if(newpass!=newpass2){
			alert("两次密码不一致");
			return false;
		}
	}else{
		alert("原始密码不能为空");
		return false;
	}
	$.post("<%=Const.ROOT%>user/updatepwd1",{"password":oldpassword,"password1":newpass},function(data){
		alert(data.data);
		if(data.code==200){
			location.href="<%=Const.ROOT%>login.jsp";
		}
	});
}
</script>
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
						<strong class="am-text-primary am-text-lg">首页</strong> / <small>登录密码修改</small>
					</div>
				</div>
				<hr>

				<div class="am-g">
					<div class="am-u-sm-12">
						<form action="" method="post">
							<table class="am-table am-table-striped am-table-hover table-main">
								<!-- 循环开始 -->
								<tr>
									<td>原密码：</td>
									<td><input type="password" id="oldPassword" /></td>
								</tr>
								<tr>
									<td>新密码：</td>
									<td><input type="password" id="newpass" /></td>
								</tr>
								<tr>
									<td>确认密码：</td>
									<td><input type="password" id="newpass2" /></td>
								</tr>
								<tr>
									<td colspan="2"  style="text-align:center;">
										<div class="am-btn-toolbar">
											<div class="am-btn-group am-btn-group-xs" >
												<button type="button"
													class="am-btn am-btn-default am-btn-xs am-text-secondary"
													onclick="update()">
													<span class="am-btn-default"></span> 修改密码
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
</body>
</html>
