package tool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import entity.Reply;

public class ToolReply {

	// 使用默认信息补全一个信息不完整的评论
	public static Reply completionTopic(Reply reply) {
		Reply reply2 = Configuration.getDefaultReply();
		reply.setContent(reply.getContent() == null ? reply2.getContent() : reply.getContent());
		reply.setTime(new Timestamp(System.currentTimeMillis()));
		return reply;
	}

	// 将实体类转化为String
	public static StringBuilder entityToStringInsert(Reply reply) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("insert into reply (tId,uId,content,time,supportCount) values(");
		stringBuilder.append("'" + reply.gettId() + "',");
		stringBuilder.append("'" + reply.getuId() + "',");
		stringBuilder.append("'" + reply.getContent() + "',");
		stringBuilder.append("'" + reply.getTime() + "',");
		stringBuilder.append("'" + reply.getSupportCount() + "'");
		stringBuilder.append(");");
		return stringBuilder;
	}

	// 将实体类转化为String
	public static StringBuilder entityToStringModify(Reply reply) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("update user set ");
		stringBuilder.append(" tId='" + reply.gettId() + "',");
		stringBuilder.append(" uId='" + reply.getuId() + "',");
		stringBuilder.append(" content='" + reply.getContent() + "',");
		stringBuilder.append(" where id='" + reply.getId() + "';");
		return stringBuilder;
	}

	// 把一个ResultSet转化为一个List<Reply>
	public static List<Reply> resultSetToList(ResultSet resultSet) {
		List<Reply> list = new ArrayList<Reply>();
		try {
			while (resultSet.next()) {
				Reply reply = new Reply();
				reply.setId(resultSet.getInt("id"));
				reply.settId(resultSet.getInt("tId"));
				reply.setuId(resultSet.getInt("uId"));
				reply.setContent(resultSet.getString("content"));
				reply.setSupportCount(resultSet.getInt("supportCount"));
				String time = resultSet.getTimestamp("time").toString();
				time = time.substring(0,time.length()-2);
				reply.setTime(Timestamp.valueOf(time));
				list.add(reply);
			}
			resultSet.close();
		} catch (SQLException e) {
			System.err.println("把一个ResultSet转化为一个List<Reply>");
		}
		return list;
	}
}
