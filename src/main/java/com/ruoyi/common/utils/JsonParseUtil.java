package com.ruoyi.common.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class JsonParseUtil {
	
	/**
	 * 对节点进行解析
	 */
	private static Object getObj(Object obj, String node) {
		try {
			if (node.contains("[")) {
				JSONArray arr = ((JSONObject)obj).getJSONArray(node.substring(0,node.indexOf("[")));
				for (int i = 0; i < arr.size(); i++) {
					String index = node.substring(node.indexOf("["),node.indexOf("]")).replace("[", "");
					if ((i + "").equals(index)) {
						Object o = arr.get(i);
						return o;
					}
				}
			} else {
				return ((JSONObject)obj).getJSONObject(node);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	/**
	 * 获取节点值
	 * @author mengfeiyang
	 * @param jsonContent
	 * @param jsonPath
	 * @return
	 * @throws Exception
	 */
	public static synchronized String getNodeValue(String jsonContent, String jsonPath) throws Exception {
		String[] nodes = jsonPath.split("\\.");
		Object obj = null;
		if(jsonContent.startsWith("[")) {
			obj = JSONArray.parseArray(jsonContent);
		}else{
			obj = JSONObject.parseObject(jsonContent);
		}

		for (int i = 1; i < nodes.length; i++) {
			if (obj != null) {
				if(nodes[0].contains("[") && nodes[0].contains("]") && obj instanceof JSONArray) {
					String indexStr = nodes[0].substring(nodes[0].indexOf("[")+1, nodes[0].indexOf("]"));
					Integer index = Integer.parseInt(indexStr);
					obj = ((JSONArray)obj).get(index);
				}
				if((i + 1) < nodes.length) {
					obj = getObj(obj, nodes[i]);
				}
			}

			if ((i + 1) == nodes.length) {
				try{
					return ((JSONObject)obj).getString(nodes[i]);
				}catch(Exception e){
					return "JSONException:"+e.getMessage()+",NodeString:"+obj.toString();
				}
			}
		}
		return null;
	}
	public static void main(String[] args) throws Exception {
        //构造json字符串
		String jsonContent = "{\"projectName\":[{\"name\":\"haha\"}],\"projectInfo\":{\"author\":\"test\",\"version\":1.0}}";
		String val = JsonParseUtil.getNodeValue(jsonContent, "JSON.projectName[0].name");
		System.out.println(val);//执行结果：test
	}
}

