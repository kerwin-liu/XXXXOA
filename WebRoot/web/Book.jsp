<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../plug_in/main/jsp/util.jsp"></c:import>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8" />
<title></title>

  </head>
  
  <body style="overflow: hidden;">
   <div class="content">
    	<table id= "dg">
    	
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
				text:'添加教材',
				handler: function(){
					createwindow("添加教材", "bookController.do?goadd&id=save",400,300);
					}
			},{
				iconCls: 'icon-edit',
				text:'编辑教材',
				handler: function(){
					update();
				}
			}],
 			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
 			         {field:'ID',title:'id',width:100,align:'center',hidden:'true'},   
 			         {field:'BOOKNAME',title:'教材名',width:100,align:'center'},   
 			         {field:'AUTHER',title:'作者',width:100,align:'center'},   
 			         {field:'PRESS',title:'出版社',width:100,align:'center'},   
 			         {field:'PRICE',title:'单价',width:100,align:'center'},   
 			         {field:'TIME',title:'出版时间',width:100,align:'center'},
 			         {field:'BOOKNUM',title:'库存',width:100,align:'center'},
 			       {field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
 	            	   return "<a id='de' onclick=deletes('"+row.ID+"')>删除</a>";
 	               }}
 			     ]]   

 			
 		});
  		
  		bookdata();
  	});
  
  	function update(){
  		var rows =  $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "bookController.do?goadd&id="+rows[0].ID;
  			createwindow("更新", url,400,300);
  		}
  		
  		
  	}
  	
  	
  	function deletes(id){
  		console.log(id);
  		$.ajax({
  			url:'bookController.do?deletes&id='+id,
  			dataType:'JSON',
  			success:function(msg){
  				bookdata();
  			}
  		});
  	}
  	
  	
  	function bookdata(){
  		$.ajax({
  			url:'bookController.do?bookdata',
  			dataType:'JSON',
  			success:function(msg){
  				var map = msg.attributes.list;
  				$('#dg').datagrid({data:{"total":map.length,"rows":map}});
  			}
  		});
  		
  	}
  </script>
  
</html>
