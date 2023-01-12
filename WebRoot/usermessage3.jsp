<%@page import="entity.*"%>
<%@page import="operating.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	User user = OperatingUser.getAUserById(1); //默认用户，防止没有session对象传入时候出现问题
	try {
		user = (User) session.getAttribute("user"); //获取session对象
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
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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
<!-- 表单验证js -->
    <script type="text/javascript">
		function checkSave() {	
			var password = document.getElementById("password").value;	//现有密码
			var password1 = document.getElementById("password1").value;	//新密码
			var password2 = document.getElementById("password2").value;	//新密码确认
			
			if (password == null || password == '') {
				alert("请输入现有密码");
				return false;
			} else {
				if (password1 == null || password2 == '') {
					alert("请输入新密码");
					return false;
				} else {
					if (password2 == null || password2 == '') {
						alert("请输入新密码");
						return false;
					} else {
						if (password2 != password1) {
							alert("两次输入的密码不正确");
							return false;
						} else {
							return true;
						}
					}
				}
			}	      	
        };
    </script>
    <!-- 表单验证js -->
<body>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->

	<div class="div-content">
		<!--中层框架 start-->
		<div class="div-contentleft">
			<!--中层框架左边 start-->
			<div class="sqy-div-panel">
				<!-- 内容开始 -->
				<div class="sqy-div-panel-heading">
					<h4>个人资料</h4>
				</div>
				<div class="sqy-div-panel-body">
					<ul class="sqy-nav">
						<li class="sqy-active">
							<a class="sqy-nav-a2" href="usermessage.jsp?uId=<%=user.getId() %>">基本信息</a></li>
						<li class="sqy-active">
							<a class="sqy-nav-a" >修改密码</a>
						</li>
					</ul>
					<div class="sqy-setting">
						<form action="ChangeUserPassword?uId=<%=user.getId() %>" class="sqy-form"	method="post" onSubmit="return checkSave()">
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="password">当前密码</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="password" name="password"   size="50" type="password"> 
								</div>
							</div>
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="password">新密码</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="password1" name="password1" size="50" type="password">
								</div>
							</div>
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="password">密码确认</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="password2" name="password2" 	size="50" type="password"> 
								</div>
							</div>
		
							<div class="sqy-form-group">
								<div class="sqy-col-sm-offset-3 sqy-col-sm-9">
									<button type="submit" name="commit"	class="sqy-div-btn sqy-btn-primary">修改密码</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 内容结束 -->
		</div>
		<!--中层框架左边 end-->

		<jsp:include page="left.jsp" flush="true"/>
		<!--中层框架右边 end-->
	</div>
	<jsp:include page="foot.jsp" flush="true"/>
	<!--中层框架 end-->
</body>
</html>
