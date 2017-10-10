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
  		 <form id="from" action="tsRoleController.do?save" method="post">
  		 <input name="id" value="${role.id }" style="display: none;">
  		 	<table >
  		 		<tr>
  		 			<td>角色名:</td>
  		 			<td><input name="rname" type="text" class="kuang_txt" value="${role.rname }"></td>
  		 		</tr>
  		 		<tr>
  		 			<td>角色编码:</td>
  		 			<td><input name="rnum" type="text" class="kuang_txt" value="${role.rnum }" ></td>
  		 		</tr>
  		 	
  		 	</table>
               
          </form>
  </body>
</html>
