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
  		 <form id="from" action="bookOrderController.do?saveorder" method="post">
  		 <input name="id" value="${id }" style="display: none;">
  		 <input id="bid" name="bid" value="" style="display: none;"/>
  		 </form>
  		 <table id="dgs" style="width: 100%;height: 400px">
  		 	</table>
  		 	<script type="text/javascript">
  		 	$(function(){
  		 		var ss= '${list}';
  		 		var d = jQuery.parseJSON('${list}');
  		 		console.log(d);
  		 	/* 	for(i in ss){
  		 			console.log(ss[i]);
  		 		} */
  		 		$("#dgs").datagrid({
  		 			singleSelect:false,
  					fitColumns : true,
  					fit : true,
  					rownumbers:true,
  					onSelect:function(rowIndex, rowData){
  						var bid = $("#bid").val();
  						bid +=rowData.ID+",";
  						$("#bid").val(bid);
  					},
  					onUnselect:function(rowIndex, rowData){
  						var id=rowData.ID;
  						var bid =  $("#bid").val();
  						bid = bid.replace(id, '');
  						$("#bid").val(bid);
  					},
  					onSelectAll:function(rows){
  						var bid="";
  						for(var i=0;i<rows.length;i++){
  							bid+=rows[i].ID+",";
  						}
  						$("#bid").val(bid);
  					},
  					onUnselectAll:function(rows){
  						$("#bid").val("");
  					},
  		 			columns:[[
  							 {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
  		 			         {field:'ID',title:'id',width:100,align:'center',hidden:'true'},   
  		 			         {field:'BOOKNAME',title:'教材名',width:100,align:'center'},   
  		 			         {field:'AUTHER',title:'作者',width:100,align:'center'},   
  		 			         {field:'PRESS',title:'出版社',width:100,align:'center'},   
  		 			         {field:'PRICE',title:'单价',width:100,align:'center'},   
  		 			         {field:'TIME',title:'出版时间',width:100,align:'center'},
  		 			        /*  {field:'BOOKNUM',title:'库存',width:100,align:'center'}, */
  		 			     ]]   
  		 		});
  		 		$.ajax({
  		  			url:'bookController.do?bookdata',
  		  			dataType:'JSON',
  		  			success:function(msg){
  		  				var map = msg.attributes.list;
  		  				$('#dgs').datagrid({data:{"total":map.length,"rows":map}});
  		  				var rows = $('#dgs').datagrid("getRows");
  		  				for(var k=0;k<rows.length;k++){
	  		  				for(var i=0;i<d.length;i++){
	  		  					if(rows[k].ID==d[i].B_ID){
	  		  					$('#dgs').datagrid("selectRow",k);
	  		  					}
	  		  				}
  		  				}
  		  				
  		  			}
  		  		});
  		 	});
  		 	
  		 	</script>
  </body>
</html>
