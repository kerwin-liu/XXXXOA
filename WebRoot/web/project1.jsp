<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../plug_in/main/jsp/util.jsp"></c:import>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8" />
<title></title>
<style type="text/css">
	input {
	margin-top: 0.3%;
	margin-left: 0.5%
}

</style>
<script type="text/javascript">
var error='${error}';
if(error){
	alert("已存在!! 请检查信息!!");
}else{
}

</script>
  </head>
  
  <body style="overflow: hidden;">
   <div class="content" style="border: 0px">
   		<div id="select" class="content" style="width: 100%;height: 7%">
   			<table border="0" width="100%">
   				<tr>
   					<td>对方姓名:</td>
   					<td><input id="cc1" name="dept" value="" style="width: 100px"> </td>
   					<td>对方账号:</td>
   					<td><input id="cc2" name="dept" value=""> </td>
   					<td>类型:</td>
   					<td><input  id="cc3" name="balance2" type="text"style="width: 100px" ></td>
   					<td>开始时间:</td>
   					<td colspan="3">
   					<input id="date1" name="time" type="text" value="2017-05-10 11:11:11"></input>~~ 
   					结束时间:<input id="date2" name="time" type="text" value="请选择----"></input>
   					<td colspan="2">
   					<button onclick="find();">查询</button>
   					<button onclick="re();">重置</button>
   					</td>
   				</tr>
   			</table>
   			 
   		</div>
   		<div id="tb" class="content"  style="width: 100%;height: 90%;">
    	<table id= "dg">
    	
    	</table>
   		</div>	
    </div>
  </body>
  <script type="text/javascript">
  	$(function(){
  		$("#dg").datagrid({
 			 singleSelect:false,
			fitColumns : true,
			fit : true,
			rownumbers:true,
			remoteSort: false,
			showFooter: true,
			pagination:true,
			toolbar: [
			{
				iconCls: 'icon-edit',
				text:'导出',
				handler: function(){
					exports();
				}
			}
			],
 			 columns:[[
					{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'}, 
 			         {field:'ID',title:'id',width:100,align:'center',hidden:'true'},   
 			         {field:'NAME1',title:'对方姓名',width:100,align:'center'},   
 			         {field:'NAME2',title:'对方账号',width:100,align:'center'},   
 			         {field:'BAlANCE1',title:'收入/支出金额',width:100,align:'center'},   
 			         {field:'BAlANCE2',title:'类型',width:100,align:'center'},   
 			         {field:'BAlANCE3',title:'备注',width:100,align:'center'},
 			         {field:'TIME',title:'交易时间',width:100,align:'center'}
 			     ]]

 			
 		});
  		
  		name1();
  		name2();
  		time();
  		bookdata();

		function pagerFilter(data){
			if ($.isArray(data)){	// is array
				data = {
					total: data.length,
					rows: data
				}
			}
			var target = this;
			var dg = $(target);
			var state = dg.data('datagrid');
			var opts = dg.datagrid('options');
			if (!state.allRows){
				state.allRows = (data.rows);
			}
			if (!opts.remoteSort && opts.sortName){
				var names = opts.sortName.split(',');
				var orders = opts.sortOrder.split(',');
				state.allRows.sort(function(r1,r2){
					var r = 0;
					for(var i=0; i<names.length; i++){
						var sn = names[i];
						var so = orders[i];
						var col = $(target).datagrid('getColumnOption', sn);
						var sortFunc = col.sorter || function(a,b){
							return a==b ? 0 : (a>b?1:-1);
						};
						r = sortFunc(r1[sn], r2[sn]) * (so=='asc'?1:-1);
						if (r != 0){
							return r;
						}
					}
					return r;
				});
			}
			var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
			var end = start + parseInt(opts.pageSize);
			data.rows = state.allRows.slice(start, end);
			return data;
		}

		var loadDataMethod = $.fn.datagrid.methods.loadData;
		var deleteRowMethod = $.fn.datagrid.methods.deleteRow;
		$.extend($.fn.datagrid.methods, {
			clientPaging: function(jq){
				return jq.each(function(){
					var dg = $(this);
                    var state = dg.data('datagrid');
                    var opts = state.options;
                    opts.loadFilter = pagerFilter;
                    var onBeforeLoad = opts.onBeforeLoad;
                    opts.onBeforeLoad = function(param){
                        state.allRows = null;
                        return onBeforeLoad.call(this, param);
                    }
                    var pager = dg.datagrid('getPager');
					pager.pagination({
						showRefresh:false,
						beforePageText:'请输入第',
						afterPageText:'页	共{pages}页',
						displayMsg:'{from}~{to} 共 {total}条记录',
						onSelectPage:function(pageNum, pageSize){
							opts.pageNumber = pageNum;
							opts.pageSize = pageSize;
							pager.pagination('refresh',{
								pageNumber:pageNum,
								pageSize:pageSize
							});
							dg.datagrid('loadData',state.allRows);
						},
						onRefresh:function(pageNum, pageSize){
							/* pager.pagination('refresh',{
								pageNumber:1,
								pageSize:pageSize
							}); */
							//bookdata();
						}
					});
                    $(this).datagrid('loadData', state.data);
                    if (opts.url){
                    	$(this).datagrid('reload');
                    }
				});
			},
            loadData: function(jq, data){
                jq.each(function(){
                    $(this).data('datagrid').allRows = null;
                });
                return loadDataMethod.call($.fn.datagrid.methods, jq, data);
            },
            deleteRow: function(jq, index){
            	return jq.each(function(){
            		var row = $(this).datagrid('getRows')[index];
            		deleteRowMethod.call($.fn.datagrid.methods, $(this), index);
            		var state = $(this).data('datagrid');
            		if (state.options.loadFilter == pagerFilter){
            			for(var i=0; i<state.allRows.length; i++){
            				if (state.allRows[i] == row){
            					state.allRows.splice(i,1);
            					break;
            				}
            			}
            			$(this).datagrid('loadData', state.allRows);
            		}
            	});
            },
            getAllRows: function(jq){
            	return jq.data('datagrid').allRows;
            }
		});
	
  		
  	});
  
  	function name1(){
  		var url="projectController.do?name1";
  		$.ajax({
  			url:url,
  			dataType:'json',
  			success:function(data){
  				var d = data.attributes.list;
  				$('#cc1').combobox({   
  				    valueField:'id',   
  				    textField:'text',
  				    data:d
  				});
  			}
  		});
  		 $.ajax({
    		 url:'projectController.do?type1',
    		 dataType:'json',
    		 success:function(msg){
    			 var map = msg.attributes.list;
    			 $('#cc3').combobox({
    				 valueField:'ID',   
    				 textField:'TEXT',
    				 data:map
    			})
    		 }
    	   })
  		
  		
  	}
  	function name2(){
  		var url="projectController.do?name2";
  		$.ajax({
  			url:url,
  			dataType:'json',
  			success:function(data){
  				var d = data.attributes.list;
  				$('#cc2').combobox({   
  				    valueField:'id',   
  				    textField:'text',
  				    data:d
  				});
  			}
  		})
  	}
  	
  	function time(){
  		
  		$('#date1').datetimebox({   
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
  		$('#date2').datetimebox({   
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
  	}
  	
  	function find(){
  		bookdata();
  	}
  	
  	function re(){
  		name1();
  		name2();
  		time();
  		bookdata();
  	}
  	
  	
  	function update(){
  		var rows =  $("#dg").datagrid("getSelections");
  		if(rows.length!=1){
  			$.messager.alert('提示','请选择一条进行编辑');   
  		}else{
  			var url = "projectController.do?goadd&id="+rows[0].ID;
  			createwindow("更新", url,400,300);
  		}
  		
  		
  	}
  	
  	
  	function deletes(id){
  		$.ajax({
  			url:'projectController.do?deletes&id='+id,
  			dataType:'JSON',
  			success:function(msg){
  				bookdata();
  			}
  		});
  	}
  	
  	
  	function bookdata(){
  		var name1=$("#cc1").val();
  		var name2=$("#cc2").val();
  		var balance=$("#cc3").val();
  		var time1=$("#date1").val();
  		var time2=$("#date2").val();
  		$.ajax({
  			url:'projectController.do?tbdata&names1='+name1+'&names2='+name2+'&time1='+time1+'&time2='+time2+'&balance2='+balance,
  			dataType:'JSON',
  			success:function(msg){
  				var map = msg.attributes.list;
  				var num=msg.obj;
  				$('#dg').datagrid({data:{"total":map.length,"rows":map,"footer":[{"NAME1":"","NAME2":"余额","BAlANCE1":num,"obj":"ss"}]}}).datagrid('clientPaging');
  				//$('#dg').datagrid({data:{"total":map.length,"rows":map,"footer":[{"NAME1":"","NAME2":"余额","BAlANCE1":num,"obj":"SSS"}]}});
  			}
  		});
  		
  	}
  	function exports(){
  		var url="projectController.do?exports";
  		$.ajax({
  			url:url,
  			dataType:'json',
  			success:function(data){
  				alert(data.msg);
  			}
  		})
  	}
  	
  </script>
  
</html>
