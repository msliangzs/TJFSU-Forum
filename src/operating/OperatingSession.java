package operating;

import java.sql.ResultSet;
import java.util.List;
import database.BBSDatabase;
import entity.Session;
import entity.Topic;
import tool.ToolSession;

public class OperatingSession {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// 插入一个会话
	public static boolean insertASession(Session session) {
		session = ToolSession.completionTopic(session);
		int i = bbsDatabase.executeUpdate(ToolSession.entityToStringInsert(session).toString());
		return i > 0;
	}

	// 删除一个会话
	public static boolean deleteASession(Session session) {
		int i = bbsDatabase.executeUpdate("delete from session where id='" + session.getId() + "';");
		return i > 0;
	}

	// 修改一个会话
	public static boolean modifyASession(Session session) {
		session = ToolSession.completionTopic(session);	//补全
		int i = bbsDatabase.executeUpdate(ToolSession.entityToStringModify(session).toString());
		return i > 0;
	}

	// 根据ID获取回话信息
	public static Session getASessionById(Session session) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + session.getId() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}

	//根据帖子获取Session
	public static Session getASessionByATopic(Topic topic) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + topic.getsId() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	public static Session getASessionByName(Session session) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where name ='" + session.getName() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	//通过id值获取session
	public static Session getSessionById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + i  +"';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	// 获取系统所有会话信息
	public static List<Session> getAllSession() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session;");
		return ToolSession.resultSetToList(resultSet);
	}
}
