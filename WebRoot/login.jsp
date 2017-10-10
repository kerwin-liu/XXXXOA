<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="plug_in/main/jsp/util.jsp"></c:import>
<!doctype html>
<html >
<head>
	<meta charset="UTF-8">
	<title></title>
    <link type="text/css" rel="stylesheet" href="plug_in/css/login.css">
    <script type="text/javascript" src="plug_in/js/jquery-2.1.0.js"></script>
</head>
<body class="login_bj" >
<div class="zhuce_body">
	<div class="logo"><!-- <img src="plug_in/images/logo.png" width="430" height="297" border="0"> --></div>
    <div class="zhuce_kong login_kuang">
    	<div class="zc">
        	<div class="bj_bai">
            <h3>登录</h3>
       	  	  <form id = "formaction" action="loginController.do?login"  checks="loginController.do?check" method="post" target="hidden_frame">
                <input id = "uname" name="UserName" type="text" class="kuang_txt" >
                <input id = "pwd" name="PassWord" type="password" class="kuang_txt" >
                <input name="登录" id = "submit"  type="button" class="btn_zhuce" value="登录">
                </form>
            </div>
        </div>
    </div>

</div>
    <!--  <iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe> -->
          <script type="text/javascript">
	     	$(function(){
	     		 var checks = $("#formaction").attr("checks"),
	     		 	 action = $("#formaction").attr("action");
	     		 $("#submit").click(function(){
	     			 var uname = $("#uname").val(),pwd = $("#pwd").val();
	     			 if(uname==""){
	     				alert('用户名不能为空');
	     			 }else{
	     				 if(pwd==""){
	     					alert('密码不能为空');
	     				 }else{
	     					 $.ajax({
	     						 url:checks+"&uname="+uname+"&pwd="+pwd,
	     						 dataType:'json',
	     						 success:function(data){
	     							 if(data.success){
	     								 //$("#formaction").submit();
	     								window.location.href=action;
	     							 }else{
	     								 alert("用户名或密码不正确");
	     							 }
	     						 }
	     					 });
	     				 }
	     			 }
	     			 
	     			 
	     		 })
	     		 
	     		
	     	});
          </script>
</body>
</html>