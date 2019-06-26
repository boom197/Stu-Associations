package cn.controller;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dao.impl.AdminDao;
import cn.dao.impl.NewsDao;
import cn.dao.impl.SocietyDao;
import cn.dao.impl.StuDao;
import cn.entity.Admin;
import cn.entity.News;
import cn.entity.Society;
import cn.entity.Stu;
import cn.util.LayuiResult;
import cn.util.ServerRespose;

@Controller
@Scope("prototype")
@RequestMapping("/user")
// @CrossOrigin
public class UserController {
	@Autowired
	private StuDao stuDao;
	@Autowired
	private SocietyDao societyDao;
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private NewsDao newsDao;
	
	List<News> news=null;
	
	//登陆检验
	@RequestMapping("login")
	public String login(String username, String password,Integer role,
			HttpServletRequest request, HttpSession session,Model model) {
		String hql = "from News order by n_id desc";
		List<News> list = newsDao.getByHql(hql);
		model.addAttribute("list", list);
		if(role==0){
			String hql2= "from Admin u where a_number=? and a_pass=?";
			List<Admin> list2 = adminDao.getByHql(hql2, username, password);
			if (list2 != null && list2.size() > 0) {
				Admin admin = list2.get(0);
				session.setAttribute("currentUser", admin);
				session.setAttribute("role", role);
				return "manage/index";
			} else {
				request.setAttribute("msg", "用户名密码错误!");
				return "login";
			}
		}else if(role==1){
			String hql3= "from Society u where t_number=? and t_pass=?";
			List<Society> list3 = null;
			list3=societyDao.getByHql(hql3, username, password);
			if (list3 != null && list3.size() > 0) {
				Society society = list3.get(0);
				session.setAttribute("currentUser", society);
				session.setAttribute("role", role);
				return "manage/index";
			} else {
				request.setAttribute("msg", "用户名密码错误!");
				return "login";
			}
		}else {
			String hql4= "from Stu u where s_number=? and s_pass=?";
			List<Stu> list4 = null;
			list4=stuDao.getByHql(hql4, username, password);
			if (list4 != null && list4.size() > 0) {
				Stu user = list4.get(0);
				session.setAttribute("currentUser", user);
				session.setAttribute("role", role);
				return "manage/index";
			} else {
				request.setAttribute("msg", "用户名密码错误!");
				return "login";
			}
		}
	}
	
	//新闻列表
	@RequestMapping("newslist")
	public String newslist(Model model) {
		String hql = "from News order by n_id desc";
		List<News> list = newsDao.getByHql(hql);
		model.addAttribute("list", list);
		return "manage/index";
	}
    
