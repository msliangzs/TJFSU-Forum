<%@page import="entity.*"%>
<%@page import="operating.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

User user = OperatingUser.getAUserById(1);	//默认用户，防止没有notice对象传入时候出现问题
try {
	user = (User)session.getAttribute("user");		//获取notice对象
} catch (Exception e) {
	session.setAttribute("error", "用户登陆错误");
	session.setAttribute("lastpage", "login.jsp");
	
	response.sendRedirect("error.jsp");
}

List<Notice> noticelist = OperatingNotice.getAllNotice();
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
			var content = document.getElementById("content").value;	//记录公告通知内容
			if (!content) {
				alert("请输入公告通知内容");
				return false;
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
	   <div class="div-main-head1 div-title">公告通知信息</div>
	   <div class="div-main-body">
		<table>
	      <tr>
	        <td>公告通知ID</td>
	        <td>公告通知内容</td>
	        <td>发布时间</td>
            <td>操作</td>
	      </tr>
	      <%
	      	for (Notice noticetemp : noticelist) {
	      
	      %>
	      		<tr>
			        <td><%=noticetemp.getId() %></td>
			        <td><%=noticetemp.getContent() %></td>
			        <td><%=noticetemp.getCreatedate() %></td>
                    <td><a href="DeleteNotice?sId=<%=noticetemp.getId()%>">删除</a></td>
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
		<div class="div-main-head1 div-title">添加公告通知</div>
	   	<div class="div-main-body">
					<div class="sqy-setting">
						<form class="sqy-form" action="AddNotice" method="post" onSubmit="return checkSave()">
							<div class="sqy-form-group">
								<label class="sqy-col-md-2 sqy-control-label" for="profile">内容</label>
								<div class="sqy-col-md-5">
									<input class="sqy-form-control" id="content" name="content" type="text" />
								</div>
							</div>
							<div class="sqy-form-group">
								<div class="sqy-col-md-6">
									<button type="submit" class="sqy-div-btn sqy-btn-primary">添加公告通知</button>
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
