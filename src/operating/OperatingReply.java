package operating;

import java.sql.ResultSet;
import java.util.List;
import database.BBSDatabase;
import entity.Reply;
import entity.Topic;
import entity.User;
import tool.ToolReply;

public class OperatingReply {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// 插入一个评论
	public static boolean insertAReply(Reply reply) {
		reply = ToolReply.completionTopic(reply);
		int i = bbsDatabase.executeUpdate(ToolReply.entityToStringInsert(reply).toString());
		return i > 0;
	}

	// 删除一个评论
	public static boolean deleteAReply(Reply reply) {
		int i = bbsDatabase.executeUpdate("delete from reply where id='" + reply.getId() + "';");
		return i > 0;
	}

	// 修改一个评论
	public static boolean modifyAReply(Reply reply) {
		int i = bbsDatabase.executeUpdate(ToolReply.entityToStringModify(reply).toString());
		return i > 0;
	}
	
	// 修改点赞量+1
	public static boolean editReplySupportcount(Reply reply) {
		int i = bbsDatabase.executeUpdate("update reply set supportCount=supportCount+1  where id='" + reply.getId() + "';");
		return i > 0;
	}

	// 根据ID获取一个详细的评论信息
	public static Reply getAReplyById(Reply reply) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from reply where id='" + reply.getId() + "';");
		return ToolReply.resultSetToList(resultSet).get(0);
	}
	
	// 根据ID获取一个详细的评论信息
		public static Reply getAReplyById(int i) {
			ResultSet resultSet = bbsDatabase.executeQuery("select * from reply where id='" + i + "';");
			return ToolReply.resultSetToList(resultSet).get(0);
		}

	// 获取系统所有评论信息
	public static List<Reply> getAllReply() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from reply;");
		return ToolReply.resultSetToList(resultSet);
	}
	
	// 通过一个用户获取评论倒序
	public static List<Reply> getAllReplyByAUser(User user) {
		int i = user.getId();
		ResultSet resultSet = bbsDatabase.executeQuery("select * from reply where uId='"+ i +"' order by id desc;");
		return ToolReply.resultSetToList(resultSet);
	}
	//获取对应topic的reply
	public static List<Reply> getReplyByTopic(Topic topic) {
		int tId = topic.getId();
		ResultSet resultSet = bbsDatabase.executeQuery("select * from reply where tId=" + tId  +" order by supportCount desc, id desc");
		return ToolReply.resultSetToList(resultSet);
	}
}
