<%@page import="operating.*"%>
<%@page import="entity.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

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
<link rel="stylesheet" type="text/css" href="css/lunbo.css" />
<script type="text/javascript" src="js/lunbo.js"></script>
</head>

<body class="mainclass">
<!--菜单层 start-->
<div class="index-div-menu">
    <div class="index-div-menu1"> <!--菜单栏-->
        <div class="index-div-ulmain">
            <ul id="index-ul-mainNav">
                <li> <a class="index-a-logo">TJFSU校园论坛</a> </li>
                <li> <a href="login.jsp">首页</a> </li>
                <li> <a href="login.jsp">分类</a> </li>
                <li> <a href="login.jsp">发表</a> </li>
            </ul>
        </div>
        <div class="indec-div-ulmain2">
            <ul id="index-ul-reandlo">
                <!--登录注册-->
                <li><a href="login.jsp">登录</a></li>
                <li><a href="register.jsp">注册</a></li>
            </ul>
        </div>
    </div>
</div>
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
						欢迎访问TJFSU校园论坛 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%
				       	Date dNow = new Date( );
					    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
					    out.print(ft.format(dNow));
				     	%>
						
					</h3>
				</div>
				<!-- 轮播开始 -->
				<div class="box">
					<div class="box-1">
						<ul>
							<li>
								<img src="images/1.jpg" alt="图片1"></img>
								<h2>欢迎来到天津外国语大学！</h2>
							</li>
							<li>
								<img src="images/2.jpg" alt="图片2"></img>
								<h2>欢迎来到天津外国语大学！</h2>
							</li>
							<li>
								<img src="images/3.jpg" alt="图片3"></img>
								<h2>欢迎来到天津外国语大学！</h2>
							</li>
							<li>
								<img src="images/4.jpg" alt="图片4"></img>
								<h2>欢迎来到天津外国语大学！</h2>
							</li>
							<li>
								<img src="images/5.jpg" alt="图片5"></img>
								<h2>欢迎来到天津外国语大学！</h2>
							</li>
						</ul>
					</div>
					<div class="box-2">
						<ul>
							
						</ul>
					</div>
					<div class="box-3">
						<span class="prev"> < </span>
						<span class="next"> > </span>
					</div>
				</div>
				<!-- 轮播结束 -->
			</div>
        </div>
        <!--中层框架左边 end--> 
        
        <!--中层框架右边 start-->
        <div class="div-contentright"> 
        	<div class="div-main">
	        	<div class="div-main-body">
	          		请登录或注册
	        		<div class="div-main-footer div-JD-section-body-bottom"></div>
	      		</div>
	      	</div>
        </div>
        <!--中层框架右边 end--> 
    </div>
	<!--中层框架 end-->
    
</div>
</body>
</html>
