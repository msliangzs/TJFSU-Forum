package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Timer;
import java.util.TimerTask;

import configuration.Configuration;

public class BBSDatabase {
	private static BBSDatabase database;
	private Connection connection;
	private Statement statement;

	private int time;
	private Timer timer;
	private TimerTask timerTask;

	private BBSDatabase() {
		this.autoControl();
	}

	// 自动控制方法
	private void autoControl() {
		if (this.time > 0) {
			this.time = Configuration.connectionSecond1;
			return;
		}
		this.connection = this.getConnection(Configuration.databaseHostName, Configuration.databaseName, Configuration.databaseUserName,
				Configuration.databaseUserPassword);
		if (this.connection == null) {
			return;
		}
		this.statement = this.getStatement(this.connection);
		this.time = Configuration.connectionSecond1;
		this.timer = new Timer();
		this.timerTask = new TimerTask() {

			@Override
			public void run() {
				if (--time <= 0) {
					BBSDatabase.database.closeDatabase();
					timerTask.cancel();
					timer.cancel();
					timerTask = null;
					timer = null;
				}
			}
		};
		timer.schedule(timerTask, 0, 1000);
	}

	private Connection getConnection(String hostName, String databaseName, String userName, String password) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://" + hostName + "/" + databaseName+"?useUnicode=true&characterEncoding=utf-8&useSSL=false", userName, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private Statement getStatement(Connection connection) {
		try {
			return connection.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private void closeDatabase() {
		try {
			this.statement.close();
			this.connection.close();
			this.statement = null;
			this.connection = null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static synchronized BBSDatabase getDatabase() {
		if (database == null) {
			BBSDatabase.database = new BBSDatabase();
		}
		return database;
	}

	public ResultSet executeQuery(String sql) {
		this.autoControl();
		try {
			return this.statement.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int executeUpdate(String sql) {
		this.autoControl();
		try {
			return this.statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public String toString() {
		return "这是：" + Configuration.databaseChineseName;
	}

}
