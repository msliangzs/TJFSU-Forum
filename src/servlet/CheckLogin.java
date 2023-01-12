package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import operating.OperatingUser;
import entity.User;

public class CheckLogin extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CheckLogin() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doDelete method of the servlet. <br>
	 *
	 * This method is called when a HTTP delete request is received.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		//设置编码格式
		response.setCharacterEncoding("utf-8");		//设置编码格式
		response.setContentType("text/html;charset=utf-8");		
		
		User user=new User();		//创建用户对象，用于判断
		PrintWriter out = response.getWriter();		//获取输出流
		HttpSession session = request.getSession();		//获取session对象
		
		String account = request.getParameter("account");	//获取用户输入的用户名
		String password = request.getParameter("password");	//获取用户输入的密码
		String vcod = request.getParameter("vcode");		//获取用户输入验证码
		
		user.setAccount(account);
		user.setPassword(password);
		
		String vcode1 = (String)session.getAttribute("vcode");		//获取后台生成验证码
		//System.out.print(vcod.equals(vcode1));
		
		if (vcod.equals(vcode1) == false) {	//判断验证码是否正确
			session.setAttribute("error",	"验证码不正确");
			request.setAttribute("lastpage", "login.jsp");
			
			response.sendRedirect(request.getContextPath()+"/error.jsp");  
            return;  
            
			//response.getWriter().print("forward:<br />");
			//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
			//response.sendRedirect("error.jsp");
		}
		
		if (OperatingUser.verificationAUserName(user)) {		//判断用户名是否存在
			if (OperatingUser.verificationAUser(user)) {		//密码是否则正确			
				// 根据一个简单的用户信息获取一个详细的用户信息
				User user2 = OperatingUser.getAUser(user);
				session.setAttribute("user", user2);		//传递用户对象
				
				if (user2.getGrade() > 1) {	//管理员权限
					response.sendRedirect(request.getContextPath()+"/index.jsp");  
		            return;  

					//response.getWriter().print("forward:<br />");
					//getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				} else if (user2.getGrade() == 1) {
					response.sendRedirect(request.getContextPath()+"/index.jsp");  
		            return;  
					
					//response.getWriter().print("forward:<br />");
					//getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				} else {
					session.setAttribute("error",	"账户异常，请联系管理员");
					request.setAttribute("lastpage", "welcome.jsp");
					
					response.sendRedirect(request.getContextPath()+"/error.jsp");  
		            return;  
					
					//response.getWriter().print("forward:<br />");
					//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
				}
				
			} else {
				session.setAttribute("error",	"密码不正确");
				request.setAttribute("lastpage", "login.jsp");
				
				response.sendRedirect(request.getContextPath()+"/error.jsp");  
	            return;  
				
				//response.getWriter().print("forward:<br />");
				//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
				//response.sendRedirect("http://localhost:8080/校园论坛/error.jsp");
			}
		} else {
			session.setAttribute("error",	"用户名不存在");
			request.setAttribute("lastpage", "login.jsp");
			
			response.sendRedirect(request.getContextPath()+"/error.jsp");  
            return;  
            
			//response.getWriter().print("forward:<br />");
			//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
			//response.sendRedirect("http://localhost:8080/校园论坛/error.jsp");
		}
	}

	/**
	 * The doPut method of the servlet. <br>
	 *
	 * This method is called when a HTTP put request is received.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Put your code here
	}

	/**
	 * Returns information about the servlet, such as 
	 * author, version, and copyright. 
	 *
	 * @return String information about this servlet
	 */
	public String getServletInfo() {
		return "This is my default servlet created by Eclipse";
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		super.init();
		// Put your code here
	}

}
