package operating;

import java.sql.ResultSet;
import java.util.List;
import database.BBSDatabase;
import entity.User;
import tool.ToolUser;

public class OperatingUser {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// ����һ���û�
	public static boolean insertAUser(User user) {
		user = ToolUser.completionUser(user);
		int i = bbsDatabase.executeUpdate(ToolUser.entityToStringInsert(user).toString());
		return i > 0;
	}

	// ����IDɾ��һ���û�
	public static boolean deleteAUserById(User user) {
		int i = bbsDatabase.executeUpdate("delete from user where id='" + user.getId() + "';");
		return i > 0;
	}
	
	// ����Accountɾ��һ���û�
	public static boolean deleteAUserByAccount(User user) {
		int i = bbsDatabase.executeUpdate("delete form user where account='" + user.getAccount() + "';");
		return i > 0;
	}

	// �޸�һ���û�
	public static boolean modifyAUser(User user) {
		int i = bbsDatabase.executeUpdate(ToolUser.entityToStringModify(user).toString());
		return i > 0;
	}

	// �ж�һ���û����Ƿ����
	public static boolean verificationAUserName(User user) {
		User user2 = new User();
		user2.setAccount(user.getAccount());
		return getAUser(user2).getId() != 0;
	}

	// ��֤һ���û�����Ϣ�Ƿ���ȷ
	public static boolean verificationAUser(User user) {
		if (verificationAUserName(user)) {
			return getAUser(user).getPassword().equals(user.getPassword());
		}
		return false;
	}

	// ����һ���򵥵��û���Ϣ��ȡһ����ϸ���û���Ϣ
	public static User getAUser(User user) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user where account='" + user.getAccount() + "';");
		List<User> list = ToolUser.resultSetToList(resultSet);
		return list.isEmpty() ? user : list.get(0);
	}
	
	// �����û�id��ȡһ����ϸ���û���Ϣ
	public static User getAUserById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user where id=" + i + ";");
		return ToolUser.resultSetToList(resultSet).get(0);
	}
	
	// ��ȡϵͳ�����û���Ϣ
	public static List<User> getAllUser() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user;");
		return ToolUser.resultSetToList(resultSet);
	}

}
