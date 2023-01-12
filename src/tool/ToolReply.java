package tool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import configuration.Configuration;
import entity.Reply;

public class ToolReply {

	// ʹ��Ĭ����Ϣ��ȫһ����Ϣ������������
	public static Reply completionTopic(Reply reply) {
		Reply reply2 = Configuration.getDefaultReply();
		reply.setContent(reply.getContent() == null ? reply2.getContent() : reply.getContent());
		reply.setTime(new Timestamp(System.currentTimeMillis()));
		return reply;
	}

	// ��ʵ����ת��ΪString
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

	// ��ʵ����ת��ΪString
	public static StringBuilder entityToStringModify(Reply reply) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("update user set ");
		stringBuilder.append(" tId='" + reply.gettId() + "',");
		stringBuilder.append(" uId='" + reply.getuId() + "',");
		stringBuilder.append(" content='" + reply.getContent() + "',");
		stringBuilder.append(" where id='" + reply.getId() + "';");
		return stringBuilder;
	}

	// ��һ��ResultSetת��Ϊһ��List<Reply>
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
			System.err.println("��һ��ResultSetת��Ϊһ��List<Reply>");
		}
		return list;
	}
}
