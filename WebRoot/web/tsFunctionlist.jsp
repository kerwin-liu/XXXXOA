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
#de:HOVER{
cursor: pointer;
}
</style>
  </head>
  
  <body class="" style="overflow: hidden;">
  	<div class="content">
  		<table id = "dg">
  			
  		</table>
  	
  	</div>
  </body>
  <script type="text/javascript">
  	$(function(){
  		$('#dg').treegrid({
		    idField:'id',
		    treeField:'text',
            singleSelect:false,
			fitColumns : true,
			fit : true,
			rownumbers:true,
			remoteSort: false,
			toolbar: [{
				iconCls: 'icon-add',
				text:'菜单录入',
				handler: function(){
					createwindow("添加菜单", "tsFunctionController.do?goadd&id=save",400,300);
					}
			},{
				iconCls: 'icon-edit',
				text:'菜单编辑',
				handler: function(){
					update();
				}
			}],
		    columns:[[
				{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},     
		       {field:'id',title:'ID',width:50,align:'center',hidden:'true'},
               {field:'text',title:'菜单名称',width:10,align:'center'},  
		       {field:'url',title:'菜单地址',width:10,align:'center'}, 
               {field :'order',title : '菜单排序',align:'center',width : 10},
               {field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
            	   return "<a id='de' onclick=deletes('"+row.id+"')>删除</a>";
               }}
		    ]]
		});
  		
  		
  		data();
  		
  	})
  

  	
  	
  	
  function deletes(id){
  			var url ="tsFunctionController.do?deletes&id="+id;
  			$.ajax({
  				url:url,
  				dataType:'json',
  				success:function(datas){
  					data();
  				}
  			});
  	}
 function update(){
	 var data = $("#dg").treegrid("getSelections");
	 if(data.length!=1){
		 $.messager.alert('提示','请选择一条进行编辑');  
	 }else {
		 createwindow("更新菜单", "tsFunctionController.do?goadd&id="+data[0].id,400,300);
	 }
 }
 
 function data(){
		$.ajax({
			url:'tsFunctionController.do?functionData',
			dataType:'json',
			success:function(data){
				var map = data.attributes.list;
				$('#dg').treegrid({data:{"total":map.length,"rows":map}});
				$('#dg').treegrid("collapseAll");
			}
		})
	} 	
  </script>
</html>
