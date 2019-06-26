package cn.entity;

import com.alibaba.fastjson.annotation.JSONField;

//职位
public class Post implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer z_id;
	private String z_name;
	private String z_zhiwei;
	private String z_jieshao;
	
	@JSONField(serialize = false)
	private Society z_society;
	
	public Integer getZ_id() {
		return z_id;
	}

	public void setZ_id(Integer zId) {
		z_id = zId;
	}

	public String getZ_name() {
		return z_name;
	}

	public void setZ_name(String zName) {
		z_name = zName;
	}

	public String getZ_zhiwei() {
		return z_zhiwei;
	}

	public void setZ_zhiwei(String zZhiwei) {
		z_zhiwei = zZhiwei;
	}

	public String getZ_jieshao() {
		return z_jieshao;
	}

	public void setZ_jieshao(String zJieshao) {
		z_jieshao = zJieshao;
	}


	public Society getZ_society() {
		return z_society;
	}

	public void setZ_society(Society zSociety) {
		z_society = zSociety;
	}

	@Override
	public String toString() {
		return "Post [z_id=" + z_id + ", z_jieshao=" + z_jieshao + ", z_name="
				+ z_name + ", z_society=" + z_society + ", z_zhiwei="
				+ z_zhiwei + "]";
	}

	public Post(Integer zId, String zName, String zZhiwei, String zJieshao,
			Society zSociety) {
		super();
		z_id = zId;
		z_name = zName;
		z_zhiwei = zZhiwei;
		z_jieshao = zJieshao;
		z_society = zSociety;
	}

	public Post() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}