	//退出
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("currentUser");
		session.removeAttribute("role");
		return "login";
	}
	
	// 学生列表
	@RequestMapping("list")
	public String list() {
		
		return "manage/user_list";
	}
	
	//学生列表
	@RequestMapping("list0")
	@ResponseBody
	public LayuiResult<Stu> getNews(Integer page,Integer limit,Stu stu){
		LayuiResult<Stu> result = new LayuiResult<Stu>();
		if(stu.getS_name()==null||stu.getS_name().trim().equals("")){
			String hql = "from Stu order by s_id desc";
			String hqlCount = "select count(*) from Stu ";
			List<Stu> list = stuDao.getByPage(hql, page,limit);
			Integer count = stuDao.getCount(hqlCount);
			result.setCount(count);
			result.setData(list);
		}else {
			String hql = "from Stu where s_name='"+stu.getS_name()+"'";
			hql+=" order by s_id desc";
			String hqlCount = "select count(*) from Stu where s_name='"+stu.getS_name()+"'";
			List<Stu> list = stuDao.getByPage(hql, page,limit);
			Integer count = stuDao.getCount(hqlCount);
			result.setCount(count);
			result.setData(list);
		}
		return result;
	}
	
    //修改个人资料
	@RequestMapping("updateInfo")
	public String updateInfo(Stu stu,HttpSession session,HttpServletRequest request) throws IOException {
		Stu u = (Stu) session.getAttribute("currentUser");
		if (!StringUtils.isEmpty(stu.getS_number())) {
			u.setS_number(stu.getS_number());
		}
		if (!StringUtils.isEmpty(stu.getS_name())) {
			u.setS_name(stu.getS_name());
		}
		if (!StringUtils.isEmpty(stu.getClass())) {
			u.setS_class(stu.getS_class());
		}
		if (!StringUtils.isEmpty(stu.getS_grade())) {
			u.setS_grade(stu.getS_grade());
		}
		if (!StringUtils.isEmpty(stu.getS_college())) {
			u.setS_college(stu.getS_college());
		}
		if (!StringUtils.isEmpty(stu.getS_phone())) {
			u.setS_phone(stu.getS_phone());
		}
		
		stuDao.update(u);
		session.setAttribute("currentUser", u);
		request.setAttribute("msg", "修改成功！");
		return "manage/userInfo";
	}
	//删除学生
	@RequestMapping("delete")
	@ResponseBody
	public ServerRespose<String> delete(Integer id) {
		Stu stu = stuDao.get(Stu.class, id);
		Set<Society> setTshetuan = stu.getSetTshetuan();
		if(setTshetuan!=null){
			for (Society society : setTshetuan) {
			      society.getSetStu().remove(stu);
			}
		}
		stu.setSetTshetuan(null);
		stuDao.delete(stu);
		return new ServerRespose<String>(200, "删除成功");
	}
	
	//批量删除学生
	@RequestMapping(value="alldel",produces="application/json;charset=utf-8")
	@ResponseBody
	public ServerRespose<String> alldel(String ids) {
		String a[] = ids.split(",");
		try{
			for (int i = 0; i < a.length; i++) {
				Integer id = Integer.valueOf(a[i]);
				Stu stu = stuDao.get(Stu.class, id);
				Set<Society> setTshetuan = stu.getSetTshetuan();
				if(setTshetuan!=null){
					for (Society society : setTshetuan) {
						society.getSetStu().remove(stu);
					}
				}
				stu.setSetTshetuan(null);
				stuDao.delete(stu);
			}
			return new ServerRespose<String>(200, "删除成功！");
		}catch (Exception e) {
			e.printStackTrace();
			return new ServerRespose<String>(500, "删除失败！");
		}
	}
 
	@RequestMapping("updatepwd1")
	@ResponseBody
	public ServerRespose<String> updatepwd1(HttpSession session,
			String password, String password1) {
		Society user = (Society) session.getAttribute("currentUser");
		if (!password.equals(user.getT_pass())) {
			return new ServerRespose<String>(500, "原密码不正确!");
		} else {
			user.setT_pass(password1);
			societyDao.update(user);
			return new ServerRespose<String>(200, "密码修改成功,请重新登录!");
		}
	}

	@RequestMapping("updatepwd")
	@ResponseBody
	public ServerRespose<String> updatepwd(HttpSession session,
			String password, String password1) {
		Stu user = (Stu) session.getAttribute("currentUser");
		if (!password.equals(user.getS_pass())) {
			return new ServerRespose<String>(500, "原密码不正确!");
		} else {
			user.setS_pass(password1);
			stuDao.update(user);
			return new ServerRespose<String>(200, "密码修改成功,请重新登录!");
		}
	}
	//查看密码
	@RequestMapping("toSelect")
	@ResponseBody
	public ServerRespose<String> toSelect(HttpSession session,
			Integer id) {
		Stu user = stuDao.get(Stu.class, id);
		return new ServerRespose<String>(200, user.getS_pass());
	}

	/*@RequestMapping("jsonupdatepwd")
	@ResponseBody
	public ServerRespose<String> jsonupdatepwd(Integer id, String password) {
		TUser user = userDao.get(TUser.class, id);
		user.setPassword(password);
		userDao.update(user);
		return new ServerRespose<String>(200, "密码修改成功,请重新登录!");
	}

	@RequestMapping("add")
	public String add(TUser user)
			throws IOException {
		user.setRole(1);
		user.setIsdel(0);
		userDao.add(user);
		return "redirect:/user/list";
	}*/
	
	//注册
	@RequestMapping("register")
	public String register(Stu stu,HttpServletRequest request)	throws IOException {
		String hql= "from Stu where s_number=?";
		List<Stu> list = stuDao.getByHql(hql,stu.getS_number());
		if(list.size()>0){
			request.setAttribute("msg2", "已有该账号！请重新注册");
			return "login";
		}else {
			stuDao.add(stu);
			request.setAttribute("msg2", "注册成功！");
			return "login";
		}
	}
	

}
