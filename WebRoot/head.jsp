<%@page import="entity.*"%>
<%@page import="operating.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	
	User user = OperatingUser.getAUserById(1);	//默认用户，防止没有session对象传入时候出现问题
	try {
		user = (User)session.getAttribute("user");		//获取session对象
	} catch (Exception e) {
		session.setAttribute("error", "用户登陆错误");
		session.setAttribute("lastpage", "login.jsp");
		
		response.sendRedirect("error.jsp");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>TJFSU校园论坛</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="校园论坛,BBS,论坛">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="img/logo.png" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/login-register.css" />
<link rel="stylesheet" type="text/css" href="css/DYH.css" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
</head>
<script type="text/javascript">
	function xianshi() {
		document.getElementById("uldown").style.display = "inline";
	}
	function yincang() {
		document.getElementById("uldown").style.display = "none";
	}
	function xianshi1() {
		document.getElementById("uldown1").style.display = "inline";
	}
	function yincang1() {
		document.getElementById("uldown1").style.display = "none";
	}
</script>

<body>
	<div>
	<!--菜单层 start-->
	<div class="index-div-menu">
		<div class="index-div-menu1">
			<!--菜单栏-->
			<div class="index-div-ulmain">
				<ul id="index-ul-mainNav">
					<li><a class="index-a-logo">TJFSU校园论坛</a></li>
					<li><a href="index.jsp">首页</a></li>
					<%if (user.getGrade() > 1) {%>
					<li><a href="notice.jsp">公告通知管理</a></li>
					<li><a href="yonghuguanli.jsp">用户管理</a></li>
					<%} else{%>
					<li><a href="shownotice.jsp">公告通知</a></li>
					<li><a href="node.jsp">帖子分类展示</a></li>
					<li><a href="add.jsp">发帖</a></li>
					<%} %>
				</ul>
			</div>
			<%if (user.getGrade() > 1) {%>
			<div class="indec-div-ulmain3">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown" onMouseMove="xianshi1()" onMouseOut="yincang1()">
						<a class="dropdown-toggle1">帖子管理<b class="caret"></b> </a>
						<ul id="uldown1" class="dropdown-menu" id="dropdown-menu" onMouseOver="xianshi1()">
							<li><a href="bankuaiguanli.jsp">帖子分类管理</a></li>
							<li><a href="node.jsp">帖子管理</a></li>
							<li><a href="add.jsp">发帖</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<%} %>
			<div class="indec-div-ulmain2">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown" onMouseMove="xianshi()" onMouseOut="yincang()">
						<a href="index.jsp" class="dropdown-toggle"> <%=user.getNickname()%>
							<b class="caret"></b> </a>
						<ul id="uldown" class="dropdown-menu" id="dropdown-menu"	onMouseOver="xianshi()">
							<%-- <li><a href="userhome.jsp?uId=<%=user.getId()%>">个人主页</a></li>
							<li><a href="usermessage.jsp?uId=<%=user.getId()%>">个人资料</a></li> --%>
							<li class="divider"></li>
								<li class="divider"></li>
							<li><a href="LoginOut">退出</a>
							</li>
						</ul>
				</ul>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
