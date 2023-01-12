package operating;

import java.sql.ResultSet;
import java.util.List;
import database.BBSDatabase;
import entity.User;
import tool.ToolUser;

public class OperatingUser {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// 插入一个用户
	public static boolean insertAUser(User user) {
		user = ToolUser.completionUser(user);
		int i = bbsDatabase.executeUpdate(ToolUser.entityToStringInsert(user).toString());
		return i > 0;
	}

	// 根据ID删除一个用户
	public static boolean deleteAUserById(User user) {
		int i = bbsDatabase.executeUpdate("delete from user where id='" + user.getId() + "';");
		return i > 0;
	}
	
	// 根据Account删除一个用户
	public static boolean deleteAUserByAccount(User user) {
		int i = bbsDatabase.executeUpdate("delete form user where account='" + user.getAccount() + "';");
		return i > 0;
	}

	// 修改一个用户
	public static boolean modifyAUser(User user) {
		int i = bbsDatabase.executeUpdate(ToolUser.entityToStringModify(user).toString());
		return i > 0;
	}

	// 判断一个用户名是否存在
	public static boolean verificationAUserName(User user) {
		User user2 = new User();
		user2.setAccount(user.getAccount());
		return getAUser(user2).getId() != 0;
	}

	// 验证一个用户的信息是否正确
	public static boolean verificationAUser(User user) {
		if (verificationAUserName(user)) {
			return getAUser(user).getPassword().equals(user.getPassword());
		}
		return false;
	}

	// 根据一个简单的用户信息获取一个详细的用户信息
	public static User getAUser(User user) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user where account='" + user.getAccount() + "';");
		List<User> list = ToolUser.resultSetToList(resultSet);
		return list.isEmpty() ? user : list.get(0);
	}
	
	// 根据用户id获取一个详细的用户信息
	public static User getAUserById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user where id=" + i + ";");
		return ToolUser.resultSetToList(resultSet).get(0);
	}
	
	// 获取系统所有用户信息
	public static List<User> getAllUser() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from user;");
		return ToolUser.resultSetToList(resultSet);
	}

}
