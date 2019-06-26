package cn.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.jdbc.StringUtils;

import cn.dao.impl.GonggaoDao;
import cn.dao.impl.StuDao;
import cn.entity.Gonggao;
import cn.entity.Society;
import cn.entity.Stu;
import cn.util.Const;
import cn.util.LayuiResult;
import cn.util.ServerRespose;

@Controller
@Scope("prototype")
@RequestMapping("/gonggao")
public class GonggaoController {
	@Autowired
	private GonggaoDao gonggaoDao;
	@Autowired
	private StuDao userDao;
	
	
	//1
	@RequestMapping("list1")
	public String list() {
		/*Society society =(Society) session.getAttribute("currentUser");
		String hqlCount = "select count(*) from Gonggao u where t_id=?";
		String hql = "from Gonggao u where t_id='"+society.getT_id()+"'";
		hqlCount += " order by u.g_id";
		hql += " order by u.g_id";
		pageBean.setTotalCount(gonggaoDao.getCount(hqlCount,society.getT_id()));
		List<Gonggao> list = gonggaoDao.getByPage(hql, pageBean.getPageNo(),
				pageBean.getPageSize());
		model.addAttribute("list", list);
		model.addAttribute("pageBean", pageBean);*/
		return "manage/gonggao_list";
	}
	
	//通告管理
	@RequestMapping("notice1")
	@ResponseBody
	public LayuiResult<Gonggao> notice(Integer page,Integer limit,HttpSession session) {
		Society society =(Society) session.getAttribute("currentUser");
		LayuiResult<Gonggao> socirtylist = new LayuiResult<Gonggao>();
		String hql = "from Gonggao where t_id='"+society.getT_id()+"'";
		hql+="order by g_id desc";
		String hqlCount = "select count(*) from Gonggao u where t_id=?";
		Integer count = gonggaoDao.getCount(hqlCount, society.getT_id());
		List<Gonggao> list = gonggaoDao.getByPage(hql, page, limit);
		socirtylist.setData(list);
		socirtylist.setCount(count);
		return socirtylist;
	}
	
	//批量删除通告
	@RequestMapping(value="alldel",produces="application/json;charset=utf-8")
	@ResponseBody
	public ServerRespose<String> alldel(String ids) {
		//String ids = stu.getS_number();        //ids和id都存在于实体类User
		String a[] = ids.split(",");
		try{
			for (int i = 0; i < a.length; i++) {
				Integer id = Integer.valueOf(a[i]);
				Gonggao g = gonggaoDao.get(Gonggao.class, id);
				gonggaoDao.delete(g);
			}
			return new ServerRespose<String>(200, "删除成功！");
		}catch (Exception e) {
			e.printStackTrace();
			return new ServerRespose<String>(500, "删除失败！");
		}
	}
 
	//社团公告
	@RequestMapping("list2/{id}")
	public String list2(@PathVariable Integer id, Model model, HttpSession session,HttpSession request) {
		
		Stu stu = userDao.get(Stu.class,id);
		Set<Society> setTshetuan = stu.getSetTshetuan();
		List<Gonggao> list=new ArrayList<Gonggao>();
		if(setTshetuan!=null){
			for (Society society : setTshetuan) {
				String hql = "from Gonggao where g_name='"+society.getT_society()+"'";
				hql += " order by g_id desc";
				List<Gonggao> list2 = gonggaoDao.getByHql(hql);
				if(list2!=null){
					for (Gonggao gonggao : list2) {
						list.add(gonggao);
					}
				}
			}
			model.addAttribute("list2", list);
		}
		return "manage/gonggao2";
	}
	//查看公告
	@RequestMapping("show")
	@ResponseBody
	public Gonggao show(Integer id) {
		if(id==null){
			return null;
		}
		return gonggaoDao.get(Gonggao.class, id);
	}
	
	@RequestMapping("jsonlist")
	@ResponseBody
	public List<Gonggao> jsonlist(Integer uid) {
		String hql = "from TGonggao f";
		return gonggaoDao.getByHql(hql);
	}

	@RequestMapping("jsondetail")
	@ResponseBody
	public Gonggao jsondetail(Integer id) {
		if(id==null){
			return null;
		}
		return gonggaoDao.get(Gonggao.class, id);
	}
   
	//删除公告
	@RequestMapping("delete")
	@ResponseBody
	public ServerRespose<String> delete(Integer id) {
		Gonggao gonggao = gonggaoDao.get(Gonggao.class, id);
		gonggaoDao.delete(gonggao);
		return new ServerRespose<String>(200, "删除成功！");
	}
	
	@RequestMapping("add")
	public String add(Gonggao gonggao,HttpSession session) throws IOException {
		Society s = (Society) session.getAttribute("currentUser");
		gonggao.setG_name(s.getT_society());
		gonggao.setG_time(Const.getCurrentTime());
		gonggao.setSociety(s);
		gonggaoDao.add(gonggao);
		return "redirect:/gonggao/list1";
	}

	@RequestMapping("update")
	public String update(Gonggao gonggao) throws IOException {
		Gonggao u = gonggaoDao.get(Gonggao.class, gonggao.getG_id());
		if (!StringUtils.isNullOrEmpty(gonggao.getG_content())) {
			u.setG_content(gonggao.getG_content());
			u.setG_time(Const.getCurrentTime());
		}
		gonggaoDao.update(u);
		return "redirect:/gonggao/list1";
	}

}
