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
  <script src="<%=Const.ROOT%>My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<%@include file="top.jsp" %>

<div class="am-cf admin-main">
  <!-- sidebar start -->
  <%@include file="navigation.jsp"%>
  <!-- sidebar end -->

  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>
        <c:if test="${sessionScope.role==1}">
         	社团职位管理
         </c:if>
         <c:if test="${sessionScope.role==2}">
         	社团职位申请
         </c:if>
        </small></div>
      </div>
      <hr>
      <div class="am-g">
      <!-- 搜索 -->
		<form action="<%=Const.ROOT%>job/list" method="post" id="sform">
			<input type="hidden" name="pageNo" value="1" id="pageNo" />
			<div class="am-u-sm-12 am-u-md-6">
	          <div class="am-btn-toolbar">
	            <div class="am-btn-group am-btn-group-xs">
	             <c:if test="${sessionScope.role==1}">
	             	<button type="button" class="am-btn am-btn-primary" onclick="doAdd()">
	              		<span class="am-icon-plus"></span> 添加
	              	</button>
	             </c:if>
	            </div>
	          </div>
	        </div>
			<div class="am-u-sm-12 am-u-md-6 am-text-right">
						名称：<input type="text" name="name" size="20"/> 
						<button type="submit" class="am-btn am-btn-primary am-btn-sm">
			              	查询
			            </button>
			</div>
		</form>
        
      </div>

      <div class="am-g">
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
              <thead>
              <tr>
                <th class="table-id">编号</th>
                <th class="table-title">社团名称</th>
                <th class="table-title">职位</th>
                <th class="table-title">职位描述</th>
                <th class="table-set">操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${requestScope.list}" var="item" varStatus="st">
              <!-- 循环开始 -->
              <tr>
                <td>${st.count}</td>
                <td>${item.z_name}</td>
                <td>${item.z_zhiwei}</td>
                <td>${item.z_jieshao}</td>
                <td>
                  <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                   	 	<c:if test="${sessionScope.role!=2}">
                    		<button type="button" class="am-btn am-btn-default am-btn-xs am-text-secondary" onclick="toUpdate('${item.z_id}')"><span class="am-icon-pencil-square-o"></span> 修改</button>
                      		<button type="button" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="doDelete('${item.z_id}')"><span class="am-icon-trash-o"></span> 删除</button>
                      	</c:if>
                      	<c:if test="${sessionScope.role==2}">
                      		<button type="button" class="am-btn am-btn-default am-btn-xs am-text-secondary" onclick="toSq('${item.z_id}')"><span class="am-icon-pencil-square-o"></span> 申请</button>
                      	</c:if>
                    </div>
                  </div>
                </td>
              </tr>
              <!-- 循环结束 -->
              </c:forEach> 
              </tbody>
            </table>
        </div>
      </div>
    </div>
    <%@include file="footer.jsp" %>
  </div>
  <!-- content end -->
</div>
<!-- 删除对话框begin -->
<div class="am-modal am-modal-confirm" tabindex="-1" id="delete_modal">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">你，确定要删除这条记录吗？</div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="sq-modal" data-am-validator>
  <div class="am-modal-dialog">
    <div class="am-modal-hd">申请理由
      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
    </div>
    <div class="am-modal-bd">
		<form class="am-form" name="addForm" action="<%=Const.ROOT%>record/add" method="post">
		    <input type="hidden" id="id" name="id" />	
			<div class="am-g am-margin-top"><!--  style="margin-top:4px;" -->
				  <div class="am-u-sm-3 am-u-md-3 am-text-right">
					申请理由
				  </div>
				  <div class="am-u-sm-9 am-u-md-9 am-u-end col-end">
					<textarea name="apply_why" id="content" rows="4" required></textarea>	
				  </div>
			</div>
			<div class="am-margin-top">
		      <button type="submit" class="am-btn am-btn-primary am-btn-xs">提交</button>
		      <button type="reset" class="am-btn am-btn-primary am-btn-xs">清空</button>
		    </div>
          </form>
    </div>
  </div>
</div>

