package cn.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dao.impl.PostDao;
import cn.entity.Post;
import cn.entity.Society;
import cn.util.PageBean;

import com.mysql.jdbc.StringUtils;

@Controller
@Scope("prototype")
@RequestMapping("/job")
public class JobController {
	@Autowired
	private PostDao postDao;

	@RequestMapping("list")
	public String list(String name, PageBean pageBean, Model model,
			HttpSession session) {
		String hqlCount = "select count(*) from Post u where 1=1";
		String hql = "from Post u where 1=1";
		Integer role = (Integer) session.getAttribute("role");
		List<Post> list = null;
		if (role == 1) {
			Society s = (Society) session.getAttribute("currentUser");
			hqlCount += "and z_name='" + s.getT_society() + "'";
			hql += "and z_name='" + s.getT_society() + "'";
			if (name != null && !"".equals(name)) {
				hqlCount += " and u.z_name like '%" + name + "%'";
				hql += " and u.z_name like '%" + name + "%'";
			}
			pageBean.setTotalCount(postDao.getCount(hqlCount));
			list = postDao.getByPage(hql, pageBean.getPageNo(), pageBean
					.getPageSize());

		} else {
			if (name != null && !"".equals(name)) {
				hqlCount += " and u.z_name like '%" + name + "%'";
				hql += " and u.z_name like '%" + name + "%'";
			}
			hqlCount += " order by u.id";
			hql += " order by u.id";
			pageBean.setTotalCount(postDao.getCount(hqlCount));
			list = postDao.getByPage(hql, pageBean.getPageNo(), pageBean
					.getPageSize());
		}
		model.addAttribute("list", list);
		model.addAttribute("pageBean", pageBean);
		return "manage/job_list";

	}

	@RequestMapping("delete")
	public String delete(Integer id) {
		Post post = postDao.get(Post.class, id);
		postDao.delete(post);
		return "redirect:/job/list";
	}

	@RequestMapping("add")
	public String add(Post post, HttpSession session) throws IOException {
		Society society = (Society) session.getAttribute("currentUser");
		if(society!=null){
			post.setZ_name(society.getT_society());
			post.setZ_society(society);
			postDao.add(post);
		}
		return "redirect:/job/list";
	}

	/*@RequestMapping("upload")
	@ResponseBody
	public ServerRespose<String> upload(MultipartFile file,
			HttpServletRequest request) throws IOException {
		String path = request.getSession().getServletContext().getRealPath(
				"/upload");
		String filename = file.getOriginalFilename();
		file.transferTo(new File(path + "/" + filename));
		return new ServerRespose<String>(200, filename);
	}*/

	/*@RequestMapping("upfile")
	@ResponseBody
	public ServerRespose<String> upfile(MultipartFile fujian,
			HttpServletRequest request) throws IOException {
		String path = request.getSession().getServletContext().getRealPath(
				"/img");
		String filename = "tuopu.jpg";
		fujian.transferTo(new File(path + "/" + filename));
		return new ServerRespose<String>(200, filename);
	}*/

	@RequestMapping("update")
	public String update(Post post) throws IOException {
		Post post2 = postDao.get(Post.class, post.getZ_id());
		
		if (!StringUtils.isNullOrEmpty(post.getZ_zhiwei())) {
			post2.setZ_zhiwei(post.getZ_zhiwei());
		}

		if (!StringUtils.isNullOrEmpty(post.getZ_jieshao())) {
			post2.setZ_jieshao(post.getZ_jieshao());
		}

		postDao.update(post2);
		return "redirect:/job/list";
	}

	/*@RequestMapping("jsonall")
	@ResponseBody
	public List<TJob> jsonall() {
		String hql = "from TJob u order by u.id desc";
		return jobDao.getByPage(hql, 1, 20);
	}*/

	@RequestMapping("jsondetail")
	@ResponseBody
	public Post jsondetail(Integer id) {
		return postDao.get(Post.class, id);
	}

}
