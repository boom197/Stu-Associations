package cn.util;

import java.io.Serializable;

public class ServerRespose<T> implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer code;
	private T data;

	public ServerRespose(){
		
	}
	
	public ServerRespose(Integer code, T data) {
		super();
		this.code = code;	
		this.data = data;
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	
	public T getData() {
		return data;
	}
	public void setData(T data) {
		this.data = data;
	}
	
	
}
