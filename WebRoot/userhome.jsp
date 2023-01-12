<%@page import="operating.*"%>
<%@page import="entity.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	User user = (User) session.getAttribute("user");
	
	//获取user
	int uId = Integer.parseInt(request.getParameter("uId"));
	User lookuser = OperatingUser.getAUserById(uId); 	
	
	List<Topic> topics = OperatingTopic.getAllTopicByAUser(user);
	List<Reply> replies = OperatingReply.getAllReplyByAUser(user);
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
					<!-- 上div -->
					<div class="div-main-body">
						<div class="div-xx-row">
							<div class="col-md-6">
								<img class="img-djtest-userhome" src="<%=lookuser.getPhoto()%>"
									width="65px" height="65px" />
							</div>
							<div class="col-md-7">
								<h4><%=lookuser.getAccount()%></h4>
								<p class="div-JD-section-body-bottom">
									<%=lookuser.getNickname()%>是第<%=lookuser.getId()%>号会员，加入于<%=lookuser.getRegistrationdate().toString().substring(0, lookuser.getRegistrationdate().toString().length()-2)%>
								</p>
								<p>
									昵称：<%=lookuser.getNickname()%></p>
								<p>
									性别：<%=lookuser.getSex()%></p>
								<p>
									email：<%=lookuser.getEmail()%></p>

							</div>
							<div class="col-md-8"></div>
							<div class="col-md-9">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<!-- 上div -->

				<div class="div-main">
					<!-- 中div -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h3 class="div-title">
							<small>最近发表的帖子</small>
						</h3>
					</div>
					<!-- 标题 -->
					<%
						for (Topic topic : topics) {
							Session session2 = OperatingSession.getSessionById(topic.getsId()); //获取帖子所的分类
							User user2 = OperatingUser.getAUserById(topic.getuId()); //获取帖子的发帖人
					%>

					<div class="div-main-body">
						<!-- 帖子内容 -->
						<ul class="div-JD-list">
							<li class="div-JD-section-first">
								<%
									if (user.getGrade() > 1 && topic.getFlag() != 1) {
								%>
								<div class="div-JD-section-right">
									<!-- 置顶按钮 -->
									<span class="div-badge div-badge-node"> <a
										href="TopTopic?tId=<%=topic.getId()%>">置顶</a>
									</span>
								</div> <!-- 置顶按钮 --> <%
 	}
 %> <%
 	if (user.getGrade() > 1 && topic.getFlag() == 1) {
 %>
								<div class="div-JD-section-right">
									<!-- 置顶按钮 -->
									<span class="div-badge div-badge-node"> <a
										href=CancelTopTopic?tId=<%=topic.getId()%>">取消</a>
									</span>
								</div> <!-- 置顶按钮 --> <%
 	}
 %> <%
 	if (user.getId() == lookuser.getId() || user.getGrade() > 1) { //本人或管理员查看
 %>
								<div class="div-JD-section-right">
									<!-- 删除按钮 -->
									<span class="div-badge div-badge-node"> <a
										href="DeleteTopic?tId=<%=topic.getId()%>">删除</a>
									</span>
								</div> <!-- 删除按钮 --> <%
 	}
 %>

								<div class="div-JD-section-right">
									<span class="div-badge div-badge-node"><%=topic.getReplyCount()%></span>
									<!-- 评论数 -->
								</div>
								<div class="div-JD-section-body">
									<h4 class="div-JD-section-body-head">
										<a href="topic.jsp?id=<%=topic.getId()%>"
											class="div-xinxi-mune"><%=topic.getTopic()%></a>
										<!-- 贴子标题 -->
									</h4>
									<%
										if (topic.getFlag() == 1) {
									%>
									<span class="div-badge div-badge-node">置顶</span>
									<%
										}
									%>
									<p class="div-small">
										<span> <a href="article.jsp?sId=<%=session2.getId()%>"><%=session2.getName()%></a>
										</span>&nbsp;•&nbsp; <span><%=topic.getTime()%> </span>&nbsp;•&nbsp;
									</p>
								</div>
							</li>
						</ul>
						<ul class="div-xx-pagination"></ul>
					</div>
					<!-- 帖子内容 -->

					<%
						}
					%>
				</div>
				<!-- 中div -->


				<div class="div-main">
					<!-- 下div -->
					<div class="div-main-head1">
						<h3 class="div-title">
							<small>最近的评论</small>
						</h3>
					</div>

					<%
						for (int i = 0; i < (replies.size() > 5 ? 5 : replies.size()); i++) {
							Reply reply = replies.get(i);
							Topic topic2 = OperatingTopic.getATopicById(reply.gettId()); //获取评论的主贴
							User user2 = OperatingUser.getAUserById(topic2.getuId()); //获取评论主贴的创建用户
					%>
					<div class="div-main-body">
						<ul class="div-JD-list">
							<li class="div-JD-section-first div-xinxi-reply">
								<div class="div-JD-section-body">
									<%
										if (user.getId() == lookuser.getId() || user.getGrade() > 1) { //本人或管理员查看
									%>
									<div class="div-JD-section-right">
										<!-- 删除按钮 -->
										<span class="div-badge div-badge-node"> <a
											href="DeleteReply?id=<%=reply.getId()%>">删除</a>
										</span>
									</div>
									<!-- 删除按钮 -->
									<%
										}
									%>
									<h4 class="div-JD-section-body-head">
										<small>评论了 </small> <a
											href="userhome.jsp?uId=<%=user2.getId()%>"><%=user2.getNickname()%>
										</a><small>创建的帖子 </small> <a
											href="topic.jsp?id=<%=topic2.getId()%>"><%=topic2.getTopic()%></a>
									</h4>
									<blockquote>
										<%=reply.getContent()%><br /> <small><%=reply.getTime()%></small>
									</blockquote>
								</div>
							</li>
						</ul>
					</div>

					<%
						}
					%>


				</div>
				<!-- 下div -->

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
