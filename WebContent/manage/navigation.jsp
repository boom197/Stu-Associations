<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
 <script type="text/javascript" src="<%=Const.ROOT%>layui/layui.js"></script>
  <div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    
      <ul class="layui-nav layui-nav-tree" lay-filter="test" style="width:100%;height:100%">
        <li class="layui-nav-item"><a href="<%=Const.ROOT%>user/newslist"><span class="am-icon-home"></span> 首页</a></li>
        <!-- 管理员的菜单开始 -->
          <c:if test="${sessionScope.role==0}">
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/news_list.jsp">新闻管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>user/list">学生管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>shetuan/list">社团管理</a></li>
          </c:if>
          <c:if test="${sessionScope.role==1}">
                <li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/news_list.jsp">发布新闻</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>gonggao/list1">通告管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>record/apply1">申请管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>job/list">职位管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>record/list1">成员管理</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/shetuan_list.jsp">社团编辑</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/updatepwd1.jsp">密码修改</a></li>
          </c:if>
          <c:if test="${sessionScope.role==2}"> 
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>gonggao/list2/${sessionScope.currentUser.s_id}">社团公告</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>shetuan/list">全部社团</a></li>	
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>job/list">社团申请</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>record/apply2">我的申请</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>record/list2">我的社团</a></li>
             	<li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/userInfo.jsp">个人资料</a></li> 
           		<li class="layui-nav-item"><a href="<%=Const.ROOT%>manage/updatepwd.jsp">密码修改</a></li>
          </c:if>
            	<li class="layui-nav-item"><a href="<%=Const.ROOT%>user/logout">安全退出</a></li>
		<!-- 管理员的菜单结束 -->
     	
      </ul>
    
  </div>
  <script>
			layui.use('element', function() {
				var element = layui.element;
			});
		</script>