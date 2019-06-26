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
  <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / 
        <small>
       <c:if test="${sessionScope.role==2}"> 
         	全部社团
        </c:if>
         <c:if test="${sessionScope.role==0}"> 
         	    社团管理
        </c:if>
        </small>
        </div>
      </div>
      <hr>
      <div class="am-g">
		<div class="demoTable" >
			<div class="layui-inline" style="margin-left: 2px">
				<input class="layui-input" name="id" placeholder="请输入社团名称"
					id="demoReload" autocomplete="off">
			</div>
				<button id="select" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe615;</i>查找
				</button>
				 <c:if test="${sessionScope.role==0}"> 
				<button id="add" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe608;</i>添加社团
				</button>  
                </c:if>
		</div>
      </div>
      <div class="am-g" style="text-align: center">
      <table class="layui-hide" id="demo" lay-filter="test"></table>
	   <script type="text/html" id="barDemo">
          <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="detail">查看</a>
       </script>
        <c:if test="${sessionScope.role==0}"> 
       <script type="text/html" id="del">
          <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="dell"><i class="layui-icon">&#xe640;</i>删除</a>
       </script>
       </c:if>
      </div>
    </div>
    <%@include file="footer.jsp" %>
  </div>
</div>
</body>
<div id="addshow"
		style="display: none; text-align: center; padding-top: 10px;padding-right: 50px">
		<form class="layui-form" action="<%=Const.ROOT%>shetuan/add"
			method="post">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 100px">
					账号
				</label>
				<div class="layui-input-block">
					<input type="text" name="t_number" lay-verify="required|number"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 100px">
					密码
				</label>
				<div class="layui-input-block">
					<input type="password" name="t_pass" required
						lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 100px">
					社团名称
				</label>
				<div class="layui-input-block">
					<input type="text" name="t_society" required lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 100px">
					管理员
				</label>
				<div class="layui-input-block">
					<input type="text" name="t_name" required lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 100px">
					电话号码
				</label>
				<div class="layui-input-block">
					<input type="tel" name="t_phone" lay-verify="required|phone"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="formDemo">
						添加
					</button>
					<button type="reset" class="layui-btn layui-btn-primary">
						重置
					</button>
				</div>
			</div>
		</form>
	</div>
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
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
layui.use(['laydate', 'laypage', 'layer', 'table','element'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element=layui.element;
  //执行一个 table 实例
  var tableIns=table.render({
    elem: '#demo'
    ,height: 500
    ,url: '<%=Const.ROOT%>shetuan/list0' //数据接口
    ,page: true //开启分页
    ,method:'post'
    ,skin:'nob'
    ,cols: [[ //表头
      {type:'numbers',title:'编号',align:'center',width:80}
      ,{field: 't_society', title: '社团名称',align:'center', width:200}
      ,{field: 't_time', title: '注册时间', width: 250,align:'center', sort: true, totalRow: true}
      ,{field: 't_name', title: '管理员', width: 200,align:'center'}
      ,{field: 't_phone', title: '电话', width: 250, align:'center'}
      ,{fixed: 'right',title: '详细信息', width: 150, align:'center', toolbar: '#barDemo'}
      ,{fixed: 'right', width: 125, align:'center', toolbar: '#del'}
    ]]
    ,id:'testReload'
  });
  
  //监听行工具事件
  table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    if(layEvent === 'detail'){
    	location.href="<%=Const.ROOT%>shetuan/xiangxi?id="+data.t_id;
      }
      if(layEvent === 'dell'){
       layer.confirm('您确定要删除吗？', {
           btn: ['确认','取消'] //按钮
       }, function(){
       $.post("<%=Const.ROOT%>shetuan/delete",{"id":data.t_id},function(data){
				layer.msg(data.data,{icon: 1,time:2000,shade:0.2});
			 tableIns.reload();
        });
        }, function(){
        });
        }
     });
  
  //分页
  laypage.render({
    elem: 'pageDemo' //分页容器的id
    ,count: 100 //总页数
    ,skin: '#1E9FFF' //自定义选中色值
    //,skip: true //开启跳页
    ,jump: function(obj, first){
      if(!first){
        layer.msg('第'+ obj.curr +'页', {offset: 'b'});
      }
    }
  });
  //查找
  var $ = layui.$;
  $('#select').on('click', function(){
     var demoReload = $('#demoReload');
      console.log(demoReload.val());
      //执行重载
      table.reload('testReload', {
        page: {
          curr: 1 //重新从第 1 页开始
        }
        ,where: {t_society:demoReload.val()}
      });
  });
  //添加社团
  $('#add').on('click', function(){
				layer.open({
					type: 1,
					title: '添加社团',
					content: $('#addshow'),
					area: ['550px', '420px'],
				});
  });
});
</script>
</html>
