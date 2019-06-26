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
    <link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css">
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>
         	我参与的社团
        </small></div>
      </div>
  <hr>
				<div class="am-g">
						<div class="layui-row">
							<div class="layui-col-md12">
								<table class="layui-hide" id="demo" lay-filter="test"></table>
								<script type="text/html" id="barDemo">
                     <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="detail">查看</a>
                     <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">退出</a>
                 </script>
							</div>
						</div>

					</div>
    </div>
    <%@include file="footer.jsp" %>
  </div>
  <!-- content end -->
</div>

	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
	<script src="<%=Const.ROOT%>js/ajaxfileupload.js"></script>
  <script src="<%=Const.ROOT%>layui/layui.js" charset="utf-8"></script>
<script>
layui.use(['laydate', 'laypage', 'layer', 'table','element','form'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  ,layer = layui.layer //弹层
  ,table = layui.table //表格
  ,element=layui.element
  ,form=layui.form;
  
  //执行一个 table 实例
  var tableIns=table.render({
    elem: '#demo'
    ,height: 500
    ,url: '<%=Const.ROOT%>record/mysociety' //数据接口
    ,page: true //开启分页
    ,method:'post'
    ,skin:'nob'
    ,cols: [[ //表头
      {type: 'numbers',title: '编号',width:60}
       ,{field: 't_society', title: '社团名称', width: 200,align:'center'}
      ,{field: 't_time', title: '注册时间', width: 300,align:'center',sort: true, totalRow: true}
      ,{field: 't_name', title: '管理员', width: 140,align:'center'}
      ,{field: 't_phone', title: '电话号码', width: 150,align:'center'}
      ,{fixed: 'right',title: '操作', width: 400, align:'center', toolbar: '#barDemo'}
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
    if(layEvent === 'del'){
         layer.confirm('您确定要确定要退出吗？', {
           btn: ['确认','取消'] //按钮
       }, function(){
       console.log(data.t_id);
       	$.post("<%=Const.ROOT%>record/delete2",{"id":data.t_id},function(data){
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
  

});
</script>
</body>
</html>
