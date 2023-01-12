package tool;

import java.util.Map;

import com.google.gson.Gson;

public class JSONUtils {
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	public static String getJsonStr(Map<String, Object> map) {
		Gson gson = new Gson();
		String datajson = gson.toJson(map);
		return datajson;
	}
}
