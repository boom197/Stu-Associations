<%@page import="cn.util.Const"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>成员管理</title>
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
		<link rel="stylesheet" href="<%=Const.ROOT%>layui/css/layui.css">
		<script src="<%=Const.ROOT%>My97DatePicker/WdatePicker.js"></script>
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
							<small> 社团成员管理 </small>
						</div>
					</div>
					<hr>
					<div class="am-g" >
					<div style="float: left;margin-left: 2px">
				     <button id="alldel" class="layui-btn layui-btn-sm layui-btn-warm">
								<i class="layui-icon">&#xe640;</i>批量删除
							</button>
							</div>
						<div class="demoTable" style="text-align: right;float:right">
							<div class="layui-inline" style="margin-left: 2px">
								<input class="layui-input" name="id" placeholder="请输入姓名"
									id="demoReload" autocomplete="off">
							</div>
							<button id="select" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe615;</i>查找
							</button> 
							<button id="execl" class="layui-btn layui-btn-sm layui-btn-normal">
								全部导出
							</button>
						</div>
					</div>

					<div class="layui-row">
						<div class="layui-col-md12">
							<table class="layui-hide" id="demo" lay-filter="test"></table>
							<script type="text/html" id="barDemo">
                     <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
                 </script>
						</div>
					</div>
				</div>
				<%@include file="footer.jsp"%>
			</div>
			<!-- content end -->
		</div>

		<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
		<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
		<script src="<%=Const.ROOT%>assets/js/app.js"></script>
		<script src="<%=Const.ROOT%>js/ajaxfileupload.js"></script>
		<script src="<%=Const.ROOT%>layui/layui.js" charset="utf-8"></script>
	</body>
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
    ,url: '<%=Const.ROOT%>record/al1stu' //数据接口
    ,page: true //开启分页
    ,method:'post'
    ,skin:'nob'
    ,cols: [[ //表头
      {type: 'checkbox', fixed: 'left',width:60}
      ,{field: 's_number', title: '学号',align:'center', width:100,sort: true, totalRow: true}
      ,{field: 's_name', title: '姓名', width: 100,align:'center'}
      ,{field: 's_class',title: '班级', width: 200,align:'center'}
      ,{field: 's_grade', title: '年级', width: 100,align:'center'}
      ,{field: 's_college', title: '学院', width: 200,align:'center'}
      ,{field: 's_phone', title: '电话号码', width: 300,align:'center'}
      ,{fixed: 'right',title: '操作', width: 195, align:'center', toolbar: '#barDemo'}
    ]]
    ,id:'testReload'
  });
  
  //监听行工具事件
  table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    if(layEvent === 'del'){
         layer.confirm('您确定要删除吗？', {
           btn: ['确认','取消'] //按钮
       }, function(){
       	$.post("<%=Const.ROOT%>record/delete3",{"id":data.s_id},function(data){
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
        ,where: {s_name:demoReload.val()}
      });
  });
  
  //导出
  $('#execl').on('click', function(){
    location.href="<%=Const.ROOT%>record/doex";
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
		ids += checkStatus.data[i].s_id+",";
	   }
	   console.log(ids);
	   parent.layer.msg('删除中...', {icon: 16,shade: 0.3,time:5000});
	   $.post('<%=Const.ROOT%>shetuan/alldel',
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
