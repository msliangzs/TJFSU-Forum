package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Notice;
import operating.OperatingNotice;
import tool.DateUtils;

public class AddNotice extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public AddNotice() {
		super();
	}
	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		//设置编码格式
		response.setCharacterEncoding("utf-8");		//设置编码格式
		response.setContentType("text/html;charset=utf-8");		
		
		PrintWriter out = response.getWriter();		//获取输出流
		
		String content = request.getParameter("content");		//公告通知内容
		Notice notice = new Notice();
		notice.setContent(content);
		notice.setCreatedate(DateUtils.getCurDateStr());
		
		OperatingNotice.insertANotice(notice);		
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/notice.jsp").forward(request, response);	

		out.flush();
		out.close();
	}

}
