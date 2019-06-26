package cn.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.FetchType;
import javax.persistence.OneToMany;



//学生
public class Stu implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer s_id;
	private String s_number;
	private String s_pass;
	private String s_name;
	private String s_class;
	private String s_grade;
	private String s_college;
	private String s_phone;
	
	private Set<Society> setTshetuan = new HashSet<Society>();
	
	@OneToMany(mappedBy="stu",fetch=FetchType.EAGER)
	public Set<Society> getSetTshetuan() {
		return setTshetuan;
	}
	public void setSetTshetuan(Set<Society> setTshetuan) {
		this.setTshetuan = setTshetuan;
	}
	
	public Integer getS_id() {
		return s_id;
	}
	public void setS_id(Integer sId) {
		s_id = sId;
	}
	public String getS_number() {
		return s_number;
	}
	public void setS_number(String sNumber) {
		s_number = sNumber;
	}
	public String getS_pass() {
		return s_pass;
	}
	public void setS_pass(String sPass) {
		s_pass = sPass;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String sName) {
		s_name = sName;
	}
	public String getS_class() {
		return s_class;
	}
	public void setS_class(String sClass) {
		s_class = sClass;
	}
	public String getS_grade() {
		return s_grade;
	}
	public void setS_grade(String sGrade) {
		s_grade = sGrade;
	}
	public String getS_college() {
		return s_college;
	}
	public void setS_college(String sCollege) {
		s_college = sCollege;
	}
	public String getS_phone() {
		return s_phone;
	}
	public void setS_phone(String sPhone) {
		s_phone = sPhone;
	}
	@Override
	public String toString() {
		return "Stu [s_class=" + s_class + ", s_college=" + s_college
				+ ", s_grade=" + s_grade + ", s_id=" + s_id + ", s_name="
				+ s_name + ", s_number=" + s_number + ", s_pass=" + s_pass
				+ ", s_phone=" + s_phone + ", s_role=" 
				+ ", setTshetuan=" + setTshetuan + "]";
	}
	public Stu(Integer sId, String sNumber, String sPass, String sName,
			String sClass, String sGrade, String sCollege, String sPhone,
			Integer sRole, Set<Society> setTshetuan) {
		super();
		s_id = sId;
		s_number = sNumber;
		s_pass = sPass;
		s_name = sName;
		s_class = sClass;
		s_grade = sGrade;
		s_college = sCollege;
		s_phone = sPhone;
		this.setTshetuan = setTshetuan;
	}
	public Stu() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	

}
