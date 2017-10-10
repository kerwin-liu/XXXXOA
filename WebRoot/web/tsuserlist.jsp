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
  		<table id = "dg">
  		
  		</table>
  	
  	</div>
    
  </body>
  <script type="text/javascript">
  	$(function(){
  		$("#dg").datagrid({
  			 singleSelect:false,
 			fitColumns : true,
 			fit : true,
 			rownumbers:true,
 			remoteSort: false,
 			toolbar: [{
 				iconCls: 'icon-add',
 				text:'添加用户',
 				handler: function(){
 					createwindow("添加用户", "tsUserController.do?goadd&id=save",400,300);
 					}
 			},{
 				iconCls: 'icon-edit',
 				text:'编辑用户',
 				handler: function(){
 					update();
 				}
 			}],
  			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
  			         {field:'id',title:'用户名',width:100,align:'center',hidden:'true'},   
  			         {field:'username',title:'用户名',width:100,align:'center'},   
  			         {field:'telno',title:'姓名',width:100,align:'center'},   
  			         {field:'wqnum',title:'微信/QQ号',width:100,align:'center',hidden:'true'},   
  			         {field:'desc',title:'备注',width:100,align:'center'},
  			         {field:'rid',title:'角色id',width:100,align:'center',hidden:'true'},
  			         {field:'rname',title:'角色',width:100,align:'center'},
  			       {field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
  	            	   return "<a id='de' onclick=deletes('"+row.id+"')>删除</a>";
  	               }}
  			     ]]   

  			
  		});
  		
  		userdata();
  	})
  
  	function deletes(id){
  		var url ="tsUserController.do?deletes&id="+id;
			$.ajax({
				url:url,
				dataType:'json',
				success:function(datas){
					userdata();
				}
			});
  	}
  	
  	
  
  	
  	function update(){
  		var rows =  $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "tsUserController.do?goadd&id="+rows[0].id;
  			createwindow("更新用户", url,400,300);
  		}
  		
  	}
  	
	
  	function userdata(){
  		$.ajax({
  			url:'tsUserController.do?userdata',
  			dataType:'json',
  			success:function(data){
  				var map = data.attributes.list;
  				for(var i = 0;i<map.length;i++){
  					map[i]["rid"]=map[i].tsRole.id;
  					map[i]["rname"]=map[i].tsRole.rname;
  				}
  				
				$('#dg').datagrid({data:{"total":map.length,"rows":map}});
  			}
  		});
  	}
  </script>
</html>
