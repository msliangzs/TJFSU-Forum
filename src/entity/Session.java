package entity;

// 分类实体
public class Session {
	private String name, profile;
	private int id, masterId, topicCount, clickCount;

	public Session() {

	}

	public Session(int id, int masterId, String name, String profile, int topicCount, int clickCount) {
		super();
		this.id = id;
		this.masterId = masterId;
		this.name = name;
		this.profile = profile;
		this.topicCount = topicCount;
		this.clickCount = clickCount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMasterId() {
		return masterId;
	}

	public void setMasterId(int masterId) {
		this.masterId = masterId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getTopicCount() {
		return topicCount;
	}

	public void setTopicCount(int topicCount) {
		this.topicCount = topicCount;
	}

	public int getClickCount() {
		return clickCount;
	}

	public void setClickCount(int clickCount) {
		this.clickCount = clickCount;
	}

	@Override
	public String toString() {
		return "Session [id=" + id + ", masterId=" + masterId + ", name=" + name + ", topicCount=" + topicCount
				+ ", clickCount=" + clickCount + "]";
	}

}