<div class="am-modal am-modal-no-btn" tabindex="-1" id="add-modal" data-am-validator>
  <div class="am-modal-dialog">
    <div class="am-modal-hd">增加职位
      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
    </div>
    <div class="am-modal-bd">
		<form class="am-form" name="addForm" action="<%=Const.ROOT%>job/add" method="post">
			<div class="am-g am-margin-top"><!--  style="margin-top:4px;" -->
				  <div class="am-u-sm-3 am-u-md-3 am-text-right">
					职位名称
				  </div>
				  <div class="am-u-sm-9 am-u-md-9 am-u-end col-end">
					<input type="text" id="name" name="z_zhiwei" class="am-input-sm" required>	
				  </div>
			</div>	
			
			<div class="am-g am-margin-top"><!--  style="margin-top:4px;" -->
				  <div class="am-u-sm-3 am-u-md-3 am-text-right">
					职位描述
				  </div>
				  <div class="am-u-sm-9 am-u-md-9 am-u-end col-end">
					<textarea name="z_jieshao" id="content" rows="4" required></textarea>	
				  </div>
			</div>
			<div class="am-margin-top">
		      <button type="submit" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
		      <button type="reset" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
		    </div>
          </form>
    </div>
  </div>
</div>

<div class="am-modal am-modal-no-btn" tabindex="-1" id="update-modal" data-am-validator>
  <div class="am-modal-dialog">
    <div class="am-modal-hd">修改
      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
    </div>
    <div class="am-modal-bd">
		<form class="am-form" name="updateForm" action="<%=Const.ROOT%>job/update" method="post">
			<input type="hidden" id="id" name="z_id" />	
			<div class="am-g am-margin-top"><!--  style="margin-top:4px;" -->
				  <div class="am-u-sm-3 am-u-md-3 am-text-right">
					职位名称
				  </div>
				  <div class="am-u-sm-9 am-u-md-9 am-u-end col-end">
					<input type="text" id="name" name="z_zhiwei" class="am-input-sm" required>	
				  </div>
			</div>	
			
			<div class="am-g am-margin-top"><!--  style="margin-top:4px;" -->
				  <div class="am-u-sm-3 am-u-md-3 am-text-right">
					职位描述
				  </div>
				  <div class="am-u-sm-9 am-u-md-9 am-u-end col-end">
					<textarea name="z_jieshao" id="content" rows="4" required></textarea>	
				  </div>
			</div>
			
			<div class="am-margin-top">
		      <button type="submit" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
		      <button type="reset" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
		    </div>
          </form>
    </div>
  </div>
</div>

<!-- 新增对话框 end-->
<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--<![endif]-->
	<script src="<%=Const.ROOT%>assets/js/jquery.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/amazeui.min.js"></script>
	<script src="<%=Const.ROOT%>assets/js/app.js"></script>
	<script src="<%=Const.ROOT%>My97DatePicker/WdatePicker.js"></script>
	<c:if test="${msg!=null}">
     	<script>
     	 if(${msg}==0){
  		   alert("您已经申请过本职位了！");
  		   location.href="<%=Const.ROOT%>job/list";
  		   }
  		if(${msg}==1){
  		   alert("申请成功！");
  		   location.href="<%=Const.ROOT%>record/apply2";
  		   }
  	   </script>
    </c:if>
<script>

function doDelete(id){
	$("#delete_modal").modal({
        relatedTarget: this,
        onConfirm: function(options) {
        	//执行删除
        	location.href="<%=Const.ROOT%>job/delete?id="+id;
        },
        onCancel: function() {
        }
      });
}
function doAdd(){
	$("#add-modal").modal({width:500,height:280});
}

function toSq(hid){
    $("#sq-modal #id").val(hid);
    $("#sq-modal").modal({width:500,height:280});
	//$.getJSON("<%=Const.ROOT%>record/add",{"hid":hid},function(data){
	//	alert(data.data);
	//	if(data.code==200){
		//	location.href="<%=Const.ROOT%>record/list";
		//}
	//});
}
function toUpdate(id){
	$.getJSON("<%=Const.ROOT%>job/jsondetail",{"id":id},function(data){
		$("#update-modal #id").val(id);
		$("#update-modal #name").val(data.z_zhiwei);
	
		$("#update-modal #content").val(data.z_jieshao);
		$("#update-modal").modal({width:500,height:280});
	});
}

</script>
</body>
</html>
