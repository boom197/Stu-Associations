package cn.entity;

public class News implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer n_id;
	private String n_title;
	private String n_user;
	private String n_pic;
	
	
	
	public String getN_pic() {
		return n_pic;
	}
	public void setN_pic(String nPic) {
		n_pic = nPic;
	}
	public String getN_user() {
		return n_user;
	}
	public void setN_user(String nUser) {
		n_user = nUser;
	}
	private String n_content;
	private String n_time;
	public Integer getN_id() {
		return n_id;
	}
	public void setN_id(Integer nId) {
		n_id = nId;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String nTitle) {
		n_title = nTitle;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String nContent) {
		n_content = nContent;
	}
	public String getN_time() {
		return n_time;
	}
	public void setN_time(String nTime) {
		n_time = nTime;
	}
	public News() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}
