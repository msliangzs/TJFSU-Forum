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

public class CheckRegister extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CheckRegister() {
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
		
		request.setCharacterEncoding("GBK");		//设置编码格式
		response.setCharacterEncoding("GBK");		//设置编码格式
		
		response.setContentType("text/html;charset=utf-8");		
		
		User user=new User();		//创建用户对象，用于保存
		PrintWriter out = response.getWriter();		//获取输出流
		HttpSession session = request.getSession();		//获取session对象
		
		String account = request.getParameter("account");	//获取用户输入的用户名
		String password = request.getParameter("password");	//获取用户输入的密码
		String vcod = request.getParameter("vcode");		//获取用户输入验证码
		
		user.setAccount(account);
		user.setPassword(password);
		
		String vcode1 = (String)session.getAttribute("vcode");		//获取后台生成验证码
		
		if (vcod.equals(vcode1) == false) {	//判断验证码是否正确
			session.setAttribute("error",	"验证码不正确");
			request.setAttribute("lastpage", "register.jsp");
			
			response.sendRedirect(request.getContextPath()+"/error.jsp");  
            return;  
			
			//response.getWriter().print("forward:<br />");
			//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		}
		
		if (OperatingUser.verificationAUserName(user)) {		//检测用户名是否存在
			session.setAttribute("error",	"用户名已经存在");
			request.setAttribute("lastpage", "register.jsp");
			
			response.getWriter().print("forward:<br />");
			getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		} else {		//插入用户
			OperatingUser.insertAUser(user);		//插入用户
			User user2 = OperatingUser.getAUser(user);		//获取用户全部信息
			
			session.setAttribute("user", user2);		//传递用户对象
			
			response.getWriter().print("forward:<br />");		//跳转到主页面
			getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		}
		
		out.flush();
		out.close();
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
		// Put your code here
	}

}
