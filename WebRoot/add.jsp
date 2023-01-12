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
	
	List<Session> list=OperatingSession.getAllSession();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>TJFSU校园论坛|发表主题</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="img/logo.png" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/login-register.css" />
<link rel="stylesheet" type="text/css" href="css/DYH.css" />
<script type="text/javascript" src="fckeditor/fckeditor.js"></script><!--FCKEditor-->
<script type="text/javascript"><!--FCKEditor-->
	window.onload = function()	{
		var sBasePath = "<%=basePath + "fckeditor/"%>";
		var oFCKeditor = new FCKeditor( 'contents' ) ;
		oFCKeditor.ToolbarSet = "DjDesign";		//自定义的ui
		oFCKeditor.Height = 300 ;
		oFCKeditor.BasePath	= sBasePath ;
		oFCKeditor.ReplaceTextarea() ;
	}
</script>
<script type="text/javascript">
	function checkadd() {	
		var topic = document.getElementById("topic").value;		//记录帖子标题
		var	 node_id = document.getElementById("node_id").value;		//记录帖子所在分类id		

		if (topic == null || topic == '') {
			alert("请输入帖子标题");
			return false;		
		} else {
			if (node_id == -1) {
				alert("请选择帖子所在分类");
				return false;
			} else {
			}
		}
	};
</script>
<body>
<div>
	<!--菜单层 start-->
	<jsp:include page="head.jsp" flush="true"/>
	<!--菜单层 end-->

<!--中层框架 start-->
<div class="div-content"> 
    <!--中层框架左边 start-->
    <div class="div-contentleft">
        <div class="div-main"> <!-- 发表主题框架 -->
            <div class="div-main-head1">发表帖子</div>
            <div class="div-main-body">
                <form action="AddTopic" method="post" onSubmit="return checkadd()">
                    <div class="add-form-group">
                        <label>帖子标题</label>
                        <input class="add-form-control" id="topic" name="topic"  type="text" />                        
                    </div>
                    <div class="add-form-group">
                        <label>分类所在分类</label>
                        <select name="node_id" id="node_id" class="add-form-control" >
                            <option selected="selected" value="-1">请选择分类</option>
                            <optgroup label="&nbsp;&nbsp;话题列表">
                            <% 
                            for(int i=0;i<list.size();i++){
                    			Session session2 = list.get(i);
                         
                            %>
                            <option value="<%=session2.getId()%>"> <%=session2.getName() %> </option>
                            <%
                            }
                            %>
                            </optgroup>
                        </select>
                    </div>
                    <div class="add-form-group">
                        <label>内容</label>
                        <textarea class="add-form-control" id="contents" name="contents"  rows="10" ></textarea>
                    </div>
                    <button type="submit" >创建</button>
                </form>
            </div>
        </div>
    </div>
    <!--中层框架左边 end--> 
    
    <!--中层框架右边 start-->
    <jsp:include page="left.jsp" flush="true"/>
    <!--中层框架右边 end--> 
	<!--中层框架 end--> 
	</div>
	<!--底部	-->
	<jsp:include page="foot.jsp" flush="true"/>	
</div>
</body>
</html>
