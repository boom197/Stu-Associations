package cn.entity;

//管理员
public class Admin implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer a_id;  //id
	private String a_number;  //账号
	private String a_pass;  //密码
	private String a_name;   //姓名
	public Integer getA_id() {
		return a_id;
	}
	public void setA_id(Integer aId) {
		a_id = aId;
	}
	public String getA_number() {
		return a_number;
	}
	public void setA_number(String aNumber) {
		a_number = aNumber;
	}
	public String getA_pass() {
		return a_pass;
	}
	public void setA_pass(String aPass) {
		a_pass = aPass;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String aName) {
		a_name = aName;
	}
	@Override
	public String toString() {
		return "Admin [a_id=" + a_id + ", a_name=" + a_name + ", a_number="
				+ a_number + ", a_pass=" + a_pass + "]";
	}
	public Admin(Integer aId, String aNumber, String aPass, String aName) {
		super();
		a_id = aId;
		a_number = aNumber;
		a_pass = aPass;
		a_name = aName;
	}
	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
