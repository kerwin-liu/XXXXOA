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
  		 <form id="from" action="typeController.do?saveAndUpdate" method="post">
  		 <input name="id" value="${type.id }" style="display: none;">
  		 	<table >
  		 		<tr>
  		 			<td>类型名:</td>
  		 			<td><input id='cpn' type="text" name="type" value="${type.type }" >  
  		 			<span id="company" class="vi">*</span>
  		 			</td>
  		 		</tr>
  		 		<script type="text/javascript">
  		 		$(function(){
  		 			var names = $("#cpn").val();
		 				if(names.length>0){
		 					$("#company").css("color","black");
		 				}else{
		 					$("#company").css("color","red");
		 				}
  		 			$("#cpn").focusout(function(){
  		 				var name = $("#cpn").val();
  		 				if(name.length>0){
  		 					if(names!=name){
  	  		 					var url="typeController.do?check&type="+name;
  	  		 					$.ajax({
  	  		 						url:url,
  	  		 						dataType:'json',
  	  		 						success:function(data){
  	  		 							if(data.success){
  	  		 	  		 					$("#company").css("color","black");
  	  		 	  		 					$("#company").text("*");
  	  		 							}else{
  	  		 								$("#company").css("color","red");
  	  		 								$("#company").text("类型重复");
  	  		 							}
  	  		 						}
  	  		 					});
  	  		 					
  	  		 					}else{
  	  		 						$("#company").css("color","black");
  	  		 					}
  		 				}else{
  		 					$("#company").css("color","red");
  		 				}
  		 			});
  		 			$("input[type='text']").keyup( function() {
  		 				var name = $("#cpn").val();
  		 				if(name.length>0){
  		 					if(names!=name){
  		 					var url="typeController.do?check&type="+name;
  		 					$.ajax({
  		 						url:url,
  		 						dataType:'json',
  		 						success:function(data){
  		 							if(data.success){
  		 	  		 					$("#company").css("color","black");
  		 	  		 					$("#company").text("*");
  		 							}else{
  		 								$("#company").css("color","red");
  		 								$("#company").text("类型重复");
  		 							}
  		 						}
  		 					});
  		 					
  		 					}else{
  		 						$("#company").css("color","black");
  		 					}
  		 				}else{
  		 					$("#company").css("color","red");
  		 				}
  		 			});
  		 			$("input[type='text']").mouseup( function() {
  		 				var name = $("#cpn").val();
  		 				if(name.length>0){
  		 					if(names!=name){
  	  		 					var url="typeController.do?check&type="+name;
  	  		 					$.ajax({
  	  		 						url:url,
  	  		 						dataType:'json',
  	  		 						success:function(data){
  	  		 							if(data.success){
  	  		 	  		 					$("#company").css("color","black");
  	  		 	  		 					$("#company").text("*");
  	  		 							}else{
  	  		 								$("#company").css("color","red");
  	  		 								$("#company").text("类型重复");
  	  		 							}
  	  		 						}
  	  		 					});
  	  		 					
  	  		 					}else{
  	  		 						$("#company").css("color","black");
  	  		 					}
  		 					
  		 				}else{
  		 					$("#company").css("color","red");
  		 				}
  		 			});
  		 			
  		 			
  		 		});
  		 		
  		 		</script>
  		 		
  		 	</table>
               
          </form>
  </body>
</html>
