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
  		 <form id="from" action="projectController.do?addAndSave" method="post">
  		 <input name="id" value="${m.id }" style="display: none;">
  		 	<table width="100%">
  		 		<tr>
  		 			<td>对方姓名:</td>
  		 			<td><input id="cpn" name="names1" type="text" class=""  value="${m.name1}" >
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
  		 			<td>对方账号:</td>
  		 			<td><input name="names2" type="text" onkeyup="value=value.replace(/[^\d]/g,'') " class=""  value="${m.name2 }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>单价:</td>
  		 			<td><input name="price" type="text" onkeyup="value=value.replace(/[^\d.]/g,'') " class=""  value="${m.price }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>数量/吨:</td>
  		 			<td><input name="num" type="text" onkeyup="value=value.replace(/[^\d.]/g,'') " class=""  value="${m.num }" ></td>
  		 		</tr>
  		 	
  		 		<tr>
  		 			<td>收入/支出金额:</td>
  		 			<td> <input name="balance1" type="text" onkeyup="value=value.replace(/[^\d.-]/g,'') " class=""  value="${m.balance1 }" ></td>
  		 		</tr>
  		 		<tr>
  		 			<td>类型:</td>
  		 			<td> <input  id="cc" name="balance2" type="text"  class="" value="${m.balance2 }" ></td>
  		 			<script type="text/javascript">
		               $(function(){
		            	   var name = '${m.balance2}';
		            	   $.ajax({
		            		 url:'projectController.do?type',
		            		 dataType:'json',
		            		 success:function(msg){
		            			 var map = msg.attributes.list;
		            			 for(var i=0;i<map.length;i++){
		            				 if(map[i].ID==name){
		            					 map[i].selected=true;
		            				 }
		            			 }
		            			 $('#cc').combobox({
		            				 valueField:'ID',   
		            				 textField:'TEXT',
		            				 data:map
		            			})
		            		 }
		            	   })
		               })
               
               </script>
  		 		</tr>
  		 		<tr>
  		 		<td>备注:</td>
  		 		<td><textarea rows="2" cols="14" name="balance3"></textarea>   </td>
  		 		</tr>
  		 		<tr>
  		 			<td>交易时间:</td>
  		 			<td>
  		 			
  		 			<input id="date" name="time" type="text" value="ss"></input> 
  		 			
  		 			</td>
  		 <script type="text/javascript">
  		 
  		 		  $(function(){
  		 			var i=1;
  		 		 	var ss="";
  		 			$('#date').datetimebox({   
  		 			    required:false,
  		 				currentText:'今天',
  		 				closeText:'关闭',
  		 				okText:'确定',
  		 				formatter : function(date){
  		 					var y=date.getFullYear();
  		 					var m = date.getMonth()+1;
  		 					var d = date.getDate();
  		 				    var h =  date.getHours(),
  		 				   		mi = date.getMinutes(),
  		 				    	s = date.getSeconds();
  		 				 	m =m.toString().length==1?'0'+m:m;
		 				    d =d.toString().length==1?'0'+d:d;
		 				    h =h.toString().length==1?'0'+h:h;
		 				    mi =mi.toString().length==1?'0'+mi:mi;
		 				    s =s.toString().length==1?'0'+s:s;
  		 						ss=y+'-'+m+'-'+d+' '+h+':'+mi+':'+s;
  		 						return ss;
  	  		 			},
  	  		 		parser:function(s){
  	  		 			if (!s) return new Date(); 
		  	  		 	  var y = s.substring(0,4); 
		  	  		 	  var m =s.substring(5,7); 
		  	  		 	  var d = s.substring(8,10); 
		  	  		 	  var h = s.substring(11,13); 
		  	  		 	  var min = s.substring(14,16); 
		  	  		 	  var sec = s.substring(17,19);
		  	  		 	  if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(min) && !isNaN(sec)){ 
		  	  		 	   return new Date(y,m-1,d,h,min,sec); 
		  	  		 	  } else { 
		  	  		 	   return new Date(); 
		  	  		 	  } 
  	  		 		}
  		 			});
  		 			var time = '${m.time}';
  		 			if(time)
  		 				$('#date').datetimebox('setValue', time);
  		 			
  		 					
  		 			function getTimeStamp(datastr){
	  		 			  var st = datastr; 
		  		 		  var a = st.split(" "); 
		  		 		  var b = a[0].split("-"); 
		  		 		  var c = a[1].split(":"); 
		  		 		  var date = new Date(b[0], b[1], b[2], c[0], c[1], c[2]);
		  		 		  return date; 
  		 			}
  		 			
  		 			function date2str(x, y) {
  		 				var z = {
  		 				   y: x.getFullYear(),
  		 				   M: x.getMonth(),
  		 				   d: x.getDate(),
  		 				   h: x.getHours(),
  		 				   m: x.getMinutes(),
  		 				   s: x.getSeconds()
  		 				};
  		 				return y.replace(/(y+|M+|d+|h+|m+|s+)/g, function(v) {
  		 				   return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-(v.length > 2 ? v.length : 2))
  		 				});
  		 			};
  		 		  });
 				</script>
  		 		</tr>
  		 		
  		 	</table>
             
          </form>
  </body>

</html>
