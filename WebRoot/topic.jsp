<%@page import="operating.*"%>
<%@page import="entity.*"%>
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
	
	int id = Integer.parseInt(request.getParameter("id"));		//传递帖子的id
	Topic topic1 = OperatingTopic.getATopicById(id);	//通过id获取帖子
	Session session1 = OperatingSession.getSessionById(topic1.getsId());		//获取帖子所在分类
	User user1 = OperatingUser.getAUserById(topic1.getuId());	//获取发帖人user
	//将访帖子访问量+1
	OperatingTopic.editATopicClickcount(topic1);
	
	List<Reply> replylist = OperatingReply.getReplyByTopic(topic1);		//获取该帖子的回帖
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>TJFSU校园论坛</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="img/logo.png" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/login-register.css" />
<link rel="stylesheet" type="text/css" href="css/DYH.css" />

<script type="text/javascript" src="fckeditor/fckeditor.js"></script>
<!--FCKEditor-->
<script type="text/javascript">	
window.onload = function()	{
		var sBasePath = "<%=basePath + "fckeditor/"%>";
		var oFCKeditor = new FCKeditor('contents');
		oFCKeditor.ToolbarSet = "DjDesign"; //自定义的ui
		oFCKeditor.Height = 300;
		oFCKeditor.BasePath = sBasePath;
		oFCKeditor.ReplaceTextarea();
	}
</script>
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
	function checkadd() {	
	};
	function showReplysDiv(id,fromuser,touser) {
		$("#div-"+id).show();
		var firstcontent = fromuser+"回复"+touser+"说："
		$("#replyscontent-"+id).text(firstcontent);
	};
	function hideReplysDiv(id) {
		$("#div-"+id).hide();
	};
