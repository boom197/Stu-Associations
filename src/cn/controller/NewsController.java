package cn.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.jdbc.StringUtils;

import cn.dao.impl.NewsDao;
import cn.entity.News;
import cn.entity.Society;
import cn.util.Const;
import cn.util.LayuiResult;
import cn.util.ServerRespose;

@Controller
@Scope("prototype")
@RequestMapping("/news")
public class NewsController {
	@Autowired
	private NewsDao newsDao;

	//新闻详细
	@RequestMapping("show")
	public String show(Integer id,Model model) {
		String hql = "from News where n_id=?";
		List<News> list = newsDao.getByHql(hql,id);
		if(list!=null&&list.size()>0){
			model.addAttribute("news", list.get(0));
		}
		return "manage/news_show";
	}
	
	//新闻列表
	@RequestMapping("list")
	@ResponseBody
	public LayuiResult<News> getNews(Integer page,Integer limit,HttpSession session){
		Integer role = (Integer) session.getAttribute("role");
		LayuiResult<News> result = new LayuiResult<News>();
		if(role==1){
			Society society = (Society) session.getAttribute("currentUser");
			String hqlCount = "select count(*) from News u where n_user='"+society.getT_society()+"'";
			String hql = "from News u where n_user='"+society.getT_society()+"'";
			hql += " order by n_id desc";
			List<News> list = newsDao.getByHql(hql);
			Integer count = newsDao.getCount(hqlCount);
			result.setCount(count);
			result.setData(list);
			return result;
		}else {
			String hql = "from News order by n_id desc";
			String hqlCount = "select count(*) from News ";
			List<News> list = newsDao.getByPage(hql, page,limit);
			Integer count = newsDao.getCount(hqlCount);
			result.setCount(count);
			result.setData(list);
			return result;
		}
	}
	
	@RequestMapping("jsonlist")
	@ResponseBody
	public List<News> jsonlist(Integer uid) {
		String hql = "from News f where n_title=?";
		return newsDao.getByHql(hql,uid);
	}

	@RequestMapping("jsondetail")
	@ResponseBody
	public News jsondetail(Integer id) {
		return newsDao.get(News.class, id);
	}
    
	//删除新闻
	@RequestMapping("delete")
	@ResponseBody
	public ServerRespose<String> delete(Integer id) {
		News news = newsDao.get(News.class, id);
		newsDao.delete(news);
		return new ServerRespose<String>(200, "删除成功！");
	}
	
	//批量删除新闻
	@RequestMapping("alldel")
	@ResponseBody
	public ServerRespose<String> alldel(String ids) {
		String a[] = ids.split(",");
		try{
			for (int i = 0; i < a.length; i++) {
				Integer id = Integer.valueOf(a[i]);
				News news = newsDao.get(News.class, id);
				newsDao.delete(news);
			}
			return new ServerRespose<String>(200, "删除成功！");
		}catch (Exception e) {
			e.printStackTrace();
			return new ServerRespose<String>(500, "删除失败！");
		}
	}
   
	 //添加新闻
	@RequestMapping("add")
	public String add(News news, HttpSession session,MultipartFile pacFile) throws IOException {
		if(!pacFile.isEmpty()){
			String newname = UUID.randomUUID().toString();   //新的名字
			String filename = pacFile.getOriginalFilename();   //旧的名字
			String substring = filename.substring(filename.lastIndexOf(".")); //后缀名
			File file= new File("E:\\pic\\"+newname+substring);  //写入磁盘
			pacFile.transferTo(file);
			news.setN_pic(newname+substring);
		}else{
			news.setN_pic(null);
		}
		news.setN_time(Const.getCurrentTime());
		Integer role = (Integer) session.getAttribute("role");
		if(role==1){
		  Society society = (Society) session.getAttribute("currentUser");
		  news.setN_user(society.getT_society());
		  newsDao.add(news);
		  return "redirect:/user/newslist";
		}else {
		  news.setN_user("管理员");
		  newsDao.add(news);
		  return "redirect:/user/newslist";
		}
	}

	@RequestMapping("update")
	public String update(News news,HttpSession session) throws IOException {
		News u = newsDao.get(News.class, news.getN_id());
		if (!StringUtils.isNullOrEmpty(news.getN_title())) {
			u.setN_title(news.getN_title());
		}
		if (!StringUtils.isNullOrEmpty(news.getN_content())) {
			u.setN_content(news.getN_content());
		}
		u.setN_time(Const.getCurrentTime());
		newsDao.update(u);
		Integer role = (Integer) session.getAttribute("role");
		if(role==1){
			return "redirect:/news/list1";
		}else {
			return "redirect:/news/list";
		}
	}

}
