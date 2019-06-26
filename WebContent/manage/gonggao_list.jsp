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
		<link rel="icon" type="image/png"
			href="<%=Const.ROOT%>assets/i/favicon.png">
		<meta name="apple-mobile-web-app-title" content="Amaze UI" />
		<link rel="stylesheet"
			href="<%=Const.ROOT%>assets/css/amazeui.min.css" />
		<link rel="stylesheet" href="<%=Const.ROOT%>assets/css/admin.css">
		<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css" />
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
							<strong class="am-text-primary am-text-lg">首页</strong> /
							<small> 通告管理 </small>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-md12" style="margin-top: 10px;padding-left: 2px">
							<button id="add" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe608;</i> 添加
							</button>
							<button id="alldel" class="layui-btn layui-btn-sm layui-btn-warm">
								<i class="layui-icon">&#xe640;</i> 批量删除
							</button>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-md12">
							<table class="layui-hide" id="demo" lay-filter="test"></table>
							<script type="text/html" id="barDemo">
                        <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="edit">编辑</a>
                     <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
                 </script>
						</div>
					</div>
				</div>
				<%@include file="footer.jsp"%>
			</div>
			<!-- content end -->
		</div>

	</body>
	<div id="addshow" style="display: none; padding-top: 10px;">
		<form class="layui-form" action="<%=Const.ROOT%>gonggao/add"
			method="post">
			<div class="layui-row">
				<div class="layui-col-md12" style="padding: 10px">
					<textarea id="content" name="g_content" class="layui-textarea"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button type="submit" class="layui-btn" lay-submit
						lay-filter="formDemo">
						立即提交
					</button>
					<button type="reset" class="layui-btn layui-btn-primary">
						重置
					</button>
				</div>
			</div>
		</form>
	</div>
	<div id="edit" style="display: none; padding-top: 10px;">
		<form class="layui-form" action="<%=Const.ROOT%>gonggao/update"
			method="post">
			<input type="hidden" id="id" name="g_id" />
			<div class="layui-row">
				<div class="layui-col-md12" style="padding: 10px">
					<textarea id="content" name="g_content" class="layui-textarea"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button type="submit" class="layui-btn" lay-submit
						lay-filter="formDemo">
						立即提交
					</button>
					<button type="reset" class="layui-btn layui-btn-primary">
						重置
					</button>
				</div>
			</div>
		</form>
	</div>
	<script src="<%=Const.ROOT%>js/jquery-3.1.1.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>layui/layui.js"></script>
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
    ,height: 520
    ,url: '<%=Const.ROOT%>gonggao/notice1' //数据接口
    ,page: true //开启分页
    ,method:'post'
    ,skin:'nob'
    ,cols: [[ //表头
      {type: 'checkbox', fixed: 'left',width:60}
     ,{type:'numbers',title:'编号',align:'center',width:100}
      ,{field: 'g_content', title: '内容',align:'center', width:500}
      ,{field: 'g_time', title: '发布时间', width: 300,align:'center', sort: true, totalRow: true}
      ,{fixed: 'right',title: '操作', width: 295, align:'center', toolbar: '#barDemo'}
    ]]
    ,id:'testReload'
  });
  
  //监听行工具事件
  table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    if(layEvent === 'edit'){
		$("#edit #id").val(data.g_id);
		$("#edit #content").val(data.g_content);
       layer.open({
		type: 1,
		title: '编辑公告',
		content: $('#edit'),
		area: ['400px', '250px'],
      });
      }else if(layEvent === 'del'){
         layer.confirm('您确定要删除吗？', {
           btn: ['确认','取消'] //按钮
       }, function(){
       	$.post("<%=Const.ROOT%>gonggao/delete",{"id":data.g_id},function(data){
			layer.msg(data.data);
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
  
  //添加
  $(document).on('click','#add',function(){
      layer.open({
		type: 1,
		title: '添加公告',
		content: $('#addshow'),
		area: ['400px', '250px'],
      });
});

 //批量删除
    $('#alldel').on('click', function(){
     var checkStatus = table.checkStatus('testReload');
	 if(checkStatus.data.length==0){
		parent.layer.msg('请先选择要删除的数据行！', {icon: 2});
		return ;
	  }
	  var ids = "";
	   for(var i=0;i<checkStatus.data.length;i++){
		ids += checkStatus.data[i].g_id+",";
	   }
	   console.log(ids);
	   parent.layer.msg('删除中...', {icon: 16,shade: 0.3,time:5000});
	   $.post('<%=Const.ROOT%>gonggao/alldel',
            {'ids':ids},
            function(data){
		        layer.closeAll('loading');
		        if(data.code==200){
			        parent.layer.msg('删除成功！', {icon: 1,time:2000,shade:0.2});
			         tableIns.reload();
		        }else{
			        parent.layer.msg('删除失败！', {icon: 2,time:3000,shade:0.2});
		        }
	        }
    );

});

});
</script>
</html>
