package operating;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.BBSDatabase;
import entity.Notice;

public class OperatingNotice {
	private static BBSDatabase bbsDatabase = BBSDatabase.getDatabase();

	// 添加
	public static boolean insertANotice(Notice notice) {
		int i = bbsDatabase.executeUpdate("insert into notice (content,createdate) values ('"+notice.getContent()+"','"+notice.getCreatedate()+"')");
		return i > 0;
	}

	// 删除
	public static boolean deleteANotice(Notice notice) {
		int i = bbsDatabase.executeUpdate("delete from notice where id='" + notice.getId() + "';");
		return i > 0;
	}

	//通过id值获取
	public static Notice getNoticeById(int i) {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from notice where id='" + i  +"';");
		List<Notice> list = new ArrayList<Notice>();
		try {
			while (resultSet.next()) {
				Notice notice = new Notice();
				notice.setId(resultSet.getInt("id"));
				notice.setContent(resultSet.getString("content"));
				notice.setCreatedate(resultSet.getString("createdate"));
				list.add(notice);
			}
			resultSet.close();
		} catch (SQLException e) {
		}
		return list.get(0);
	}
	
	// 获取所有
	public static List<Notice> getAllNotice() {
		ResultSet resultSet = bbsDatabase.executeQuery("select * from notice;");
		List<Notice> list = new ArrayList<Notice>();
		try {
			while (resultSet.next()) {
				Notice notice = new Notice();
				notice.setId(resultSet.getInt("id"));
				notice.setContent(resultSet.getString("content"));
				notice.setCreatedate(resultSet.getString("createdate"));
				list.add(notice);
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
