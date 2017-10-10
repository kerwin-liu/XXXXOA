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
<style type="text/css">
	.de:HOVER{
		cursor: pointer;
	}

</style>
  </head>
  
  <body class="">
  	<div class="content">
  		<div style="float: left;width:99%;height: 99%;border-radius:15px;border: 1px solid #6ab3c2;">
  			<table id = "dg">
  			</table>
  		
  		</div >
  	</div>
    
  </body>
  <script type="text/javascript">
  	$(function(){
  		$("#dg").datagrid({
  			 singleSelect:true,
 			fitColumns : true,
 			fit : true,
 			rownumbers:true,
 			remoteSort: false,
 			toolbar: [{
 				iconCls: 'icon-add',
 				text:'添加订单',
 				handler: function(){
 					createwindow("添加信息", "bookOrderController.do?goadd&id=save",400,300);
 					}
 			},{
 				iconCls: 'icon-edit',
 				text:'编辑订单',
 				handler: function(){
 					update();
 				}
 			}
 			],
  			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
					{field:'TID',title:'TID',width:60,align:'center',hidden:true}, 
					{field:'ID',title:'ID',width:60,align:'center',hidden:true}, 
  			        {field:'BOOK',title:'教材名称',width:60,align:'center'},   
  			        {field:'NUM',title:'订单数量',width:60,align:'center'},   
  			        {field:'TIME',title:'订单时间',width:60,align:'center'},   
  			       	{field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
  	            		return "<a id='de' onclick=deletes('"+row.ID+"')>删除</a>";
  	               }}
  			     ]]   

  			
  		});
  		
  		
  		orderdata();
  	})
  
  	function order(){
  		var ids =$("#dg").datagrid("getSelections");
  		if(ids.length!=1){
  			$.messager.alert('提示','请选择订单');   
  		}else{
  			var id = ids[0].ID,tid = ids[0].TID;
  			var url="bookOrderController.do?Border&id="+id+"&tid="+tid;
  			createwindow("订单信息", url, 400,300);
  		}
  	}
  	
  	
  	function deletes(id){
  		
  		var url ="bookOrderController.do?deletes&id="+id;
			$.ajax({
				url:url,
				dataType:'json',
				success:function(datas){
					orderdata();
				}
			});
  		}
  	
  	
  	
  	
  	function update(){
  		var rows = $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "bookOrderController.do?goadd&id="+rows[0].ID+"&tid="+rows[0].TID;
  			createwindow("更新", url,400,300);
  		}
  	}
  	
  	
  	function orderdata(){
  		$.ajax({
  			url:'bookOrderController.do?BOData',
  			dataType:'json',
  			success:function(data){
  				var map = data.attributes.list;
				$('#dg').datagrid({data:{"total":map.length,"rows":map}});
  			}
  		});
  	}
  	function looks(id){
  		createnewwindow("订购详情","bookOrderController.do?looks&id="+id,600,400);
  	}
  	
  	
  </script>
</html>
