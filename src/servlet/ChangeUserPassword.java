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

public class ChangeUserPassword extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ChangeUserPassword() {
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
		
		int uId = Integer.parseInt(request.getParameter("uId"));		//获取用户id 
		String password = request.getParameter("password");		//获取用户密码
		String password2 = request.getParameter("password2");		//获取更改后的用户密码
		
		HttpSession session = request.getSession();		//获取session对象
		PrintWriter out = response.getWriter();
		
		User user1 = OperatingUser.getAUserById(uId);	//获取需要更改的对象
		user1.setPassword(password);
		
		if (OperatingUser.verificationAUser(user1)) {		//密码是否则正确
			user1.setPassword(password2);
			
			OperatingUser.modifyAUser(user1);		//更新
			session.setAttribute("user", user1);
			
			response.getWriter().print("forward:<br />");		//跳转
			getServletConfig().getServletContext().getRequestDispatcher("/usermessage3.jsp?uId=" + uId).forward(request, response);
		} else {
			session.setAttribute("error",	"输入密码不正确");
			request.setAttribute("lastpage", "usermessage3.jsp?uId=" + uId);
			
			response.getWriter().print("forward:<br />");		//跳转
			getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
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
