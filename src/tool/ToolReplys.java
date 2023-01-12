package tool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import entity.Replys;

public class ToolReplys {

	// 将实体类转化为String
	public static StringBuilder entityToStringInsert(Replys replys) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("insert into replys (replyid,uid,contents,time,supportCount) values(");
		stringBuilder.append("'" + replys.getReplyid() + "',");
		stringBuilder.append("'" + replys.getUid() + "',");
		stringBuilder.append("'" + replys.getContents() + "',");
		stringBuilder.append("'" + replys.getTime() + "',");
		stringBuilder.append("'" + replys.getSupportCount() + "'");
		stringBuilder.append(");");
		return stringBuilder;
	}

	// 将实体类转化为String
	public static StringBuilder entityToStringModify(Replys replys) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("update user set ");
		stringBuilder.append(" replyid='" + replys.getReplyid() + "',");
		stringBuilder.append(" uid='" + replys.getUid() + "',");
		stringBuilder.append(" contents='" + replys.getContents() + "',");
		stringBuilder.append(" where id='" + replys.getId() + "';");
		return stringBuilder;
	}

	// 把一个ResultSet转化为一个List<Replys>
	public static List<Replys> resultSetToList(ResultSet resultSet) {
		List<Replys> list = new ArrayList<Replys>();
		try {
			while (resultSet.next()) {
				Replys replys = new Replys();
				replys.setId(resultSet.getInt("id"));
				replys.setReplyid(resultSet.getInt("replyid"));
				replys.setUid(resultSet.getInt("uid"));
				replys.setContents(resultSet.getString("contents"));
				replys.setSupportCount(resultSet.getInt("supportCount"));
				String time = resultSet.getTimestamp("time").toString();
				time = time.substring(0,time.length()-2);
				replys.setTime(Timestamp.valueOf(time));
				list.add(replys);
			}
			resultSet.close();
		} catch (SQLException e) {
			System.err.println("把一个ResultSet转化为一个List<Replys>");
		}
		return list;
	}
}
