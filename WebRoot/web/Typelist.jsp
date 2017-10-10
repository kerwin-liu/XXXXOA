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
 				text:'添加',
 				handler: function(){
 					createwindow("添加", "typeController.do?goadd&id=",400,300);
 					}
 			},{
 				iconCls: 'icon-edit',
 				text:'编辑',
 				handler: function(){
 					update();
 				}
 			}],
  			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
  			         {field:'ID',title:'id',width:100,align:'center',hidden:'true'},   
  			         {field:'TYPE',title:'类型名',width:60,align:'center'},   
  			       {field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
  	            	   return "<a id='de' onclick=deletes('"+row.ID+"')>删除</a>";
  	               }}
  			     ]]
  		});
  		saledata();
  	})
  
  	function deletes(id){
  		var url ="typeController.do?deletes&id="+id;
			$.ajax({
				url:url,
				dataType:'json',
				success:function(datas){
					saledata();
				}
			});
  	}
  	
  	
  	
  	
  	function update(){
  		var rows = $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "typeController.do?goadd&id="+rows[0].ID;
  			createwindow("更新", url,400,300);
  		}
  	}
  	
  	
  	function saledata(){
  		$.ajax({
  			url:'typeController.do?tbdata',
  			dataType:'json',
  			success:function(data){
  				var map = data.attributes.list;
				$('#dg').datagrid({data:{"total":map.length,"rows":map}});
  			}
  		});
  	}
  	
  	
  	
  </script>
</html>
