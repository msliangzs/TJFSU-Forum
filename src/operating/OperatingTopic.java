package operating;

import java.sql.ResultSet;
import java.util.List;

import database.BBSDatabase;
import entity.Session;
import entity.Topic;
import entity.User;
import tool.ToolTopic;

public class OperatingTopic {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// ����һ������
	public static boolean insertATopic(Topic topic) {
		int i = bbsDatabase.executeUpdate(ToolTopic.entityToStringInsert(topic).toString());
		return i > 0;
	}

	// ɾ��һ������
	public static boolean deleteATopic(Topic topic) {
		int i = bbsDatabase.executeUpdate("delete from topic where id='" + topic.getId() + "';");
		return i > 0;
	}
	
	// �޸����ӷ�����+1
	public static boolean editATopicClickcount(Topic topic) {
		int i = bbsDatabase.executeUpdate("update topic set clickCount=clickCount+1  where id='" + topic.getId() + "';");
		return i > 0;
	}
	
	// �޸����ӵ�����+1
	public static boolean editATopicSupportcount(Topic topic) {
		int i = bbsDatabase.executeUpdate("update topic set supportCount=supportCount+1  where id='" + topic.getId() + "';");
		return i > 0;
	}

	// �޸�һ������
	public static boolean modifyATopic(Topic topic) {
		int i = bbsDatabase.executeUpdate(ToolTopic.entityToStringModify(topic).toString());
		return i > 0;
	}

	// ����ID��ѯ����
	public static Topic getATopicById(Topic topic) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from topic where id='" + topic.getId() + "';");
		return ToolTopic.resultSetToList(resultSet).get(0);
	}

	// ��ȡϵͳ���л�����Ϣ
	public static List<Topic> getAllTopic(String keywords,String orderdate,String orderclickcount) {
		String sql="select t1.* from topic t1 left join user t2 on t1.uId=t2.id where 1=1 ";
		if(keywords!=null && !keywords.equals("")) {
			sql+=" and (t1.topic like '%"+keywords+"%' or t2.nickName like '%"+keywords+"%') ";
		}
		if(orderdate!=null && !orderdate.equals("")) {
			sql+="order by t1.id desc;";
		}
		if(orderclickcount!=null && !orderclickcount.equals("")) {
			sql+="order by t1.clickCount desc;";
		}
		if(orderdate==null && orderclickcount==null) {
			sql+="order by t1.id desc;";
		}
		ResultSet resultSet = bbsDatabase.executeQuery(sql);	//����
		return ToolTopic.resultSetToList(resultSet);
	}
	
	// ͨ��idֵ��ȡtopic
	public static Topic getATopicById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from topic where id=" + i + ";");
		List<Topic> list = ToolTopic.resultSetToList(resultSet);
		return list.isEmpty() ? null : list.get(0);
	}
	
	// ͨ��һ���û���ȡtopic ����
	public static List<Topic> getAllTopicByAUser(User user) {
		int i = user.getId();
		ResultSet resultSet = bbsDatabase.executeQuery("select * from topic where uId='" + i + "' order by id desc;");
		return ToolTopic.resultSetToList(resultSet);
	}
	
	//��ȡ����id��Ϊi����������
	public static List<Topic> getTopicBySession(Session session,String keywords) {
		String sql ="select t1.* from topic t1 left join user t2 on t1.uId=t2.id where t1.sId="+session.getId()+" ";
		if(keywords!=null && !keywords.equals("")) {
			sql+=" and (t1.topic like '%"+keywords+"%' or t2.nickName like '%"+keywords+"%') ";
		}
		sql+="order by t1.id desc;";
		ResultSet resultSet = bbsDatabase.executeQuery(sql);
		return ToolTopic.resultSetToList(resultSet);
	}
	
	//���������ö�
	public static boolean setTopTopic(Topic topic) {
		topic =getATopicById(topic);
		topic.setFlag(1);
		return modifyATopic(topic);
	}
	
	//��������ȡ���ö�
	public static boolean cancelTopTopic(Topic topic) {
		topic =getATopicById(topic);
		topic.setFlag(0);
		return modifyATopic(topic);
	}
	
}
