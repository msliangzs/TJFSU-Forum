<%@page import="entity.*"%>
<%@page import="operating.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	
	String keywords = request.getParameter("keywords");
	String orderdate = request.getParameter("orderdate");
	String orderclickcount = request.getParameter("orderclickcount");
	
	User user = OperatingUser.getAUserById(1);	//默认用户，防止没有session对象传入时候出现问题
	try {
		user = (User)session.getAttribute("user");		//获取session对象
	} catch (Exception e) {
		session.setAttribute("error", "用户登陆错误");
		session.setAttribute("lastpage", "login.jsp");
		
		response.sendRedirect("error.jsp");
	}

	List<Topic> list = OperatingTopic.getAllTopic(keywords,orderdate,orderclickcount);
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
<link rel="stylesheet" type="text/css" href="css/SQY.css" />
</head>
<script type="text/javascript">
	function setOrderdate(){
		document.getElementById("orderdate").value="time";
		document.getElementById("orderclickcount").value="";
	}
	function setOrderclickcount(){
		document.getElementById("orderdate").value="";
		document.getElementById("orderclickcount").value="clickCount";
	}
</script>
<body>
	<div>
	<jsp:include page="head.jsp" flush="true"/>

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
							欢迎访问TJFSU校园论坛
						</h3>
					</div>
					<form action="<%=path %>/index.jsp">
						<input style="line-height: 30px;margin: 10px; width: 300px;" type="text" name="keywords">
						<input type="hidden" id="orderdate" name="orderdate" value=""/>
						<input type="hidden" id="orderclickcount" name="orderclickcount" value=""/>
						<input type="submit" value="搜索" class="sqy-div-btn sqy-btn-primary">
						<input type="submit" onclick="setOrderdate()" value="按发布时间排序" class="sqy-div-btn sqy-btn-primary">
						<input type="submit" onclick="setOrderclickcount()" value="按点击量排序" class="sqy-div-btn sqy-btn-primary">
					</form>
					<hr/>
					<%
						for (Topic topic:list) {
							User user2 = OperatingUser.getAUserById(topic.getuId());		//获取发帖人
							Session session2 = OperatingSession.getSessionById(topic.getsId());	//获取topic所在session						
							if (topic.getFlag() == 1) {		//先输出置顶
					%>
					<div class="div-main-body">
						<!-- 内容 -->
						<div class="div-JD-list">
							<div class="div-JD-section-right">
								<span class="div-badge div-badge-node"><%=topic.getReplyCount() %>评论</span>	<!-- 评论数 -->
							</div>
							<div class="div-JD-section-first">
								<div class="div-JD-section-right">
									<span class="div-badge div-badge-node">
									<a href="<%=path %>/supportcountservlet?cmd=topic1&topicid=<%=topic.getId() %>">点赞</a></span>
								</div>
								<%
									if (user.getGrade() > 1) {		//管理员可以取消置顶
								%>
									<div class="div-JD-section-right">	<!-- 删除按钮 -->
										<span class="div-badge div-badge-node">
										<a href="CancelTopTopic?tId=<%=topic.getId()%>">取消</a></span>
									</div>	<!-- 删除按钮 -->									
								<%
									}
								%>	
								<%
									if (user.getGrade() > 1 || user.getId() == user2.getId()) {		//本人和管理员可以删除
								%>									
									<div class="div-JD-section-right">	<!-- 删除按钮 -->
										<span class="div-badge div-badge-node">
										<a href="DeleteTopic?tId=<%=topic.getId()%>">删除</a></span>
									</div>	<!-- 删除按钮 -->	
								<%
									}
								%>	
								<a class="div-JD-section-left"
									href="userhome.jsp?uId=<%=user2.getId()%>"> <img
									class="div-JD-img" src="<%=user2.getPhoto()%>" alt="admin" />
									<!-- 用户头像 --> </a>
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<a href="topic.jsp?id=<%=topic.getId()%>"><%=topic.getTopic()%></a>
										<!-- 帖子标题 -->
										<%
											if (topic.getFlag() == 1) {
										%>
												<span class="div-badge div-badge-node">置顶</span>
										<%
											}
										 %>
									</h4>
									<p class="div-JD-section-body-bottom"><!-- 获取topic所在session -->
										<span> <a href="article.jsp?sId=<%=session2.getId()%>"><%=session2.getName()%>
											<!-- 分类标题 --> </span>&nbsp;•&nbsp; 
										<span> <a href="userhome.jsp?uId=<%=user2.getId()%>"><%=user2.getNickname()%></a>
											<!-- 用户 --> 
										</span>&nbsp;•&nbsp; <%=topic.getTime()%>•访问量：<%=topic.getClickCount()%>•点赞数：<%=topic.getSupportCount()%>
									</p>
								</div>
							</div>
						</div>
					</div>
					<%
					}
						}
					%>
					<%
						for (Topic topic:list) {
							User user2 = OperatingUser.getAUserById(topic.getuId());		//获取发帖人
							Session session2 = OperatingSession.getSessionById(topic.getsId());	//获取topic所在session
							if (topic.getFlag() == 0) {		//正常帖子排序
					%>
					<div class="div-main-body">
						<!-- 内容 -->
						<div class="div-JD-list">
							<div class="div-JD-section-right">
								<span class="div-badge div-badge-node"><%=topic.getReplyCount() %>评论</span>	<!-- 评论数 -->
							</div>
							<div class="div-JD-section-first">
								<div class="div-JD-section-right">
									<span class="div-badge div-badge-node">
									<a href="<%=path %>/supportcountservlet?cmd=topic1&topicid=<%=topic.getId() %>">点赞</a></span>
								</div>
								<%
									if (user.getGrade() > 1) {	//管理员可以置顶
								%>
								<div class="div-JD-section-right">	<!-- 置顶按钮 -->
									<span class="div-badge div-badge-node">
									<a href="TopTopic?tId=<%=topic.getId()%>">置顶</a></span>
								</div>	<!-- 置顶按钮 -->								
								<%
									}
								%>	
								<%
									if (user.getGrade() > 1 || user.getId() == user2.getId()) {	//本人可以删除
								%>								
								<div class="div-JD-section-right">	<!-- 删除按钮 -->
									<span class="div-badge div-badge-node">
									<a href="DeleteTopic?tId=<%=topic.getId()%>">删除</a></span>
								</div>	<!-- 删除按钮 -->
								<%
									}
								%>	
								<a class="div-JD-section-left"
									href="userhome.jsp?uId=<%=user2.getId()%>"> <img
									class="div-JD-img" src="<%=user2.getPhoto()%>" alt="admin" />
									<!-- 用户头像 --> </a>
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<a href="topic.jsp?id=<%=topic.getId()%>"><%=topic.getTopic()%></a>
										<!-- 帖子标题 -->
										<%
											if (topic.getFlag() == 1) {
										%>
												<span class="div-badge div-badge-node">置顶</span>
										<%
											}
										 %>
									</h4>
									<p class="div-JD-section-body-bottom"><!-- 获取topic所在session -->
										<span> <a href="article.jsp?sId=<%=session2.getId()%>"><%=session2.getName()%>
											<!-- 分类标题 --> </span>&nbsp;•&nbsp; <span> <a
											href="userhome.jsp?uId=<%=user2.getId()%>"><%=user2.getNickname()%></a>
											<!-- 用户 --> </span>&nbsp;•&nbsp; <%=topic.getTime()%>•访问量：<%=topic.getClickCount()%>•点赞数：<%=topic.getSupportCount()%>
									</p>
								</div>
							</div>
						</div>
					</div>
					<%
					}
						}
					%>
				</div>
			</div>
			<!--中层框架左边 end-->

			<jsp:include page="left.jsp" flush="true"/>
			</div>
			<!--中层框架右边 end-->
		</div>
		<!--中层框架 end-->
		<jsp:include page="foot.jsp" flush="true"/>
	</div>
</body>
</html>
