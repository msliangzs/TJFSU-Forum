package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Reply;
import entity.Replys;
import entity.Topic;
import operating.OperatingReply;
import operating.OperatingReplys;
import operating.OperatingTopic;

/**
 * Servlet implementation class Userservlet
 */
@WebServlet("/supportcountservlet")
public class SupportCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportCountServlet() {
        super();
    }

    /**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//获取cmd参数，指定运行的方法
		String cmd=request.getParameter("cmd");
		if(cmd.equals("topic1")){
            this.topic1(request, response);
        }else if(cmd.equals("topic2")){
            this.topic2(request, response);
        }else if(cmd.equals("topic3")){
            this.topic3(request, response);
        }else if(cmd.equals("reply")){
            this.reply(request, response);
        }else if(cmd.equals("replys")){
            this.replys(request, response);
        }
	}
	
	
	
	private void topic1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Topic topic = new Topic();
		topic.setId(Integer.parseInt(request.getParameter("topicid")));
		OperatingTopic.editATopicSupportcount(topic);
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);	
	}
	
	private void topic2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Topic topic = new Topic();
		topic.setId(Integer.parseInt(request.getParameter("topicid")));
		OperatingTopic.editATopicSupportcount(topic);
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/article.jsp?sId="+request.getParameter("sId")).forward(request, response);	
	}
	
	private void topic3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Topic topic = new Topic();
		topic.setId(Integer.parseInt(request.getParameter("topicid")));
		OperatingTopic.editATopicSupportcount(topic);
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/topic.jsp?id="+topic.getId()).forward(request, response);	
	}
	
	private void reply(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Reply reply = new Reply();
		reply.setId(Integer.parseInt(request.getParameter("replyid")));
		OperatingReply.editReplySupportcount(reply);
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/topic.jsp?id="+request.getParameter("topicid")).forward(request, response);	
	}
	
	private void replys(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Replys replys = new Replys();
		replys.setId(Integer.parseInt(request.getParameter("replysid")));
		OperatingReplys.editReplySupportcount(replys);
		
		response.getWriter().print("forward:<br />");
		getServletConfig().getServletContext().getRequestDispatcher("/topic.jsp?id="+request.getParameter("topicid")).forward(request, response);	
	}
	
}