package cn.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Const {
   
    public static final String ROOT="/society/";

    public static String getCurrentTime(){
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	return sdf.format(new Date());
    }
    
    public static String getCurrentDay(){
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
    	return sdf.format(new Date());
    }
    public static String getFileId(){
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
    	return sdf.format(new Date());
    }
    public static String toUTF8(String content){
    	String str="";
    	try {
			str=new String(content.getBytes("iso-8859-1"),"UTF8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return str;
    }
}
