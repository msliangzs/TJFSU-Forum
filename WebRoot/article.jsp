<%@page import="entity.User"%>
<%@page import="operating.OperatingUser"%>
<%@page import="operating.OperatingSession"%>
<%@page import="entity.Topic"%>
<%@page import="operating.OperatingTopic"%>
<%@page import="entity.Session"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="database.BBSDatabase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String keywords = request.getParameter("keywords");
	
	
	int sId = Integer.parseInt(request.getParameter("sId"));
	
	User user = OperatingUser.getAUserById(1);	//默认用户，防止没有session对象传入时候出现问题
	try {
		user = (User)session.getAttribute("user");		//获取session对象
	} catch (Exception e) {
		session.setAttribute("error", "用户登陆错误");
		session.setAttribute("lastpage", "login.jsp");
		
		response.sendRedirect("error.jsp");
	}
		
	Session session2 = OperatingSession.getSessionById(sId); 		//通过url的id值获取session	
	List<Topic> list = OperatingTopic.getTopicBySession(session2,keywords);
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
	function xianshi() {
		document.getElementById("uldown").style.display = "inline";
	}
	function yincang() {
		document.getElementById("uldown").style.display = "none";
	}
</script>
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
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->
	<div class="div-maincontainer">
		<!--中层框架 start-->
		<div class="div-content">
			<div class="div-contentleft">
				<!--中层框架左边 start-->

				<div class="div-main">
					<!-- 上div -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h3 class="div-title">
							分类名称：<%=session2.getName()%>
							<span class="div-JD-section-right">帖子总数<span class="div-badge div-article-badge"><%=session2.getTopicCount() %></span> </span>
						</h3>
					</div>
					<div class="div-main-body"><%=session2.getProfile() %></div>
					<!-- 内容 -->
				</div>

				<div class="div-main">
					<!-- 下div -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h3 class="div-title">
							 帖子列表 
							<span class="div-JD-section-right">
								<a class="div-lable div-article-lable" href="add.jsp">快速发表</a> 
							</span>
						</h3>
					</div>
					<form action="<%=path %>/article.jsp">
						<input style="line-height: 30px;margin: 10px; width: 300px;" type="text" name="keywords">
						<input type="hidden" name="sId" value="<%=sId%>">
						<input type="submit" value="搜索" class="sqy-div-btn sqy-btn-primary">
						<input type="submit" onclick="setOrderdate()" value="按发布时间排序" class="sqy-div-btn sqy-btn-primary">
						<input type="submit" onclick="setOrderclickcount()" value="按点击量排序" class="sqy-div-btn sqy-btn-primary">
					</form>
					<%
						for (Topic topic : list) {
							User user2 = OperatingUser.getAUserById(topic.getuId());		//获取发帖人
							if (topic.getFlag() == 1) {		//先输出置顶的帖子
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
									<a href="<%=path %>/supportcountservlet?cmd=topic2&topicid=<%=topic.getId() %>&sId=<%=sId %>">点赞</a></span>
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
									if (user.getGrade() > 1 || user2.getId() == user.getId()) {		//本人或管理员可以删除
								%>								
								<div class="div-JD-section-right">	<!-- 删除按钮 -->
									<span class="div-badge div-badge-node">
									<a href="DeleteTopic?tId=<%=topic.getId()%>">删除</a></span>
								</div>	<!-- 删除按钮 -->
								<%
									}
								%>								
							
								<a class="div-JD-section-left" href="userhome.jsp?uId=<%=user2.getId()%>"> 
									<img class="div-JD-img" src="<%=user2.getPhoto() %>" alt="<%=user2.getNickname() %>" /> 	<!-- 用户头像 -->
								</a>
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<a href="topic.jsp?id=<%=topic.getId()%>"><%=topic.getTopic() %></a> <!-- 帖子标题 -->
										<%
											if (topic.getFlag() == 1) {
										%>
										<span	class="div-badge div-badge-node">置顶</span>
										<%
											}
										 %>
									</h4>
									
									<p class="div-JD-section-body-bottom">
										<span> 
											<a href="article.jsp?sId=<%=sId%>"><%=session2.getName() %></a> 	<!-- 分类标题 -->
										</span>&nbsp;•&nbsp; 
										<span>
											<a href="userhome.jsp?uId=<%=user2.getId()%>"><%=user2.getNickname() %></a> <!-- 用户 -->
										</span>&nbsp;•&nbsp; 
										<span>
											<%=topic.getTime() %><!-- 发帖时间 -->
										</span>
										&nbsp;•&nbsp; 
										<span>
											访问量：<%=topic.getClickCount() %><!-- 帖子访问量 -->
										</span>
										&nbsp;
										•&nbsp; 
										<span>
											点赞数：<%=topic.getSupportCount() %>
										</span>
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
						for (Topic topic : list) {
							User user2 = OperatingUser.getAUserById(topic.getuId());		//获取发帖人
							if (topic.getFlag() == 0) {
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
									<a href="<%=path %>/supportcountservlet?cmd=topic2&topicid=<%=topic.getId() %>&sId=<%=sId %>">点赞</a></span>
								</div>
								<%
									if (user.getGrade() > 1) {		//管理员可以置顶
								%>
								<div class="div-JD-section-right">	<!-- 置顶按钮 -->
									<span class="div-badge div-badge-node">
									<a href="TopTopic?tId=<%=topic.getId()%>">置顶</a></span>
								</div>	<!-- 置顶按钮 -->
								<%
									}
								%>	
								<%
									if (user.getGrade() > 1 || user2.getId() == user.getId()) {		//本人或管理员可以删除
								%>								
								<div class="div-JD-section-right">	<!-- 删除按钮 -->
									<span class="div-badge div-badge-node">
									<a href="DeleteTopic?tId=<%=topic.getId()%>">删除</a></span>
								</div>	<!-- 删除按钮 -->
								<%
									}
								%>								
							
								<a class="div-JD-section-left" href="userhome.jsp?uId=<%=user.getId()%>"> 
									<img class="div-JD-img" src="<%=user.getPhoto() %>" alt="<%=user.getNickname() %>" /> 	<!-- 用户头像 -->
								</a>
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<a href="topic.jsp?id=<%=topic.getId()%>"><%=topic.getTopic() %></a> <!-- 帖子标题 -->
										<%
											if (topic.getFlag() == 1) {
										%>
										<span	class="div-badge div-badge-node">置顶</span>
										<%
											}
										 %>
									</h4>
									<p class="div-JD-section-body-bottom">
										<span> 
											<a href="article.jsp?sId=<%=sId%>"><%=session2.getName() %></a> 	<!-- 分类标题 -->
										</span>&nbsp;•&nbsp; 
										<span>
											<a href="userhome.jsp?uId=<%=user2.getId()%>"><%=user2.getNickname() %></a> <!-- 用户 -->
										</span>
										&nbsp;•&nbsp; 
										<span>
											<%=topic.getTime() %><!-- 发帖时间 -->
										</span>
										&nbsp;
										•&nbsp; 
										<span>
											访问量：<%=topic.getClickCount() %><!-- 帖子访问量 -->
										</span>
										&nbsp;
										•&nbsp; 
										<span>
											点赞数：<%=topic.getSupportCount() %>
										</span>
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

			<!--中层框架右边 start-->
			<jsp:include page="left.jsp" flush="true"/>
			</div>
			<!--中层框架右边 end-->
		</div>
		<!--中层框架 end-->

		<!--底部	-->
		<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>
