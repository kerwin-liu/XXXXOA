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
  		 <form id="from" action="bookSaleController.do?save" method="post">
  		 <input name="id" value="${sale.id }" style="display: none;">
  		 	<table >
  		 		<tr>
  		 			<td>教材名:</td>
  		 			<td><input id="cc" name="bookid" >  </td>
  		 			<script type="text/javascript">
               $(function(){
            	   var id = '${sale.book.id}';
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
            			})
            		 }
            	   })
               })
               
               </script>
  		 		</tr>
  		 		<tr>
  		 			<td>出售数量:<input name="num2" value="${sale.num }" style="display:none; "/></td>
  		 			<td><input id="ss" name="num"  style="width:80px;"><span id="bn"></span></td>
  		 				
  		 		</tr>
  		 		<script type="text/javascript">
  		 		$(function(){
  		 			var bn ='${sale.num}';
  		 			$('#cc').combobox({
  		 					onSelect:function(record){
  		 						var url="bookSaleController.do?booknum&id="+record.ID;
  		 						$.ajax({
  		 							url:url,
  		 							dataType:'json',
  		 							success:function(data){
  		 								var num = data.msg;
  		 								var nn=num;
  		 								$("#bn").text("可预售数量:"+num+"本");
  		 								$('#ss').numberspinner({   
  		  		 		  		 		    min: 0,   
  		  		 		  		 		    max: num*1, 
  		  		 		  		 		    editable: true,
  		  		 		  		 			onSpinUp:function(){
  		  		 		  		 				var v = $('#ss').numberspinner('getValue');
  		  		 		  		 				nn = num*1-v*1;
  		  		 		  		 				if(nn>=0){
  		  		 		  		 					$("#bn").text("可预售数量:"+nn+"本");
  		  		 		  		 				}else{
  		  		 		  		 					nn=0;
  		  		 		  		 				}
  		  		 		  		 			},
  		  		 		  		 			onSpinDown:function(){
  		  		 		  		 				var v = $('#ss').numberspinner('getValue');
	  		 		  		 					nn = num*1-v*1;
  		  		 		  		 				if(nn<=num){
  		  		 		  		 					$("#bn").text("可预售数量:"+nn+"本");
  		  		 		  		 				}else{
  		  		 		  		 					nn=num;
  		  		 		  		 				}
  		  		 		  		 			},
  		  		 		  		 			onChange:function(a,b){
  		    		 			 				nn=num*1-a*1;
  		    		 			 				$("#bn").text("可预售数量:"+nn+"本");
  		    		 			 			
  		  		 		  		 			}
  		  		 		  		 		});
  		 								
  		 								$('#ss').numberspinner('setValue', bn*1); 
  		 							}
  		 						});
  		 					}
  		 			});
  		 		});
  		 		
  		 		</script>
  		 		<tr>
  		 			<td>出售时间:</td>
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
  		 			var time = '${sale.time}';
  		 			if(time)
  		 			$('#date').datetimebox('setValue', date2str(getTimeStamp(time),'M/d/yyyy hh:mm:ss'));
  		 			 
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
  		 		  })
 				</script>
  		 		</tr>
  		 	</table>
               
          </form>
  </body>
</html>
