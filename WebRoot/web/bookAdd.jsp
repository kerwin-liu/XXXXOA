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
  		 <form id="from" action="bookController.do?save" method="post">
  		 <input name="id" value="${book.id }" style="display: none;">
  		 	<table >
  		 		<tr>
  		 			<td>教材名:</td>
  		 			<td><input id="cpn" name="bookName" type="text" class=""  value="${book.bookName}" >
  		 			<span id="company" class="vi">*</span>
  		 			</td>
  		 		</tr>
  		 		<script type="text/javascript">
  		 		$(function(){
  		 			var name = $("#cpn").val();
		 				if(name.length>0){
		 					$("#company").css("color","black");
		 				}else{
		 					$("#company").css("color","red");
		 				}
  		 			$("#cpn").focusout(function(){
  		 				var name = $("#cpn").val();
  		 				if(name.length>0){
  		 					$("#company").css("color","black");
  		 				}else{
  		 				$("#company").css("color","red");
  		 				}
  		 			});
  		 			
  		 		})
  		 		
  		 		</script>
  		 		<tr>
  		 			<td>作者:</td>
  		 			<td><input name="auther" type="text" class=""  value="${book.auther }" ></td>
  		 		</tr>
  		 	
  		 		<tr>
  		 			<td>出版社:</td>
  		 			<td> <input name="press" type="text" class=""  value="${book.press }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>单价:</td>
  		 			<td> <input name="price" type="text" onkeyup="value=value.replace(/[^\d.]/g,'') " class=""  value="${book.price }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>出版时间:</td>
  		 			<td><input id="date" name="time" type="text"></input> </td>
  		 <script type="text/javascript">
  		 		  $(function(){
  		 		 	var i=false;
  		 		 	var ss="";
  		 		


  		 		 var time = '${book.time}';
  		 			$('#date').datebox({   
  		 			    required:false,
  		 				currentText:'今天',
  		 				closeText:'关闭',
  		 				formatter:function(date){
  		   		 			var y = date.getFullYear();
  		   		 			var m = date.getMonth()+1;
  		   		 			var d = date.getDate();
  		   		 			return y+'-'+m+'-'+d;
  		   		 		},
  	  		 			onSelect: function(date){
  	  						ss=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
  	  					$('#date').datebox('setValue', date2str(getTimeStamp(ss),'M/d/yyyy'));
  	  					}
  		 			});
  		 			$('#date').datebox('setValue', date2str(getTimeStamp(time),'M/d/yyyy'));
  		 			 
  		 			function getTimeStamp(datastr){
  		 				console.log(2);
  		 				var date = new Date(Date.parse(datastr));
  		 				return date;
  		 			}
  		 			
  		 			function date2str(x, y) {
  		 				var z = {
  		 				   y: x.getFullYear(),
  		 				   M: x.getMonth() + 1,
  		 				   d: x.getDate(),
  		 				   h: x.getHours(),
  		 				   m: x.getMinutes(),
  		 				   s: x.getSeconds()
  		 				};
  		 				return y.replace(/(y+|M+|d+|h+|m+|s+)/g, function(v) {
  		 				   return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-(v.length > 2 ? v.length : 2))
  		 				});
  		 			};
  		 		  })
 				</script>
  		 		</tr>
  		 		<tr>
  		 			<td>数量:</td>
  		 			<td><input id="ss" name="bookStocks"> </td>
  		 			 <script type="text/javascript">
  		 		  $(function(){
  		 			$('#ss').numberspinner({   
  		 			    min: 1,
  		 			    editable: true,
  		 			 	onChange:function(a,b){
  		 			 	}
  		 			});
  		 			var num='${book.bookStocks}';
  		 			$('#ss').numberspinner('setValue', num*1);  
  		 		  });
   				</script>
  		 		</tr>
  		 		
  		 	</table>
             
          </form>
  </body>

</html>
