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
  		 <form id="from" action="tsUserController.do?save" method="post">
  		 <input name="id" value="${user.id }" style="display: none;">
  		 	<table >
  		 		<tr>
  		 			<td>用户名:</td>
  		 			<td><input id="cpn" name="username" type="text" class="kuang_txt"  value="${user.username}" >
  		 			<span id="company" class="vi">*</span>
  		 			</td>
  		 		</tr>
  		 		<script type="text/javascript">
  		 		$(function(){
  		 			$("#cpn").focusout(function(){
  		 				var name = $("#cpn").val();
  		 				if(name.length>0){
  		 					$("#company").css("color","black");
  		 				}else{
  		 				$("#company").css("color","red");
  		 				}
  		 			})
  		 			
  		 		})
  		 		
  		 		</script>
  		 		<tr>
  		 			<td>密码:</td>
  		 			<td><input name="password" type="password" class="kuang_txt"  value="${user.password }"  <c:if test="${user != null}">readonly='readonly'</c:if> ></td>
  		 		</tr>
  		 	
  		 		<tr>
  		 			<td>姓名:</td>
  		 			<td> <input name="telno" type="text" class="kuang_txt"  value="${user.telno }" ></td>
  		 		</tr>
  		 		<tr style="display: none;">
  		 			<td>微信/QQ号:</td>
  		 			<td> <input name="wqnum" type="text" class="kuang_txt"  value="${user.wqnum }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>备注:</td>
  		 			<td> <input name="desc" type="text" class="kuang_txt"  value="${user.desc }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>角色:</td>
  		 			<td> 
  		 			<select id="rids" name="rid">
  		 				<c:forEach items="${list }" var="role">
  		 					<option value="${role.id }"  <c:if test="${user.tsRole.id eq role.id  }">selected='selected'</c:if> >${role.rname }</option>
  		 				</c:forEach>
  		 			</select>
  		 		</tr>
  		 		
  		 	</table>
               
          </form>
  </body>
</html>