</script>
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
					<!-- div上 -->
					<div class="div-main-head2">
						<!-- 标题 -->
						<div class="div-JD-section-right">
							<a href="userhome.jsp?uId=<%=user1.getId()%>"> 
							<img class="div-topic-img" src="<%=user1.getPhoto()%>" alt="admin">
							</a>
						</div>
						<p>
							<a href="index.jsp">首页</a> / <a
								href="article.jsp?sId=<%=session1.getId()%>"><%=session1.getName()%></a>
						</p>
						<h2 class="div-title div-topic-title"><%=topic1.getTopic()%></h2>
						<small class="div-JD-section-body-bottom"> 
						<span>发帖人：<%=user1.getNickname()%></span>/<span>访问量：<%=topic1.getClickCount()%></span>/<span>点赞数：<%=topic1.getSupportCount()%></span>
						</small>
						<small class="div-JD-section-body-bottom"> 
							<span class="div-badge div-badge-node"> 
								<a href="<%=path %>/supportcountservlet?cmd=topic3&topicid=<%=topic1.getId()%>">点赞</a>
							</span>
						</small>
					</div>
					<!-- 标题 -->

					<div class="div-main-body">
						<!-- 内容 -->
						<p><%=topic1.getContents()%></p>
					</div>
					<!-- 内容 -->
					<div class="div-main-footer"></div>
				</div>
				<!-- div上 -->


				<div class="div-main" style="height: 100%;">
					<!-- div中 -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h5>
							<span><%=topic1.getReplyCount()%>个</span><span>评论</span>
						</h5>
					</div>
					<!-- 标题 -->
					<%
						User usertemp = new User();
						int floor = 1;
						for (Reply reply : replylist) {
							usertemp = OperatingUser.getAUserById(reply.getuId()); //获取此评论的用户
					%>
					<div class="div-main-body">
						<div class="div-row">
							<div class="col-md-4">
								<a href="userhome.jsp?uId=<%=usertemp.getId()%>"> <img
									class="div-topic-img" src="<%=usertemp.getPhoto()%>"
									alt="<%=usertemp.getNickname()%>"> </a>
							</div>
							<div class="col-md-5 div-topic-reply-body">
								<%
									if (user.getId() == usertemp.getId() || user.getGrade() > 1) { //本人或管理员查看
								%>
								<div class="div-JD-section-right">
									<!-- 删除按钮 -->
									<span class="div-badge div-badge-node"> <a
										href="DeleteReply?id=<%=reply.getId()%>">删除</a>
									</span>
								</div>
								<%
									}
								%>
								<div class="div-JD-section-right">
									<span class="div-badge div-badge-node"> 
										<a onclick="showReplysDiv(<%=reply.getId()%>,'<%=user.getNickname() %>','<%=usertemp.getNickname()%>')">回复</a>
									</span>
								</div>
								<h5>
									<span> 
										<a href="userhome.jsp?uId=<%=usertemp.getId()%>"><%=usertemp.getNickname()%></a>
										&nbsp;&nbsp;
										评论时间：<%=reply.getTime().toString().substring(0,reply.getTime().toString().length()-2)%>
										&nbsp;&nbsp;
										点赞数：<%=reply.getSupportCount()%>
										&nbsp;&nbsp;
										<a href="supportcountservlet?cmd=reply&replyid=<%=reply.getId()%>&topicid=<%=topic1.getId()%>">点赞</a>
									</span>
									<span class="div-JD-section-right"><%=floor%>楼</span>
								</h5>
								<p>评论内容：<%=reply.getContent()%></p>
								<!-- 开始：回复数据展示区 -->
								<hr/>
								<label>以下为回复列表</label>
								<%
									User usertemp1 = new User();
									//获取当前评论下的所有回复list
									Reply tempreply = new Reply();
									tempreply.setId(reply.getId());
									List<Replys> replyslist = OperatingReplys.getReplysByReply(tempreply);
									for (Replys replys : replyslist) {
										usertemp1 = OperatingUser.getAUserById(replys.getUid());
										if (user.getId() == usertemp1.getId() || user.getGrade() > 1) { //本人或管理员查看
								%>
								<div>
									<%=replys.getContents() %>
									<br/>
									回复时间：<%=replys.getTime() %>
									<br/>
									<a href="DeleteReplys?id=<%=replys.getId()%>&topicid=<%=topic1.getId()%>">删除</a>
									&nbsp;&nbsp;
									<a href="supportcountservlet?cmd=replys&replysid=<%=replys.getId()%>&topicid=<%=topic1.getId()%>">点赞</a>
									<br/>
									点赞数：<%=replys.getSupportCount()%>
								</div>
								<%} else{%>
								<div>
									<%=replys.getContents() %>
								</div>
								<%} %>
								<%} %>
								<!-- 结束：回复数据展示区 -->
								<hr/>
								<hr/>
							</div>
						</div>
					</div>
					<!-- div中 -->
					<!-- 回复开始 -->
					<div class="div-main" id="div-<%=reply.getId() %>" style="display: none;">
						<form action="AddReplys" method="post">
							
							<input type="hidden" name="topicid" value="<%=topic1.getId() %>"/>
							<input type="hidden" name="uid" value="<%=user.getId() %>"/>
							<input type="hidden" name="replyid" value="<%=reply.getId() %>"/>
							<textarea rows="3" cols="50" name="contents" id="replyscontent-<%=reply.getId() %>"></textarea>
							
							<button type="submit">回复</button>
							<button type="button" onclick="hideReplysDiv(<%=reply.getId()%>)">取消</button>
						</form>
					</div>
					<%
						floor++;
						}
					%>
				</div>
				
				
				<div class="div-main">
					<!-- div下 -->
					<div class="div-main-head1">
						<!-- 标题 -->
						<h5>
							<span>评论</span>
						</h5>
					</div>
					<!-- 标题 -->

					<div class="div-main-body">
						<!-- 内容 -->
						<form action="AddReply?tId=<%=topic1.getId()%>" method="post"
							onSubmit="return checkadd()">
							<div class="add-form-group">
								<textarea class="add-form-control" id="contents" name="contents"
									rows="10"></textarea>
							</div>
							<button type="submit">评论</button>
						</form>
					</div>
				</div>
				<!-- 内容 -->
			</div>
			<!-- div下 -->
			<!--中层框架左边 end-->

			<!--中层框架右边 start-->
			<jsp:include page="left.jsp" flush="true"/>
		</div>
		<!--中层框架右边 end-->
	</div>
	<!--中层框架 end-->
</body>
</html>
