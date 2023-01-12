package tool;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	/**
	 * 获取当前时间的字符串
	 * @return
	 */
	public static String getCurDateStr() {
		SimpleDateFormat sf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
		return sf.format(new Date());
	}
}
