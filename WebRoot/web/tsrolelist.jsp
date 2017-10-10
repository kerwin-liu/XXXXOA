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
  		<div style="float: left;width:49.5%;height: 99%;border-radius:15px;border: 1px solid #6ab3c2;">
  			<table id = "dg">
  			</table>
  		
  		</div >
  		<div style="float: right;width:49.5%;height: 99%;border-radius:15px;border: 1px solid #6ab3c2;margin-right: 0px">
  			<table id = "dgs">
  			</table>
  		</div>
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
 				text:'添加角色',
 				handler: function(){
 					createwindow("添加角色", "tsRoleController.do?goadd&id=save",400,300);
 					}
 			},{
 				iconCls: 'icon-edit',
 				text:'编辑角色',
 				handler: function(){
 					update();
 				}
 			}],
  			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
  			         {field:'id',title:'id',width:100,align:'center',hidden:'true'},   
  			         {field:'rname',title:'角色名',width:60,align:'center'},   
  			         {field:'rnum',title:'角色编码',width:60,align:'center'},   
  			       {field :'obj',title : '操作',align:'center',width : 28,formatter: function(value,row,index){
  	            	   return "<a id='de' onclick=deletes('"+row.id+"')>删除</a>&nbsp;&nbsp;<a id='de' onclick=roles('"+row.id+"')>权限管理</a>";
  	               }}
  			     ]]   

  			
  		});
  		
  		
  		$('#dgs').treegrid({
		    idField:'id',
		    treeField:'text',
            singleSelect:false,
			fitColumns : true,
			fit : true,
			rownumbers:true,
			remoteSort: false,
			toolbar: [{
				iconCls: 'icon-add',
				text:'保存',
				handler: function(){
					savaRole();
					}
			}],
		    columns:[[
				{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},     
		       {field:'id',title:'ID',width:50,align:'center',hidden:'true'},
               {field:'text',title:'菜单名称',width:10,align:'center'}
		    ]]
		});
  		
  		roledata();
  	})
  
  	function deletes(id){
  		var url ="tsRoleController.do?deletes&id="+id;
			$.ajax({
				url:url,
				dataType:'json',
				success:function(datas){
					roledata();
				}
			});
  	}
  	
  	
  	function savaRole(){
  		var ids =$("#dg").datagrid("getSelections"),fids=$("#dgs").treegrid("getSelections");
  		var id=0,fid="";
  		if(ids.length!=1){
  			
  		}else{
  			id=ids[0].id;
  			for(var i=0;i<fids.length;i++){
  				fid +=fids[i].id+",";
  			}
  		}
  		
  		var url ="tsRoleController.do?saveRole&roleid="+id+"&fid="+fid;
  		$.ajax({
  			url:url,
  			dataType:'json',
  			success:function(data){
  				roles(id);
  			}
  		})
  	}
  	
  	
  	function update(){
  		var rows = $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "tsRoleController.do?goadd&id="+rows[0].id;
  			createwindow("更新角色", url,400,300);
  		}
  	}
  	
  	
  	function roledata(){
  		$.ajax({
  			url:'tsRoleController.do?tsRoleData',
  			dataType:'json',
  			success:function(data){
  				var map = data.attributes.list;
				$('#dg').datagrid({data:{"total":map.length,"rows":map}});
  			}
  		});
  	}
  	
  	function roles(id){
		$.ajax({
			url:'tsRoleController.do?functiondata&id='+id,
			dataType:'json',
			success:function(data){
				var map = data.attributes.list;
				$('#dgs').treegrid({data:{"total":map.length,"rows":map}});
				var role = data.attributes.role;
				$('#dgs').treegrid("unselectAll");
				for(var i=0;i<role.length;i++){
				$('#dgs').treegrid("select",role[i].tsFunction.id);
				}
			}
		})
	}
  	
  	
  	
  </script>
</html>
