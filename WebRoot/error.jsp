<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校园论坛|Error</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		.error-div-waibiankuang{ /*错误外边框*/
			padding:10px;
			width: 720px;
			height: 400px;
			background: #FFF;
			border:1px solid #999;
			margin:0 auto;
			border-radius:10px;
			box-shadow: 10px 10px 10px #999;
		}
		.error-div-tupian{ /*错误图片*/
			width: 300x;
			height: 225px;
			margin-top: 75px;
			float:left;
		}
		.error-div-cuowutishi{ /*错误提示*/
			width: 400px;
			height: 75px;
			margin-top: 75px;
			float:right;
		}
		.error-div-cuowuneirong{ /*错误内容*/
			width: 400px;
			height: 75px;
			margin-top: 0px;
			float:right;
			background:#F36;
			border-radius:5px;
		}
		.error-div-cuowudiaozhuan{ /*错误跳转*/
			width: 720x;
			height: 50px;
			margin-top: 300px;
			background: #FFF;
			float：left；
			text-align:center;
		}
		.error-div-cuowudiaozhuan a:hover {
			color: #CCC;
		}

	</style>

  </head>
  
  <body>
  	<div class="error-div-waibiankuang">
	   	<div class="error-div-tupian">
			<img src="img/error.jpg" width="300" height="225">
	   	</div>
	       <div class="error-div-cuowutishi">
	       	<td style="FILTER: blur(direction=135,strength=8)"  align="center">
	       		<font face="黑体" color="#CC00CC" size="6">
	       		<b><i>哎呀，网页不见了！</i></b>
	       		</font>
	       	</td>
	   	</div>
	    <div class="error-div-cuowuneirong">
			<p><%=session.getAttribute("error") %></p>
	   	</div>
	    <div class="error-div-cuowudiaozhuan">
			<a href="<%=basePath %>" >返回主页</a><!-- onclick="location.href='javascript:history.go(-1);'" -->
	   	</div>
    </div>
  </body>
</html>
