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
<link rel="stylesheet" type="text/css" href="plug_in/css/botton.css">
<style>
.menu1 {
	float: left;
	margin-top: 10%;
	margin-bottom: 10%;
	margin-left: 10%;
}

#tt {
	float: left;
	margin-left: 0;
}

.ss {
	width: 20px;
	height: 20px;
	background: url(plug_in/easyui/themes/black/images/slider_handle.png)
		no-repeat;
	-webkit-transition: all 0.35s;
}

.tree-collapsed,.tree-expanded {
	background: url('');
}

.tree-title {
	font-size: 20px;
}

.tree-node {
	margin-top: 10%;
}

.tree-node-selected {
	background: #6AC0EF !important;
}

a {
	text-decoration: none;
}

a:visited {
	color: #000000;
}

a:hover {
	color: #6AC0EF !important;
	opacity: 1;
	filter: alpha(opacity = 100);
	background-color: white;
	-moz-border-radius: 3px 3px 3px 3px;
	-webkit-border-radius: 3px 3px 3px 3px;
	border-radius: 3px 3px 3px 3px;
}

.ss:hover {
	-webkit-transform: rotateZ(180deg);
	-moz-transform: rotateZ(180deg);
	-o-transform: rotateZ(180deg);
	-ms-transform: rotateZ(180deg);
	transform: rotateZ(180deg);
}

.panel-title {
	font-size: 20px;
	font-weight: bold;
	font-family:'宋体';
	color: #0E2D5F;
	height: 16px;
	line-height: 16px;
}

.tittle span {
	padding-left: 80%
}

.right_tittle {
	margin-top: -28px;
	margin-left: 90%;
	position: absolute;
}

.tittle_bjl {
	float: left;
	background-position: left;
}

.tittle_bjr {
	float: left;
}
</style>
</head>
<script type="text/javascript">
	var rid = '${rid}';
	var username ='${username }';
</script>
<body class="easyui-layout" style="overflow-y: hidden">
<input id="rid" value="${rid }" disabled="disabled" />
	<div data-options="region:'north'"
		style="overflow-y: hidden;padding:0px;height:130px;margin-bottom: 0px;">
		<div class="panel-header tittle" style="border-bottom-width: 0px;background: url('plug_in/images/top_bg.jpg') no-repeat right;">
			<span>用户名: ${username } </span>
		</div>
		<div class="right_tittle">
			<a href="javascript:void(0)" id="mb">操作</a>
		</div>

		<div class="tittle_bjl"
			style="float:left;height: 88px; width: 99%;margin: 4px 4px">
			
			<c:forEach items="${list}" var="menu">
			<input name="fid" value="${menu.id }" style="display: none;">
				<div id="div" style="float: right;margin-right: 15px">
		        	<button  class="rb-candy" onclick="javascript:void(0);menus('${menu.id }')">${menu.functionName }</button>
		        </div>
			</c:forEach>
		</div>
		<div id="mm" style="width:150px;">
			<div id="btn1" data-options="iconCls:'icon-edit'">修改密码</div>
			<div id="btn2" data-options="iconCls:'icon-undo'">退出登录</div>
		</div>
	</div>
	<div data-options="region:'west',title:'菜    单'"
		style="padding:0px;width:150px;">
		<ul id="ttss" class="easyui-tree"></ul>
	</div>
	<div data-options="region:'center',title:''"
		style="padding:0px;background:#eee;">
		<div id="tt" class="easyui-tabs" fit="true" border="false"">
			<div title="首页" style="padding:0px;display:none;margin: 3px 3px;overflow: hidden;">
				<div id="menu" class="easyui-menu"
					style="width: 50px; display: none;">
					<div data-options="iconCls:'icon-edit'" onclick="onClickCell();">修改</div>
					<div data-options="iconCls:'icon-save'" onclick="copy();">复制</div>
					<div data-options="iconCls:'icon-save'" onclick="save()">粘贴</div>
					<div data-options="iconCls:'icon-save'" onclick="add()">保存</div>
				</div>
				<div class="content">
					<div class="charts" id="div1" style="width: 49%;height: 49%"></div>
					<div class="charts" id="div2" style="width: 49%;height: 49%"></div>
					<div class="charts" id="div3" style="width: 99%;height: 48%"></div>
					<!-- <table id="dg"></table> -->
				</div>
			</div>
			
		</div>
	</div>
