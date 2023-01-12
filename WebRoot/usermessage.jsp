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
			var account = document.getElementById("account").value;	//记录用户名
			var nickName = document.getElementById("nickName").value;	//记录用户昵称
			var email = document.getElementById("email").value;	//记录用户email
			var sex = document.getElementById("sex").value;	//记录用户性别
			
			var nickName1 = /^[1-3]$/;		//昵称1-20字符
			var email1 = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;	//验证email					
			var sex = /^['男'|'女']$/;
			 
			
			if (nickName1.test(nickNmae) != true) {		//验证昵称是否符合要求
				alert("昵称应为1-20位字符组成");
				return false;
			}
			
			if (email1.test(email) != true) {		//验证昵称是否符合要求
				alert("邮箱格式不正确");
				return false;
			} 
			
			if (sex1.test(sex) != true) {		//验证性别
				alert("性别只有男女");
				return false;	
			}
			
			if (nickName == null || nickName == '') {
				alert("请输入昵称");
				return false;
			}else {
				if (email == null || email == '') {
					alert("请输入电子邮箱");
					return false;
				} else {
					if (sex == null || sex == '') {
						alert("请输入性别");
						return false;
					} else{
						return true;						
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
							<a class="sqy-nav-a" >基本信息</a></li>
						<li class="sqy-active">
							<a class="sqy-nav-a2" href="usermessage3.jsp?uId=<%=user.getId() %>">修改密码</a>
						</li>
					</ul>
					<div class="sqy-setting">
						<form class="sqy-form" action="ChangeUserMessage?uId=<%=user.getId() %>" method="post" onSubmit="return checkSave()">
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="account">用户名</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="account" name="account" size="50" type="text" disabled="disabled" value="<%=user.getAccount()%>" />
								</div>
							</div>
							
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="nickName">用户昵称</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="nickName" name="nickName" size="50" type="text" value="<%=user.getNickname()%>" /> 
								</div>
							</div>
							
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="email">电子邮件</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="email" name="email"	 size="50" type="text" value="<%=user.getEmail() %>" />
								</div>
							</div>
							
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="sex">用户性别</label>
								<div class="sqy-col-md-6">
									<input class="sqy-form-control" id="sex" name="sex" size="50"  type="text" value="<%=user.getSex() %>" placeholder="输入 男 或 女"  /> 
								</div>
							</div>
							
							<div class="sqy-form-group">
								<div class="sqy-col-md-6">
									<button type="submit" class="sqy-div-btn sqy-btn-primary">保存</button>
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
	<!--中层框架 end-->
	<jsp:include page="foot.jsp" flush="true"/>
</body>
</html>
