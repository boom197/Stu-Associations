package cn.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.FetchType;
import javax.persistence.OneToMany;

import com.alibaba.fastjson.annotation.JSONField;

//社团
public class Society implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer t_id;
	private String t_number;
	private String t_pass;
	private String t_name;
	private String t_society;
	private String t_time;
	private String t_jianjie;
	private String t_phone;
	
	@JSONField(serialize=false) 
	private Set<Stu> setStu = new HashSet<Stu>();
	
	
	private Set<Post> setPost = new HashSet<Post>();
	
	
	private Set<Gonggao> setGonggao = new HashSet<Gonggao>();
	
	@OneToMany(mappedBy="stu",fetch=FetchType.EAGER)
	public Set<Gonggao> getSetGonggao() {
		return setGonggao;
	}
	@OneToMany(mappedBy="stu",fetch=FetchType.EAGER)
	public void setSetGonggao(Set<Gonggao> setGonggao) {
		this.setGonggao = setGonggao;
	}
	@OneToMany(mappedBy="stu",fetch=FetchType.EAGER)
	public Set<Post> getSetPost() {
		return setPost;
	}
	
	public void setSetPost(Set<Post> setPost) {
		this.setPost = setPost;
	}
	
	@OneToMany(mappedBy="society",fetch=FetchType.EAGER)
	public Set<Stu> getSetStu() {
		return setStu;
	}
	public void setSetStu(Set<Stu> setStu) {
		this.setStu = setStu;
	}
	public Integer getT_id() {
		return t_id;
	}
	public void setT_id(Integer tId) {
		t_id = tId;
	}
	public String getT_number() {
		return t_number;
	}
	public void setT_number(String tNumber) {
		t_number = tNumber;
	}
	public String getT_pass() {
		return t_pass;
	}
	public void setT_pass(String tPass) {
		t_pass = tPass;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String tName) {
		t_name = tName;
	}
	public String getT_society() {
		return t_society;
	}
	public void setT_society(String tSociety) {
		t_society = tSociety;
	}
	public String getT_time() {
		return t_time;
	}
	public void setT_time(String tTime) {
		t_time = tTime;
	}
	public String getT_jianjie() {
		return t_jianjie;
	}
	public void setT_jianjie(String tJianjie) {
		t_jianjie = tJianjie;
	}
	public String getT_phone() {
		return t_phone;
	}
	public void setT_phone(String tPhone) {
		t_phone = tPhone;
	}
	public Society(Integer tId, String tNumber, String tPass, String tName,
			String tSociety, String tTime, String tJianjie, String tPhone,
			Set<Stu> setStu, Set<Post> setPost, Set<Gonggao> setGonggao) {
		super();
		t_id = tId;
		t_number = tNumber;
		t_pass = tPass;
		t_name = tName;
		t_society = tSociety;
		t_time = tTime;
		t_jianjie = tJianjie;
		t_phone = tPhone;
		this.setStu = setStu;
		this.setPost = setPost;
		this.setGonggao = setGonggao;
	}
	public Society() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