</body>


</html>
<script type="text/javascript" src="plug_in/js/echarts-all.js"></script>
<script type="text/javascript">
	window.onload = function() {
		var ss=document.getElementsByName("fid");
		
		menu($("#rid").val(),$(ss[ss.length-1]).val());
		
		
		$('#mb').menubutton({
			iconCls : 'icon-edit',
			menu : '#mm'
		});
		$('#btn2').bind('click', function() {
			top.location = 'loginController.do?exit';
			//location.reload();
		});
		$('#btn1').bind('click', function() {
			createwindow("修改密码", "loginController.do?goUpdate",300,200);
		});

		$('.easyui-tree').tree({
			onClick : function(node) {
				openThisNoed(node);
			}
		});
		
		
		function openThisNoed(node) {
			if (node.state == "open") {
				$('.easyui-tree').tree('collapse', node.target);
				return;
			}
			var children = $('.easyui-tree').tree('getChildren', node.target);
			var pnode = null;
			try {
				pnode = $('.easyui-tree').tree('getParent', node.target);
			} catch (e) {
			}
			if (pnode && children && children.length > 0) {
				$(pnode).each(function() {
					$('.easyui-tree').tree('collapse', this);
				});
				$('.easyui-tree').tree('expand', node.target);
			} else if (children && children.length > 0) {
				$('.easyui-tree').tree('collapseAll');
				$('.easyui-tree').tree('expand', node.target);
			}

			// begin author：屈然博 2013-7-12 for：叶子节点扩大点击范围
			if (children = null || children.length == 0) {
				var fun = $(node.target).find('a').attr("onclick");
				//modified by liyang@20161020-----start------设置菜单选中样式
				if (pnode) {
					$(pnode.target).parent().parent().find('span').css("color",
							"white");
					$(node.target).parent().parent().find('span').css("color",
							"#dcdcdc");
				} else {
					$(node.target).parent().parent().find('span').css("color",
							"white");
				}
				$(node.target).find('span').css("color", "#6AC0EF");
				//modified by liyang@20161020-----end------设置菜单选中样式
				var params = fun.substring(7, fun.length - 1).replaceAll("'",
						"").split(",");
				addTab(params[0], params[1], params[2]);
			}
			// end author：屈然博 2013-7-12 for：叶子节点扩大点击范围
		}
		var div1 = document.getElementById("div1");
		var div2 = document.getElementById("div2");
		var div3 = document.getElementById("div3");
		var myChart01 = echarts.init(div1);
		var myChart02 = echarts.init(div2);
		var myChart03 = echarts.init(div3);
		
		myChart01.setOption(option00,true);
		myChart02.setOption(option01,true);
		myChart03.setOption(option02,true);
		
		getEcharts("bookSaleController.do?getEcharts",myChart01);
		getEcharts1("bookController.do?getEcharts",myChart02);
		getEcharts2("bookOrderController.do?getEcharts",myChart03);
	}
	
	var option00={
		    title : {
		        text: '教材售出TOP5',
		        x:'center'
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ['']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'',
		            type:'bar',
		            data:[''],
		            markPoint : {
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        }
		    ]
		};
	var option01={
		    title : {
		        text: '教材剩余库存所占比例',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient : 'vertical',
		        x : 'left',
		        data:['','','','','']
		    },
		    calculable : true,
		    series : [
		        {
		            name:'',
		            type:'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:['']
		        }
		    ]
		};
	var option02={
		    title : {
		        text: '订单数量TOP10',
		        x:'center'
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ['']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'',
		            type:'bar',
		            data:[''],
		            markPoint : {
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        }
		    ]
		};
	
	function getEcharts(url,mycharts){
		$.ajax({
			url:url,
			dataType:'JSON',
			success:function(data){
				var map = data.attributes.list;
				var x = [],y=[];
				for(var i=0;i<map.length;i++){
					x.push(map[i].BOOKNAME);
					y.push(map[i].NUM);
				}
				option00.xAxis[0].data=x;
				option00.series[0].data=y;
				mycharts.setOption(option00,true);
			}
		});
	}
	function getEcharts1(url,mycharts){
		$.ajax({
			url:url,
			dataType:'JSON',
			success:function(data){
				var map = data.attributes.list;
				var x = [],y=[];
				for(var i=0;i<map.length;i++){
					x.push(map[i].NAME);
					y.push({"value":map[i].VALUE,"name":map[i].NAME});
				}
				option01.legend.data=x;
				option01.series[0].data=y;
				mycharts.setOption(option01,true);
			}
		});
	}
	function getEcharts2(url,mycharts){
		$.ajax({
			url:url,
			dataType:'JSON',
			success:function(data){
				var map = data.attributes.list;
				var x = [],y=[];
				for(var i=0;i<map.length;i++){
					x.push(map[i].CPN);
					y.push(map[i].NUM);
				}
				option02.xAxis[0].data=x;
				option02.series[0].data=y;
				mycharts.setOption(option02,true);
			}
		});
	}
	
	
	
	function menus(fid){
		menu($("#rid").val(),fid);
	}
	function tete() {
		alert(111);
	}


	//加载 菜单
	function menu(id,fid){
		$.ajax({
			url:'tsFunctionController.do?menu&rid='+id+'&fid='+fid,
			dataType:'json',
			success:function(data){
				var map = data.attributes.list;
				$('#ttss').tree({data :map});
			}
			
		})
	}
	
	function menu_data(map){
		var d = new Array();
	}
	

	$.extend($.fn.datagrid.methods, {
		editCell : function(jq, param) {
			return jq.each(function() {
				var opts = $(this).datagrid('options');
				var fields = $(this).datagrid('getColumnFields', true).concat(
						$(this).datagrid('getColumnFields'));
				for (var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor1 = col.editor;
					if (fields[i] != param.field) {
						col.editor = null;
					}
				}
				$(this).datagrid('beginEdit', param.index);
				for (var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor = col.editor1;
				}
			});
		},

	});

	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#dg').datagrid('validateRow', editIndex)) {

			$('#dg').datagrid('endEdit', editIndex);

			editIndex = undefined;
			return true;
		} else {
			editIndex = undefined;
			return false;
		}
	}
	function onClickCell() {
		var row = $("#dg").datagrid("getSelections");
		var index = $("#dg").datagrid("getRowIndex", row[0]);
		console.log($('#dg').datagrid("options").columns);
		if (endEditing()) {

			$('#dg').datagrid('selectRow', index).datagrid('editCell', {
				index : index,
				field : "B"
			});
			editIndex = index;
		}
	}

	var rowdata = [];
	function copy() {
		var rows = $("#dg").datagrid("getSelections");
		for (var i = 0; i < rows.length; i++) {
			var data = {
				A : rows[i].A,
				B : rows[i].B
			};
			rowdata.push(data);
		}

	}
	function save() {
		var rows = $("#dg").datagrid("getSelections");
		var index = $("#dg").datagrid("getRowIndex", rows[rows.length - 1]);
		$("#dg").datagrid("insertRow", {
			index : index + 1,
			row : rowdata[0]
		});
		rowdata = [];
	}
	function add() {

		var rows = $("#dg").datagrid("getRows");
		for ( var i in rows) {
			var index = $("#dg").datagrid("getRowIndex", rows[i]);
			console.log(index);
		}

	}

	function addSameOneTab(subtitle, url, icon) {
		if (icon == '') {
			icon = 'icon folder';
		}
		if (window.top.$('#tt').tabs('exists', subtitle)) {
			window.top.$('#tt').tabs('select', subtitle);
			if (url != perUrl) {
				perUrl = url;
				window.top
						.$('#tt')
						.tabs(
								'update',
								{
									tab : window.top.$('#tt').tabs(
											'getSelected'),
									options : {
										title : subtitle,
										content : '<iframe src="'
												+ url
												+ '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
										closable : true,
										icon : icon
									}
								});
			} else {
				window.top.$('#tt').tabs('select', subtitle);
			}
		} else {
			perUrl = url;
			window.top
					.$('#tt')
					.tabs(
							'add',
							{
								title : subtitle,
								content : '<iframe src="'
										+ url
										+ '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
								closable : true,
								icon : icon
							});
		}
	}
</script>



