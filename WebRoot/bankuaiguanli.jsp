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

List<Session> sessionlist = OperatingSession.getAllSession();
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
			var name = document.getElementById("name").value;	//记录分类名字
			var profile = document.getElementById("profile").value;	//记录分类名字
			
			if (name == null || name == '') {
				alert("请输入分类名称");
				return false;
			}else {
				if (profile == null || profile == '') {
					alert("请输入分类主题");
					return false;
				} else {
					return true;
				}
			}		      	
        };
    </script>
    <!-- 表单验证js -->
  <body>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->
	
	<div class="div-content">	<!--中层框架 start-->
		<div class="div-contentleft">	<!--中层框架左边 start-->
			
	  <div class="div-main">
	   <div class="div-main-head1 div-title">分类信息</div>
	   <div class="div-main-body">
		<table>
	      <tr>
	        <td>分类ID</td>
	        <td>分类名字</td>
	        <td>分类主题</td>
	        <td>发帖数</td>
            <td>操作</td>
	      </tr>
	      <%
	      	for (Session sessiontemp : sessionlist) {
	      
	      	/*
	      	for (int i=0; i<userlist.size(); i++) {
	      		User usertemp = new User();	//
	      		usertemp = userlist.get(i);	//userlist[i]*/
	      %>
	      		<tr>
			        <td><%=sessiontemp.getId() %></td>
			        <td><%=sessiontemp.getName() %></td>
			        <td><%=sessiontemp.getProfile() %></td>
			        <td><%=sessiontemp.getTopicCount() %></td>
                    <td><a href="DeleteSession?sId=<%=sessiontemp.getId()%>">删除</a></td>
			      </tr>
			<%
	      	}
	       %>
	    </table>
	   </div>
	  </div>
	
		</div>	<!--中层框架左边 end-->
		<div class="div-contentright">	<!--中层框架右边 start-->	
		<div class="div-main">
		<div class="div-main-head1 div-title">添加分类</div>
	   	<div class="div-main-body">
					<div class="sqy-setting">
						<form class="sqy-form"	action="AddSession" method="post" onSubmit="return checkSave()">
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="name">分类名字</label>
								<div class="sqy-col-md-5">
									<input class="sqy-form-control" id="name" name="name" size="50" type="text" />
								</div>
							</div>

							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="profile">分类内容</label>
								<div class="sqy-col-md-5">
									<input class="sqy-form-control" id="profile" name="profile"	size="50" type="text" />
								</div>
							</div>

							<div class="sqy-form-group">
								<div class="sqy-col-md-5">
									<button type="submit" class="sqy-div-btn sqy-btn-primary">添加分类</button>
								</div>
							</div>

						</form>
					</div>
				</div>
					</div>
		</div>	<!--中层框架右边 end-->
	</div>	<!--中层框架 end-->
	<jsp:include page="foot.jsp" flush="true"/>
  </body>
</html>
