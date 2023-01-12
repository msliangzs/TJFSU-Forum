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
		
		request.setCharacterEncoding("GBK");		//���ñ����ʽ
		response.setCharacterEncoding("GBK");		//���ñ����ʽ
		
		response.setContentType("text/html;charset=utf-8");		
		
		User user=new User();		//�����û��������ڱ���
		PrintWriter out = response.getWriter();		//��ȡ�����
		HttpSession session = request.getSession();		//��ȡsession����
		
		String account = request.getParameter("account");	//��ȡ�û�������û���
		String password = request.getParameter("password");	//��ȡ�û����������
		String vcod = request.getParameter("vcode");		//��ȡ�û�������֤��
		
		user.setAccount(account);
		user.setPassword(password);
		
		String vcode1 = (String)session.getAttribute("vcode");		//��ȡ��̨������֤��
		
		if (vcod.equals(vcode1) == false) {	//�ж���֤���Ƿ���ȷ
			session.setAttribute("error",	"��֤�벻��ȷ");
			request.setAttribute("lastpage", "register.jsp");
			
			response.sendRedirect(request.getContextPath()+"/error.jsp");  
            return;  
			
			//response.getWriter().print("forward:<br />");
			//getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		}
		
		if (OperatingUser.verificationAUserName(user)) {		//����û����Ƿ����
			session.setAttribute("error",	"�û����Ѿ�����");
			request.setAttribute("lastpage", "register.jsp");
			
			response.getWriter().print("forward:<br />");
			getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		} else {		//�����û�
			OperatingUser.insertAUser(user);		//�����û�
			User user2 = OperatingUser.getAUser(user);		//��ȡ�û�ȫ����Ϣ
			
			session.setAttribute("user", user2);		//�����û�����
			
			response.getWriter().print("forward:<br />");		//��ת����ҳ��
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
