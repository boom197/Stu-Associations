<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.util.Const"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head lang="cn">
		<meta charset="UTF-8">
		<title>学生社团管理系统</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="format-detection" content="telephone=no">
		<meta name="renderer" content="webkit">
		<meta http-equiv="Cache-Control" content="no-siteapp" />
		<link rel="icon" type="image/png"
			href="<%=Const.ROOT%>assets/i/favicon.png">
	    <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/font.css">
		<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/weadmin.css">
		<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
		<script src="<%=Const.ROOT%>/js/jquery-3.1.1.min.js"></script>
		<script src="<%=Const.ROOT%>layui/layui.js" charset="utf-8"></script>

	</head>
	<body class="login-bg">

		<div class="login">
			<div class="message">
				学生社团管理系统
			</div>
			<div id="darkbannerwrap"></div>
			<form action="<%=Const.ROOT%>user/login" method="post"
				class="layui-form">
				<input name="username" placeholder="账号" type="text"
					lay-verify="required" class="layui-input">
				<hr class="hr15">
				<input name="password" lay-verify="required" placeholder="密码"
					type="password" class="layui-input">
				<hr class="hr15">
				<select name="role" lay-verify="required">
					<option value="">请选择身份</option>
		            <option value="0">超级管理员</option>
					<option value="1">社团管理员</option>
					<option value="2">学生</option>
				</select>
				<hr class="hr15">
				<div>
					<input class="loginin" value="登录" lay-submit style="width: 60%;"
						type="submit">
					<input id="re" class="loginin" value="注册"
						style="width: 35%; float: right;" type="button">
				</div>

				<hr class="hr15">
			</form>
		</div>
	</body>
	<div id="re1"
		style="display: none; text-align: center; padding-top: 20px;padding-right: 50px">
		<form class="layui-form" action="<%=Const.ROOT%>user/register"
			method="post">
			<div class="layui-form-item">
				<label class="layui-form-label">
					账号
				</label>
				<div class="layui-input-block">
					<input type="text" name="s_number" lay-verify="required|number"
						placeholder="请输入学号" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					密码
				</label>
				<div class="layui-input-block">
					<input type="password" name="s_pass" required
						lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					姓名
				</label>
				<div class="layui-input-block">
					<input type="text" name="s_name" required lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					班级
				</label>
				<div class="layui-input-block">
					<input type="text" name="s_class" required lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					年级
				</label>
				<div class="layui-input-block">
					<select name="s_grade" lay-verify="required">
						<option value="">请选择所在年级</option>
						<option value="大一">大一</option>
						<option value="大二">大二</option>
						<option value="大三">大三</option>
						<option value="大四">大四</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					学院
				</label>
				<div class="layui-input-block">
					<select name="s_college" lay-verify="required" lay-search="">
						<option value="">请选择所在学院</option>
						<option value="电子与信息学院">电子与信息学院</option>
						<option value="海运学院">海运学院</option>
						<option value="机械学院">机械学院</option>
						<option value="海洋学院">海洋学院</option>
						<option value="体育学院">体育学院</option>
						<option value="石油与化工学院">石油与化工学院</option>
						<option value="人文学院">人文学院</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">
					电话号码
				</label>
				<div class="layui-input-block">
					<input type="tel" name="s_phone" lay-verify="required|phone"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="formDemo">
						注册
					</button>
					<button type="reset" class="layui-btn layui-btn-primary">
						重置
					</button>
				</div>
			</div>
		</form>
	</div>
	<c:if test="${msg!=null}">
		<script>
     	layui.use(['form', 'layer'], function() {
			var form = layui.form,
				layer = layui.layer;
  		   layer.msg('${msg}');
		});
  	   </script>
	</c:if>
	<c:if test="${msg2!=null}">
		<script>
  		  layui.use(['form', 'layer'], function() {
			var form = layui.form,
				layer = layui.layer;
  		   layer.msg('${msg2}');
		});
  	   </script>
	</c:if>

	<script type="text/javascript">
		layui.use(['form', 'layer'], function() {
			var form = layui.form,
				layer = layui.layer;
			$("#re").click(function() {
				layer.open({
					type: 1,
					title: '学生注册',
					content: $('#re1'),
					area: ['550px', '520px'],
				});
			});
		});
	</script>
</html>
