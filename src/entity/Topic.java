package entity;

import java.sql.Timestamp;

//话题实体
public class Topic {
	private int id, sId, uId, replyCount, flag, clickCount,supportCount;
	private String topic, contents;
	private Timestamp time;

	public Topic() {

	}

	public Topic(int id, int sId, int uId, int replyCount, int flag, int clickCount, int supportCount, String topic,
			String contents, Timestamp time) {
		super();
		this.id = id;
		this.sId = sId;
		this.uId = uId;
		this.replyCount = replyCount;
		this.flag = flag;
		this.clickCount = clickCount;
		this.supportCount = supportCount;
		this.topic = topic;
		this.contents = contents;
		this.time = time;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getsId() {
		return sId;
	}

	public void setsId(int sId) {
		this.sId = sId;
	}

	public int getuId() {
		return uId;
	}

	public void setuId(int uId) {
		this.uId = uId;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public int getClickCount() {
		return clickCount;
	}

	public void setClickCount(int clickCount) {
		this.clickCount = clickCount;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public int getSupportCount() {
		return supportCount;
	}

	public void setSupportCount(int supportCount) {
		this.supportCount = supportCount;
	}
	
	

}
