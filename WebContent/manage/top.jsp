<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.currentUser==null}">
<script>
	alert("请先登录！");
	location.href="<%=Const.ROOT%>login.jsp";
</script>
</c:if>
<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
<header class="am-topbar am-topbar-inverse admin-header">
<div class="am-topbar-brand">
	<strong><a href="<%=Const.ROOT%>manage/index.jsp">学生社团管理系统</a>
	</strong>
	<small></small>
</div>

<button
	class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
	data-am-collapse="{target: '#topbar-collapse'}">
	<span class="am-sr-only">导航切换</span>
	<span class="am-icon-bars"></span>
</button>

<div class="am-collapse am-topbar-collapse" id="topbar-collapse">

	<ul
		class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
		<li class="am-dropdown" data-am-dropdown>
			<a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;"> 
			<span class="layui-icon layui-icon-user"></span>
			    <c:if test="${sessionScope.role==0}">
				&nbsp;${sessionScope.currentUser.a_name}&nbsp;
				</c:if>
				<c:if test="${sessionScope.role==1}">
				&nbsp;${sessionScope.currentUser.t_name}&nbsp;
				</c:if>
				<c:if test="${sessionScope.role==2}">
				&nbsp;${sessionScope.currentUser.s_name}&nbsp;
				</c:if>
				<span class="am-icon-caret-down"></span> 
				</a>
			<ul class="am-dropdown-content">
				<li>
					<a href="<%=Const.ROOT %>user/logout"><span
						class="am-icon-power-off"></span> 退出</a>
				</li>
			</ul>
		</li>
	</ul>
</div>
</header>