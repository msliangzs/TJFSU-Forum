package operating;

import java.sql.ResultSet;
import java.util.List;

import database.BBSDatabase;
import entity.Reply;
import entity.Replys;
import entity.User;
import tool.ToolReplys;

public class OperatingReplys {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// ����һ���ظ�
	public static boolean insertAReplys(Replys replys) {
		int i = bbsDatabase.executeUpdate(ToolReplys.entityToStringInsert(replys).toString());
		return i > 0;
	}

	// ɾ��һ���ظ�
	public static boolean deleteAReplys(Replys replys) {
		int i = bbsDatabase.executeUpdate("delete from replys where id='" + replys.getId() + "';");
		return i > 0;
	}
	
	// �޸ĵ�����+1
	public static boolean editReplySupportcount(Replys replys) {
		int i = bbsDatabase.executeUpdate("update replys set supportCount=supportCount+1  where id='" + replys.getId() + "';");
		return i > 0;
	}

	// �޸�һ���ظ�
	public static boolean modifyAReplys(Replys replys) {
		int i = bbsDatabase.executeUpdate(ToolReplys.entityToStringModify(replys).toString());
		return i > 0;
	}

	// ����ID��ȡһ����ϸ�Ļظ���Ϣ
	public static Replys getAReplysById(Replys replys) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from replys where id='" + replys.getId() + "';");
		return ToolReplys.resultSetToList(resultSet).get(0);
	}
	
	// ����ID��ȡһ����ϸ�Ļظ���Ϣ
		public static Replys getAReplysById(int i) {
			ResultSet resultSet = bbsDatabase.executeQuery("select * from replys where id='" + i + "';");
			return ToolReplys.resultSetToList(resultSet).get(0);
		}

	// ��ȡϵͳ���лظ���Ϣ
	public static List<Replys> getAllReplys() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from replys;");
		return ToolReplys.resultSetToList(resultSet);
	}
	
	// ͨ��һ���û���ȡ�ظ�����
	public static List<Replys> getAllReplysByAUser(User user) {
		int i = user.getId();
		ResultSet resultSet = bbsDatabase.executeQuery("select * from replys where uId='"+ i +"' order by id desc;");
		return ToolReplys.resultSetToList(resultSet);
	}
	//��ȡ��Ӧtopic��replys
	public static List<Replys> getReplysByReply(Reply reply) {
		int replyid = reply.getId();
		ResultSet resultSet = bbsDatabase.executeQuery("select * from replys where replyid=" + replyid  +" order by supportCount desc, id desc;");
		return ToolReplys.resultSetToList(resultSet);
	}
}
