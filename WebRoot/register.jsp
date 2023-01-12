<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>TJFSU校园论坛|注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="校园论坛,BBS,论坛">
	<meta http-equiv="description" content="This is my page">
	<link rel="shortcut icon" href="img/logo.png" /> 
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/login-register.css" />
    <style>
		p.p-landr-tipmessage {	/*提示消息*/
			margin: 0px auto;
			color: #F00;
			font-size: 15px;
			position: relative; top: 10px;
		}
	</style>
	<!-- 表单验证js -->
    <script type="text/javascript">
		function checkregister() {	
			var account = document.getElementById("register-account").value;	//记录用户名
			var password = document.getElementById("register-password").value;		//记录密码
			var password1 = document.getElementById("register-password1").value;	//记录再次验证的密码
			var vcode = document.getElementById("register-vcode").value;	//记录验证码
			
			var message = document.getElementById("tipmessage");
			
			var caccount = /^[a-zA-Z][a-zA-Z0-9]{4,20}$/;	//英文字母和数字组成的4-16位字符,以字母开头,允许纯英文
			var cpassword = /^(?![\d]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[\da-zA-Z!#$%^&*]{6,20}$/;		//6-20位字符；数字、字母、特殊字符（除空格）,特殊字符的范围为 !#$%^&*
			
          	if(account == null || account == '') {
				alert("请输入用户名!");
				return false;    		            
           	} else {
           		if(password == null || password == '') {
           			alert("请输入登录密码!");
           			return false;	                
         		} else {
         			if (password1 == null || password1 == '') {
         				alert("请输入确认密码!");
           				return false;
         			} else {
         				if (password1 != password) {
         					alert("两次密码不相同!");
           					return false;
         				} else {
         					if(vcode == null || vcode == '') {
			         			alert("请输入验证码!");
			         			return false;
							} else {
								return true;
							}
         				}
         			}
         		}
           	}
        };
    </script>
    <!-- 表单验证js -->
  </head>
  
  <body class="registerbgclass">
    <!--菜单层 start-->
	<div class="index-div-menu">
	    <div class="index-div-menu1"> <!--菜单栏-->
	        <div class="index-div-ulmain">
	            <ul id="index-ul-mainNav">
	                <li> <a class="index-a-logo" href="#">TJFSU校园论坛</a> </li>
	                <li> <a href="#">首页</a> </li>
	                <li> <a href="#">分类</a> </li>
	                <li> <a href="#">发表</a> </li>
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
    
    <!--注册 start-->
    <div class="div-container">		 <!--container 框架-->
        <div class="div-loginandregister-adiv">
            <a id="a-header1" href="login.jsp" >登录</a>           
            <a id="a-header">注册</a>
        </div>
        <form method="post" action="CheckRegister" onSubmit="return checkregister()">
        <div class="div-loginandregister-main">
            
            <div class="div-logininandregister-inputmain">		<!--用户名-->
                <label id="loginlable1">用户名</label>
                <input name="account" id="register-account" type="text" placeholder="英文字母和数字组成的4-16位字符,以字母开头，允许纯英" />
            </div>
            
            <div class="div-logininandregister-inputmain" >		<!--密码-->
                <label id="loginlable1">密码</label>                
                <input name="password" id="register-password" type="password" placeholder="6-20位英、数字、符号组合，区分大小写" />
            </div>
            
            <div class="div-logininandregister-inputmain" >		<!--确认密码-->
                <label id="loginlable1">确认密码</label>                
                <input name="password1" id="register-password1" type="password" placeholder="请再次输入密码" />
            </div>
            
            <div class="div-logininandregister-inputmain" >		<!--验证码-->
                <label id="loginlable1">验证码</label>
                <input name="vcode" id="register-vcode" width="80px" type="text" placeholder="点击图片刷新" />
               
                <a href="register.jsp"><img id="rc" src="GetCaptcha" title="看不清？单击换一张图片" alt="点击更换"/></a>
            </div>
           	
            <div class="div-loginin-submit">	<!--提交按钮-->
                <button id="div-loginin-submit1" type="submit" name="loginsubmit">注&nbsp;&nbsp;册</button>
            </div>
        
        </div>
        </form>
    </div>
    <!--注册 end--> 
    
  </body>
</html>
