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
  		 <form id="from" action="tsFunctionController.do?save" method="post">
  		 <input name="id" value="${ss.id }" style="display: none;">
  	  <table>
  		 	<tr>
  		 		<td>菜单名称:</td>
  		 		<td><input name="functionName" type="text" value="${ss.functionName }" class="kuang_txt" ></td>
  		 	</tr>
  		 	<tr>
  		 		<td>菜单地址:</td>
  		 		<td><input name="functionUrl" type="text" value="${ss.functionUrl }" class="kuang_txt" ></td>
  		 	</tr>
  		 	<tr>
  		 		<td>菜单顺序:</td>
  		 		<td><input name="functionOrder" type="text" value="${ss.functionOrder }" class="kuang_txt" ></td>
  		 	</tr>
  		 	<tr>
  		 		<td>菜单类型:</td>
  		 		<td>
  		 			<select name="type">
  		 				<option value="0">上级菜单</option>
  		 				<option value="1">下级菜单</option>
  		 			</select>
  		 		</td>
  		 	</tr>
  		 	<tr id="mm">
  		 		<td >上级菜单:</td>
  		 		<td><input id="cc" name="menu" >  
  		 		</td>
  		 	</tr>
  		 	 <script type="text/javascript">
					  $(function(){
						  $("#mm").hide();
						  $("select").change(function(){
							  var value=$("select").val();
							  if(value==0){
								  $("#mm").hide();
							  }
							  if(value==1){
								  $("#mm").show();
								  menudata();
							  }
						  });
						  
					  });
					  
				function menudata(){
					$.ajax({
						url:'tsFunctionController.do?menudata',
						dataType:'',
						success:function(datas){
							var map=datas.attributes.list;
							 $('#cc').combotree({data:map}); 
						//	console.log(map);
						}
					});
					
				}
 			 </script>
  		 	</table> 
  		 	
          </form>
    
  </body>
  
 
</html>
