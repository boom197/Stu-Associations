package cn.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dao.impl.SocietyDao;
import cn.dao.impl.StuDao;
import cn.entity.Society;
import cn.entity.Stu;
import cn.util.Const;
import cn.util.LayuiResult;
import cn.util.ServerRespose;

@Controller
@Scope("prototype")
@RequestMapping("/shetuan")
public class ShetuanController {
	@Autowired
	private SocietyDao societyDao;
	@Autowired
	private StuDao stuDao;

	//社团编辑
	/*@RequestMapping("list")
	public String list(String name,PageBean pageBean,Model model,HttpSession session) {
		Society society = (Society) session.getAttribute("currentUser");
		model.addAttribute("society", society);
		return "manage/shetuan_list";
	}*/
	
	@RequestMapping("list")
	public String list() {
		return "manage/shetuan_list0";
	}
	//社团管理；全部社团
	@RequestMapping("list0")
	@ResponseBody
	public LayuiResult<Society> list0(Integer page,Integer limit,Society society) {
		LayuiResult<Society> socirtylist = new LayuiResult<Society>();
		if(society.getT_society()==null||society.getT_society().trim().equals("")){
			String hql2= "from Society order by t_id desc";
			String hqlCount2 = "select count(*) from Society";
			Integer count2 = societyDao.getCount(hqlCount2);
			List<Society> list = societyDao.getByPage(hql2, page, limit);
			socirtylist.setData(list);
			socirtylist.setCount(count2);
			return socirtylist;
		}else {
			String hql= "from Society where t_society='"+society.getT_society()+"'";
			hql+=" order by t_id desc";
			String hqlCount = "select count(*) from Society where t_society='"+society.getT_society()+"'";
			List<Society> list = societyDao.getByPage(hql, page, limit);
			if(list!=null){
				Integer count = societyDao.getCount(hqlCount);
				socirtylist.setData(list);
				socirtylist.setCount(count);
			}
			return socirtylist;
		}
	}
	
	//社团详细信息
	@RequestMapping("xiangxi")
	public String xiangxi(Integer id,Model model) {
		Society society = societyDao.get(Society.class, id);
		Set<Stu> setStu = society.getSetStu();
		List<Stu> list = new ArrayList<Stu>();
		if(setStu!=null){
			for (Stu stu : setStu) {
				list.add(stu);
			}
		}
	    model.addAttribute("list", list);
	    model.addAttribute("shetuan", society);
		return "manage/shetuan_stu";
	}
    //删除社团
	@RequestMapping("delete")
	@ResponseBody
	public ServerRespose<String> delete(Integer id) {
		Society s = societyDao.get(Society.class, id);
		Set<Stu> setStu = s.getSetStu();
		if(setStu!=null){
			for (Stu stu : setStu) {
				stu.getSetTshetuan().remove(s);
			}
		}
		s.setSetStu(null);
		societyDao.delete(s);
		return new ServerRespose<String>(200, "删除成功！");
	}
	
	//添加社团
	@RequestMapping("add")
	public String add(Society society,HttpServletRequest request) throws IOException {
		String id =society.getT_number();
		String name = society.getT_society();
		String hql= "from Society where t_number=?";
		String hql2= "from Society where t_society=?";
		List<Society> list = societyDao.getByHql(hql, id);
		List<Society> list2 = societyDao.getByHql(hql2, name);
		if(list.size()>0){
			request.setAttribute("msg", "该账号已经存在！");
			return "manage/shetuan_list0";
		}
		if(list2.size()>0){
			request.setAttribute("msg", "该社团已经存在！");
			return "manage/shetuan_list0";
		}
		society.setT_time(Const.getCurrentDay());
		society.setT_jianjie("无");
		societyDao.add(society);
		return "redirect:/shetuan/list";
	}
	
	/*@RequestMapping("upload")
	@ResponseBody
	public ServerRespose<String> upload(MultipartFile file,HttpServletRequest request) throws IOException {
		String path=request.getSession().getServletContext().getRealPath("/upload");
		String filename=file.getOriginalFilename();
		file.transferTo(new File(path+"/"+filename));
		return new ServerRespose<String>(200,filename);
	}*/
	
	/*@RequestMapping("upfile")
	@ResponseBody
	public ServerRespose<String> upfile(MultipartFile fujian,HttpServletRequest request) throws IOException {
		String path=request.getSession().getServletContext().getRealPath("/img");
		String filename="tuopu.jpg";
		fujian.transferTo(new File(path+"/"+filename));
		return new ServerRespose<String>(200,filename);
	}*/
	
	
	//社团编辑
	@RequestMapping("update")
	public String update(Society society,HttpSession session,HttpServletRequest request) throws IOException {
		Society s =(Society) session.getAttribute("currentUser");
		s.setT_society(society.getT_society());
		s.setT_name(society.getT_name());
		s.setT_jianjie(society.getT_jianjie());
		societyDao.update(s);
		session.setAttribute("currentUser", s);
		request.setAttribute("msg", "修改成功!");
		return "manage/shetuan_list";
	}

	//删除社团成员
	@RequestMapping(value="alldel",produces="application/json;charset=utf-8")
	@ResponseBody
	public ServerRespose<String> alldel(String ids,HttpSession session) {
		String a[] = ids.split(",");
		Society society = (Society) session.getAttribute("currentUser");
		Society society2 = societyDao.get(Society.class, society.getT_id());
		try{
			for (int i = 0; i < a.length; i++) {
				Integer id = Integer.valueOf(a[i]);
				Stu stu = stuDao.get(Stu.class, id);
				society2.getSetStu().remove(stu);
				societyDao.update(society2);
			}
			return new ServerRespose<String>(200, "删除成功！");
		}catch (Exception e) {
			e.printStackTrace();
			return new ServerRespose<String>(500, "删除失败！");
		}
	}
	
	/*@RequestMapping("jsonlist")
	@ResponseBody
	public List<TShetuan> jsonlist(){
		String hql = "from TShetuan u where isdel=0 order by u.id desc";
		return shetuanDao.getByPage(hql, 1, 20);
	}*/
	
	
	@RequestMapping("jsondetail")
	@ResponseBody
	public Society jsondetail(Integer id){
		return societyDao.get(Society.class,id);
	}
}
