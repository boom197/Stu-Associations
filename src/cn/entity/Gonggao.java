package cn.entity;

import com.alibaba.fastjson.annotation.JSONField;

public class Gonggao implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer g_id;
	private String g_content;
	private String g_time;
	private String g_name;
	@JSONField(serialize = false)
	private Society society;
	public Integer getG_id() {
		return g_id;
	}
	public void setG_id(Integer gId) {
		g_id = gId;
	}
	public String getG_content() {
		return g_content;
	}
	public void setG_content(String gContent) {
		g_content = gContent;
	}
	public String getG_time() {
		return g_time;
	}
	public void setG_time(String gTime) {
		g_time = gTime;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String gName) {
		g_name = gName;
	}
	public Society getSociety() {
		return society;
	}
	public void setSociety(Society society) {
		this.society = society;
	}
	@Override
	public String toString() {
		return "Gonggao [g_content=" + g_content + ", g_id=" + g_id
				+ ", g_name=" + g_name + ", g_time=" + g_time + ", society="
				+ society + "]";
	}
	public Gonggao(Integer gId, String gContent, String gTime, String gName,
			Society society) {
		super();
		g_id = gId;
		g_content = gContent;
		g_time = gTime;
		g_name = gName;
		this.society = society;
	}
	public Gonggao() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	

}
