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

</head>

<body class="">
	<form id="from" action="projectController.do?imports" method="post"
		enctype="multipart/form-data" target="hidden_frame">
		<table>
			<tr>
				<td><input type="file" name="path"
					accept="application/vnd.ms-excel"></td>
			</tr>
		</table>
	</form>

	<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
	<script type="text/javascript">
		$('#hidden_frame').load(function() {
			var text = $(this).contents().find("body").text();
			// 根据后台返回值处理结果
			try {
				var j = $.parseJSON(text);
				if (j.success) {
					alert("导入成功");
					if (window.opener)
					{
					    window.opener.location.reload();
					}
				} else {
					alert(j.msg + "行出错！！请检查");
					
					if (window.opener)
					{
					    window.opener.location.reload();
					}
				}
			} catch (e) {
				// TODO: handle exception
			}

		});
	</script>
</body>
</html>
