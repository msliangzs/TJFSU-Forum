package configuration;

import java.sql.Timestamp;

import entity.Reply;
import entity.Session;
import entity.Topic;
import entity.User;

public class Configuration {

	/////////////////// У԰��̳���ݿ����ÿ�ʼ////////////////////////////
	public static String databaseChineseName = "У԰��̳���ݿ�";
	public static String databaseHostName = "localhost";
	public static String databaseName = "schoolbbs";
	public static String databaseUserName = "root";
	public static String databaseUserPassword = "12345678";
	public static int connectionSecond1 = 60;
	/////////////////// У԰��̳���ݿ����ý���////////////////////////////

	/////////////////// Ĭ��User��Ϣ���ÿ�ʼ////////////////////////////
	private static int userId;
	private static String userAccount = "account";
	private static String userPassword = "12345678";
	private static String userNickname = "nickname";
	private static String userEmail = "";
	private static String userPhoto = "img/UserPhoto/default.jpg";
	private static String userSex = "Ů";
	private static int userGrade;
	private static Timestamp userRegistrationdate;

	// ��ȡһ��Ĭ��������Ϣ��User
	public static User getDefaultUser() {
		User user = new User();
		user.setId(userId);
		user.setAccount(userAccount);
		user.setPassword(userPassword);
		user.setNickname(userNickname);
		user.setEmail(userEmail);
		user.setPhoto(userPhoto);
		user.setSex(userSex);
		user.setGrade(userGrade);
		user.setRegistrationdate(userRegistrationdate);
		return user;
	}
	/////////////////// Ĭ��User��Ϣ���ý���////////////////////////////

	/////////////////// Ĭ��Session��Ϣ���ÿ�ʼ////////////////////////////
	private static String sessionName = "";
	private static String sessionProfile = "";
	private static int sessionId;
	private static int sessionMasterId;
	private static int sessionTopicCount;
	private static int sessionClickCount;

	// ��ȡһ��Ĭ��������Ϣ��Session
	public static Session getDefaultSession() {
		Session session = new Session();
		session.setId(sessionId);
		session.setName(sessionName);
		session.setProfile(sessionProfile);
		session.setMasterId(sessionMasterId);
		session.setTopicCount(sessionTopicCount);
		session.setClickCount(sessionClickCount);
		return session;
	}
	/////////////////// Ĭ��Session��Ϣ���ý���////////////////////////////

	/////////////////// Ĭ��Topic��Ϣ���ÿ�ʼ////////////////////////////
	private static String topic = "";
	private static String topicContents = "";
	private static int topicId;
	private static int topicSId;
	private static int topicUId;
	private static int topicReplyCount;
	private static int topicFlag;
	private static int topicClickCount;
	private static Timestamp topicTime;

	// ��ȡһ��Ĭ��������Ϣ��Topic
	public static Topic getDefaultTopic() {
		Topic topic = new Topic();
		topic.setTopic(Configuration.topic);
		topic.setContents(topicContents);
		topic.setId(topicId);
		topic.setsId(topicSId);
		topic.setuId(topicUId);
		topic.setReplyCount(topicReplyCount);
		topic.setFlag(topicFlag);
		topic.setClickCount(topicClickCount);
		topic.setTime(topicTime);
		return topic;
	}
	/////////////////// Ĭ��Topic��Ϣ���ý���////////////////////////////

	/////////////////// Ĭ��Reply��Ϣ���ÿ�ʼ////////////////////////////
	private static String replyContent = "";
	private static int replyId;
	private static int replyTId;
	private static int replyUId;
	private static Timestamp replyTime;

	// ��ȡһ��Ĭ��������Ϣ��Reply
	public static Reply getDefaultReply() {
		Reply reply = new Reply();
		reply.setId(replyId);
		reply.settId(replyTId);
		reply.setuId(replyUId);
		reply.setTime(replyTime);
		reply.setContent(replyContent);
		return reply;
	}
	/////////////////// Ĭ��Reply��Ϣ���ý���////////////////////////////

}
