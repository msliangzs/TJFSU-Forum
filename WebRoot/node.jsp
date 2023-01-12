<%@page import="operating.*"%>
<%@page import="entity.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="database.BBSDatabase"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	User user = OperatingUser.getAUserById(1);	//默认用户，防止没有session对象传入时候出现问题
	try {
		user = (User)session.getAttribute("user");		//获取session对象
	} catch (Exception e) {
		session.setAttribute("error", "用户登陆错误");
		session.setAttribute("lastpage", "login.jsp");
		
		response.sendRedirect("error.jsp");
	}
	
	//统计贴子总数
	List<Session> sessionListTemp = OperatingSession.getAllSession();
	int topicTotalCount = 0;
	for (Session sessiontemp : sessionListTemp) {
		topicTotalCount +=sessiontemp.getTopicCount();
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
</head>
<body>
<div>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->
<div class="div-maincontainer"> 
    <!--中层框架 start-->
    <div class="div-content">
        <div class="div-contentleft"> 
            <!--中层框架左边 start-->
            
            <div class="div-main">
                <div class="div-main-head2">
                    <h3 class="div-title">TJFSU校园论坛<span class="div-JD-section-right"> 贴子总数 <span class="div-badge div-badge-node"> <%=topicTotalCount %> </span> </span> </h3>
                </div>
                <div class="div-main-body">校园论坛|通过网络社区，提供给TJFSUer一个虚拟的空间释放压力。</div>
            </div>
            <div class="div-main">
                <div class="div-main-head2">分类列表</div>
                <div class="div-main-body">
                    <%
                    List<Session> list=OperatingSession.getAllSession();
                    for(int i=0;i<list.size();i++){
                    	Session session2 = list.get(i);
                    %>
                    <div class="div-JD-list">
                        <div class="div-JD-section-first"> 
                        	<a class="div-JD-section-left" href="article.jsp?sId=<%=session2.getId()%>"> 
                        	<img class="div-JD-img" src="img/node/<%=session2.getId() %>.jpg" alt="<%=session2.getName()%>"> </a> 
                        	<span class="div-JD-section-right div-JD-section-text-right">                            
                            	<p><%=session2.getTopicCount() %>个帖子/</p>
                            </span>
                            <div class="div-JD-section-body">
                                <h4 class="div-JD-section-body-head"> <a href="article.jsp?sId=<%=session2.getId()%>"><%=session2.getName() %></a> </h4>
                                <p class="div-JD-section-body-bottom"> <%=session2.getProfile() %></p>
                            </div>
                        </div>
                    </div>
                    <%
               		 }                	
           			%>
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
</div>
</body>
</html>
