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

public class AddUser extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddUser() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); 
	}

	public void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

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
		
		user.setAccount(account);
		user.setPassword(password);
		
		if (OperatingUser.verificationAUserName(user)) {		//����û����Ƿ����
			session.setAttribute("error",	"�û����Ѿ�����");
			request.setAttribute("lastpage", "yonghuguanli.jsp");
			
			response.getWriter().print("forward:<br />");
			getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		} else {		//�����û�
			OperatingUser.insertAUser(user);		//�����û�
			
			response.getWriter().print("forward:<br />");		//��ת����ҳ��
			getServletConfig().getServletContext().getRequestDispatcher("/yonghuguanli.jsp").forward(request, response);
		}
		
		out.flush();
		out.close();
	}

}
