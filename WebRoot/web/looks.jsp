<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../plug_in/main/jsp/util.jsp"></c:import>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta charset="utf-8" />
<title></title>

  </head>
  
  <body class="">
  		 <table id="dgs" style="width: 100%;height: 400px">
  		 	</table>
  		 	<script type="text/javascript">
  		 	$(function(){
  		 		$("#dgs").datagrid({
  		 			singleSelect:false,
  					fitColumns : true,
  					fit : true,
  					rownumbers:true,
  		 			columns:[[
  							 {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
  		 			         {field:'ID',title:'id',width:100,align:'center',hidden:'true'},   
  		 			         {field:'BOOKNAME',title:'教材名',width:100,align:'center'},   
  		 			         {field:'AUTHER',title:'作者',width:100,align:'center'},   
  		 			         {field:'PRESS',title:'出版社',width:100,align:'center'},   
  		 			         {field:'PRICE',title:'单价',width:100,align:'center'},   
  		 			         {field:'TIME',title:'出版时间',width:100,align:'center'},
  		 			         {field:'BOOKNUM',title:'库存',width:100,align:'center',hidden:'true'},
  		 			     ]]   
  		 		});
  		 		var id = '${id}';
  		 		$.ajax({
  		  			url:'bookOrderController.do?lookdata&id='+id,
  		  			dataType:'JSON',
  		  			success:function(msg){
  		  				var map = msg.attributes.list;
  		  				$('#dgs').datagrid({data:{"total":map.length,"rows":map}});
  		  				
  		  			}
  		  		});
  		 	});
  		 	
  		 	</script>
  </body>
</html>
