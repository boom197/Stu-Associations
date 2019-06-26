package cn.entity;

//申请社团
public class Apply implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String apply_name; //申请社团名称
	private String apply_post;  //申请职位
	private String apply_user;  // 申请人
	private String apply_time;  //申请时间
	private String apply_is;   //申请状态
	private String apply_why;  //申请理由
	public String getApply_why() {
		return apply_why;
	}
	public void setApply_why(String applyWhy) {
		apply_why = applyWhy;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getApply_name() {
		return apply_name;
	}
	public void setApply_name(String applyName) {
		apply_name = applyName;
	}
	public String getApply_post() {
		return apply_post;
	}
	public void setApply_post(String applyPost) {
		apply_post = applyPost;
	}
	public String getApply_user() {
		return apply_user;
	}
	public void setApply_user(String applyUser) {
		apply_user = applyUser;
	}
	public String getApply_time() {
		return apply_time;
	}
	public void setApply_time(String applyTime) {
		apply_time = applyTime;
	}
	public String getApply_is() {
		return apply_is;
	}
	public void setApply_is(String applyIs) {
		apply_is = applyIs;
	}
	public Apply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Apply(Integer id, String applyName, String applyPost,
			String applyUser, String applyTime, String applyIs,String applywhy) {
		super();
		this.id = id;
		apply_name = applyName;
		apply_post = applyPost;
		apply_user = applyUser;
		apply_time = applyTime;
		apply_is = applyIs;
		apply_why = applywhy;
	}
	@Override
	public String toString() {
		return "Apply [apply_is=" + apply_is + ", apply_name=" + apply_name
				+ ", apply_post=" + apply_post + ", apply_time=" + apply_time
				+ ", apply_user=" + apply_user + ", apply_why=" + apply_why
				+ ", id=" + id + "]";
	}
	
	
	

}
