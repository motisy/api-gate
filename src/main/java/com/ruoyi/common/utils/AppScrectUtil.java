package com.ruoyi.common.utils;

import java.util.UUID;

public class AppScrectUtil {
	
	public final static String SCRECT_KEY = "www.lgjtgs.com";
	
	public static String guid() {  
		UUID uuid = UUID.randomUUID();  
		String key = uuid.toString();  
		return key;  
	}  
	
	public static String createAppKey() {  
		String guid = guid();  
		return guid;  
	}
	
	public static String createAppScrect(String appKey) {  
		String app_sign = null;
		try {
			app_sign = MyMD5Util.md5(appKey, SCRECT_KEY);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return app_sign;  
	} 
	
	public static boolean verify(String appKey, String appScrect) {
		String md5str = "";
		try {
			md5str = MyMD5Util.md5(appKey, SCRECT_KEY);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (md5str.equalsIgnoreCase(appScrect)) {
//			System.out.println("MD5验证通过");
			return true;
		}
		return false;
	}
	
	public static void main(String[] args) {
		String k = createAppKey();
		String v = createAppScrect(k);
		System.out.println(k);
		System.out.println(v);
		
		System.out.println(verify(k, v));
	}
}
