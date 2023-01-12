package tool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import entity.User;

public class ToolUser {

	// 使用默认信息补全一个信息不完整的用户
	public static User completionUser(User user) {
		User user2 = Configuration.getDefaultUser();
		user.setAccount(user.getAccount() == null ? user2.getAccount() : user.getAccount());
		user.setPassword(user.getPassword() == null ? user2.getPassword() : user.getPassword());
		user.setNickname(user.getNickname() == null ? user.getAccount() : user.getNickname());
		user.setEmail(user.getEmail() == null ? user2.getEmail() : user.getEmail());
		user.setPhoto("img/UserPhoto/8.jpg");
		user.setSex(user.getSex() == null ? user2.getSex() : user.getSex());
		user.setGrade(1);
		user.setEmail("123456@qq.com");
		user.setRegistrationdate(new Timestamp(System.currentTimeMillis()));
		return user;
	}

	// 将实体类转化为String
	public static StringBuilder entityToStringInsert(User user) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(
				"insert into user(account,password,nickName,email,photo,sex,grade,registrationdate) values(");
		stringBuilder.append("'" + user.getAccount() + "',");
		stringBuilder.append("'" + user.getPassword() + "',");
		stringBuilder.append("'" + user.getNickname() + "',");
		stringBuilder.append("'" + user.getEmail() + "',");
		stringBuilder.append("'" + user.getPhoto() + "',");
		stringBuilder.append("'" + user.getSex() + "',");
		stringBuilder.append("'" + user.getGrade() + "',");
		stringBuilder.append("'" + user.getRegistrationdate() + "'");
		stringBuilder.append(");");
		return stringBuilder;
	}

	// 将实体类转化为String
	public static StringBuilder entityToStringModify(User user) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("update user set ");
		stringBuilder.append(" password='" + user.getPassword() + "',");
		stringBuilder.append(" nickname='" + user.getNickname() + "',");
		stringBuilder.append(" email='" + user.getEmail() + "',");
		stringBuilder.append(" photo='" + user.getPhoto() + "',");
		stringBuilder.append(" sex='" + user.getSex() + "',");
		stringBuilder.append(" grade='" + user.getGrade() + "'");
		stringBuilder.append("where account='" + user.getAccount() + "';");
		return stringBuilder;
	}

	// 把一个ResultSet转化为一个List<User>
	public static List<User> resultSetToList(ResultSet resultSet) {
		List<User> list = new ArrayList<User>();
		try {
			while (resultSet.next()) {
				User user = new User();
				user.setId(resultSet.getInt("id"));
				user.setAccount(resultSet.getString("account"));
				user.setPassword(resultSet.getString("password"));
				user.setNickname(resultSet.getString("nickname"));
				user.setEmail(resultSet.getString("email"));
				user.setPhoto(resultSet.getString("photo"));
				user.setSex(resultSet.getString("sex"));
				user.setGrade(resultSet.getInt("grade"));
				user.setRegistrationdate(resultSet.getTimestamp("registrationdate"));
				list.add(user);
			}
			resultSet.close();
		} catch (SQLException e) {
		}
		return list;
	}

}
