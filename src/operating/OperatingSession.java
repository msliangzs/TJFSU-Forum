package operating;

import java.sql.ResultSet;
import java.util.List;
import database.BBSDatabase;
import entity.Session;
import entity.Topic;
import tool.ToolSession;

public class OperatingSession {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// ����һ���Ự
	public static boolean insertASession(Session session) {
		session = ToolSession.completionTopic(session);
		int i = bbsDatabase.executeUpdate(ToolSession.entityToStringInsert(session).toString());
		return i > 0;
	}

	// ɾ��һ���Ự
	public static boolean deleteASession(Session session) {
		int i = bbsDatabase.executeUpdate("delete from session where id='" + session.getId() + "';");
		return i > 0;
	}

	// �޸�һ���Ự
	public static boolean modifyASession(Session session) {
		session = ToolSession.completionTopic(session);	//��ȫ
		int i = bbsDatabase.executeUpdate(ToolSession.entityToStringModify(session).toString());
		return i > 0;
	}

	// ����ID��ȡ�ػ���Ϣ
	public static Session getASessionById(Session session) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + session.getId() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}

	//�������ӻ�ȡSession
	public static Session getASessionByATopic(Topic topic) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + topic.getsId() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	public static Session getASessionByName(Session session) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where name ='" + session.getName() + "';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	//ͨ��idֵ��ȡsession
	public static Session getSessionById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session where id='" + i  +"';");
		return ToolSession.resultSetToList(resultSet).get(0);
	}
	
	// ��ȡϵͳ���лỰ��Ϣ
	public static List<Session> getAllSession() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from session;");
		return ToolSession.resultSetToList(resultSet);
	}
}
