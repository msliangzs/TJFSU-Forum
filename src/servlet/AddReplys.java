package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Replys;
import entity.User;
import operating.OperatingReplys;

public class AddReplys extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddReplys() {
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
		doPost(request, response);
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
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		//设置编码格式
		response.setCharacterEncoding("utf-8");		//设置编码格式
		response.setContentType("text/html;charset=utf-8");		
		
		PrintWriter out = response.getWriter();		//获取输出流
		HttpSession session = request.getSession();		//获取session对象
		
		User user = (User)session.getAttribute("user");		//创建用户对象，用于判断
		int topicid = Integer.parseInt(request.getParameter("topicid"));		//帖子的id
		int replyid = Integer.parseInt(request.getParameter("replyid"));		//评论的id
		int uId = user.getId();		//回复人的id
		String contents = request.getParameter("contents");		//回复内容
		
		Replys replys = new Replys();
		replys.setReplyid(replyid);
		replys.setUid(uId);
		replys.setContents(contents);
		replys.setTime(new Timestamp(System.currentTimeMillis()));
		
		
		OperatingReplys.insertAReplys(replys);		//插入replys
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/topic.jsp?id=" + topicid).forward(request, response);	

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
