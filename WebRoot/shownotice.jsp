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

	List<Notice> list = OperatingNotice.getAllNotice();
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
</head>
<body>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->

	<div class="div-maincontainer">
		<!--中层框架 start-->
		<div class="div-content">
			<!--中层框架左边 start-->
			<div class="div-contentleft">
				<div class="div-main">
					<!-- 下div -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h3 class="div-title">
							公告通知列表
						</h3>
					</div>

					<div class="div-main-body">
						<!-- 内容 -->
						<div class="div-JD-list">
							<% for(int i=0;i<list.size();i++){ Notice tempnotice = list.get(i); %>
							<div class="div-JD-section-first">
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<%=tempnotice.getContent() %>
									</h4>
									<p class="div-JD-section-body-bottom">
										<span><%=tempnotice.getCreatedate() %></span>
									</p>
								</div>
							</div>
							<% } %>
						</div>
					</div>
				</div>
			</div>
			<!--中层框架左边 end-->

			<jsp:include page="left.jsp" flush="true"/>
			</div>
			<!--中层框架右边 end-->
		</div>
		<!--中层框架 end-->

		<!--底部	-->
		<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>
