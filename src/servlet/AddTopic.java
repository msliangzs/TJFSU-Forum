package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Session;
import entity.Topic;
import entity.User;
import operating.OperatingSession;
import operating.OperatingTopic;

public class AddTopic extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddTopic() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); //
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
		request.setCharacterEncoding("utf-8");		//
		response.setCharacterEncoding("utf-8");		//
		response.setContentType("text/html;charset=utf-8");		
		PrintWriter out = response.getWriter();		//
		HttpSession session = request.getSession();		//
		User user = (User)session.getAttribute("user");		//
		
		String topic = request.getParameter("topic");		//
		String node_id = request.getParameter("node_id");		//
		int sId = Integer.parseInt(node_id);
		
		int uId = user.getId();		//
		String contents = request.getParameter("contents");		//
		
		Topic topic1 = new Topic();
		
		topic1.setsId(sId);
		topic1.setuId(uId);
		topic1.setReplyCount(0);
		topic1.setTopic(topic);
		topic1.setContents(contents);
		topic1.setTime(new Timestamp(System.currentTimeMillis()));
		topic1.setFlag(0);
		topic1.setClickCount(0);
		Session session2 = OperatingSession.getASessionByATopic(topic1);
		int topicCount = session2.getTopicCount();
		session2.setTopicCount(topicCount + 1);
		
		OperatingTopic.insertATopic(topic1);	//
		OperatingSession.modifyASession(session2);	
		
		response.getWriter().print("forward:<br />");		
		getServletConfig().getServletContext().getRequestDispatcher("/article.jsp?sId=" + sId).forward(request, response);	
		
		out.flush();
		out.close();
	}

}
