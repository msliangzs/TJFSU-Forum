<%@page import="entity.*"%>
<%@page import="operating.*"%>
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

List<User> userlist = OperatingUser.getAllUser();
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
  <body>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->
	
	<div class="div-content">
	<div class="div-contentleft">	<!-- 框架开始-->
	  <div class="div-main">
	   <div class="div-main-head1 div-title">用户信息</div>
	   <div class="div-main-body">
		<table>
	      <tr>
	        <td>编号</td>
	        <td>头像</td>
	        <td>用户名</td>
	        <td>密码</td>
	        <td>昵称</td>
	        <td>email</td>
	        <td>性别</td>
	        <td>等级权限</td>
	        <td>注册日期</td>
            <td>操作</td>
	      </tr>
	      <%
	      	for (User usertemp : userlist) {
	      
	      	/*
	      	for (int i=0; i<userlist.size(); i++) {
	      		User usertemp = new User();	//
	      		usertemp = userlist.get(i);	//userlist[i]*/
	      %>
	      		<tr>
			        <td><%=usertemp.getId() %></td>
			        <td><img alt="" src="<%=usertemp.getPhoto() %>"></td>
			        <td><%=usertemp.getAccount() %></td>
			        <td><%=usertemp.getPassword() %></td>
			        <td><%=usertemp.getNickname() %></td>
			        <td><%=usertemp.getEmail() %></td>
			        <td><%=usertemp.getSex() %></td>
			        <td><%=usertemp.getGrade() %></td>
			        <td><%=usertemp.getRegistrationdate().toString().substring(0, usertemp.getRegistrationdate().toString().length()-2) %></td>
                    <td><% if(usertemp.getGrade()!=3) {%><a href="DeleteUser?uId=<%=usertemp.getId()%>">删除</a><%} %></td>
			      </tr>
			<%
	      	}
	       %>
	    </table>
	   </div>
	  </div>
	</div>	<!-- 框架结束-->
	<div class="div-contentright">	<!--中层框架右边 start-->	
		<div class="div-main">
		<div class="div-main-head1 div-title">添加用户</div>
	   	<div class="div-main-body">
					<div class="sqy-setting">
						<form class="sqy-form" action="AddUser" method="post" onSubmit="return checkSave()">
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="profile">  &nbsp;&nbsp;用户名</label>
								<div class="sqy-col-md-5">
									<input class="sqy-form-control" id="account" name="account" type="text" />
								</div>
							</div>
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="profile">密码</label>
								<div class="sqy-col-md-5">
									<input class="sqy-form-control" id="password" name="password" type="text" />
								</div>
							</div>
							<div class="sqy-form-group">
								<div class="sqy-col-md-6">
									<button type="submit" class="sqy-div-btn sqy-btn-primary">添加用户</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>	<!--中层框架右边 end-->
	</div>
	<jsp:include page="foot.jsp" flush="true"/>
  </body>
</html>
