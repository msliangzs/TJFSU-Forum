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
		
		request.setCharacterEncoding("GBK");		//设置编码格式
		response.setCharacterEncoding("GBK");		//设置编码格式
		
		response.setContentType("text/html;charset=utf-8");		
		
		User user=new User();		//创建用户对象，用于保存
		PrintWriter out = response.getWriter();		//获取输出流
		HttpSession session = request.getSession();		//获取session对象
		
		String account = request.getParameter("account");	//获取用户输入的用户名
		String password = request.getParameter("password");	//获取用户输入的密码
		
		user.setAccount(account);
		user.setPassword(password);
		
		if (OperatingUser.verificationAUserName(user)) {		//检测用户名是否存在
			session.setAttribute("error",	"用户名已经存在");
			request.setAttribute("lastpage", "yonghuguanli.jsp");
			
			response.getWriter().print("forward:<br />");
			getServletConfig().getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
		} else {		//插入用户
			OperatingUser.insertAUser(user);		//插入用户
			
			response.getWriter().print("forward:<br />");		//跳转到主页面
			getServletConfig().getServletContext().getRequestDispatcher("/yonghuguanli.jsp").forward(request, response);
		}
		
		out.flush();
		out.close();
	}

}
