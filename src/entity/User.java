package entity;

import java.sql.Timestamp;

//用户实体
public class User {
	private String account, password, nickname, email, photo, sex;
	private int id, grade;
	private Timestamp registrationdate;

	public User() {

	}

	public User(int id, String account, String password, String nickname, String email, String photo, String sex,
			int grade, Timestamp registrationdate) {
		this.id = id;
		this.account = account;
		this.password = password;
		this.nickname = nickname;
		this.email = email;
		this.photo = photo;
		this.sex = sex;
		this.grade = grade;
		this.registrationdate = registrationdate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public Timestamp getRegistrationdate() {
		return registrationdate;
	}

	public void setRegistrationdate(Timestamp registrationdate) {
		this.registrationdate = registrationdate;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", account=" + account + ", nickname=" + nickname + ", email=" + email + ", sex="
				+ sex + ", registrationdate=" + registrationdate + "]";
	}

}
