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
  		 <form id="from" action="bookOrderController.do?saveAndUpdate" method="post">
  		 <input name="id" value="${order.id }" style="display: none;">
  		 <input name="tid" value="${tid }" style="display: none;">
  		 	<table >
  		 	<tr>
  		 		<td>教材名:</td>
  		 			<td><input id="cc" name="bookid" >  </td>
  		 			<script type="text/javascript">
		               $(function(){
		            	   var id = '${border.book.id}';
		            	   $.ajax({
		            		 url:'bookSaleController.do?books',
		            		 dataType:'json',
		            		 success:function(msg){
		            			 var map = msg.attributes.list;
		            			 for(var i=0;i<map.length;i++){
		            				 if(map[i].ID==id){
		            					 map[i].selected=true;
		            				 }
		            			 }
		            			 $('#cc').combobox({
		            				 valueField:'ID',   
		            				 textField:'TEXT',
		            				 data:map
		            			});
		            			 $('#cc').combobox("select",id);
		            		 }
		            	   });
		               });
		               
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
  		 			var num='${order.num}';
  		 			$('#ss').numberspinner('setValue', num*1);  
  		 		  });
   				</script>
  		 		</tr>
  		 		<tr>
  		 			<td>订单时间:</td>
  		 			<td><input id="date" name="time" type="text"></input> </td>
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
	  		 		onSelect: function(date){
	  		 		var y=date.getFullYear();
	 					var m = date.getMonth()+1;
	 					var d = date.getDate();
	 				    var h =  date.getHours().length==1?date.getHours():date.getHours(),mi = date.getMinutes(),s = date.getSeconds();
	 						ss=m+'/'+d+'/'+y+' '+h+':'+mi+':'+s;
	 						$('#date').datetimebox('setValue', ss);
	  		 		}
		 
		 			});
  		 			var time = '${order.time}';
		 			if(time)
		 			$('#date').datetimebox('setValue', date2str(getTimeStamp(time),'M/d/yyyy hh:mm:ss'));
  		 			 
  		 			function getTimeStamp(datastr){
  		 				var date = new Date(Date.parse(datastr));
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
  		 		  })
 				</script>
  		 		</tr>
  		 		
  		 	</table>
               
          </form>
  </body>
</html>
