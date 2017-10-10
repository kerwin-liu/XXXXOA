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
  		 <form id="from" action="loginController.do?updatePassword" method="post" target="hidden_frame">
  		 	<table >
  		 		<tr>
  		 			<td>用户名:</td>
  		 			<td><input name="username" type="text" class="kuang_txt" readonly="readonly" value="${username }"></td>
  		 		</tr>
  		 		<tr>
  		 			<td>原始密码:</td>
  		 			<td><input name="password" type="password" class="kuang_txt" value=""></td>
  		 		</tr>
  		 	
  		 		<tr>
  		 			<td>新密码:</td>
  		 			<td><input name="newpwd" type="password" class="kuang_txt" value=""></td>
  		 		</tr>
  		 	</table>
          </form>
          <iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
          <script type="text/javascript">
	          $('#hidden_frame').load(function(){
	        	    var text=$(this).contents().find("body").text();
	        	       // 根据后台返回值处理结果
	        	    var j=$.parseJSON(text);
	        	       alert(j.msg);
	        	});
          </script>
  </body>
</html>
