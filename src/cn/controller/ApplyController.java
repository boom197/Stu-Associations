package cn.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dao.impl.ApplyDao;
import cn.dao.impl.PostDao;
import cn.dao.impl.SocietyDao;
import cn.dao.impl.StuDao;
import cn.entity.Apply;
import cn.entity.Post;
import cn.entity.Society;
import cn.entity.Stu;
import cn.util.Const;
import cn.util.LayuiResult;
import cn.util.ServerRespose;

@Controller//表示控制层
@Scope("prototype")//多例：prototype表示每次获得bean都会生成一个新的对象
@RequestMapping("/record")
public class ApplyController {
	@Autowired
	private ApplyDao applyDao;
	@Autowired
	private PostDao postDao;
	@Autowired
	private StuDao stuDao;
	@Autowired
	private SocietyDao societyDao;

	//申请管理
	@RequestMapping("apply1")
	public String list() {
		
		return "manage/record_apply1";
	}
	//我的申请
	@RequestMapping("apply2")
	public String apply2() {
		
		return "manage/myapply";
	}
	
	//我参与的社团
	@RequestMapping("list2")
	public String list2() {
		
		return "manage/record_list2";
	}
	//申请管理
	@RequestMapping("apply")
	@ResponseBody
	public LayuiResult<Apply> list0(Integer page,Integer limit,HttpSession session) {
		Society society = (Society) session.getAttribute("currentUser");
		Society society2 = societyDao.get(Society.class, society.getT_id());
		String hql= "from Apply where apply_name='"+society2.getT_society()+"'";
		hql+=" order by id desc";
		List<Apply> list = applyDao.getByHql(hql);
		LayuiResult<Apply> socirtylist = new LayuiResult<Apply>();
		socirtylist.setCount(list.size());
		socirtylist.setData(list);
		return socirtylist;
	}
	
	//我的申请
	@RequestMapping("myapply")
	@ResponseBody
	public LayuiResult<Apply> myapply(Integer page,Integer limit,HttpSession session) {
		Stu stu = (Stu) session.getAttribute("currentUser");
		Stu stu2 = stuDao.get(Stu.class, stu.getS_id());
		String hql= "from Apply where apply_user='"+stu2.getS_name()+"'";
		hql+=" order by id desc";
		List<Apply> list = applyDao.getByHql(hql);
		LayuiResult<Apply> socirtylist = new LayuiResult<Apply>();
		socirtylist.setCount(list.size());
		socirtylist.setData(list);
		return socirtylist;
	}

	// 我参与的社团
	@RequestMapping("mysociety")
	@ResponseBody
	public LayuiResult<Society> mysociety(Integer page,Integer limit,HttpSession session) {
		Stu stu = (Stu) session.getAttribute("currentUser");
		Stu stu2 = stuDao.get(Stu.class, stu.getS_id());
		Set<Society> tshetuan = stu2.getSetTshetuan();
		System.out.println(tshetuan.size());
		LayuiResult<Society> socirtylist = new LayuiResult<Society>();
		List<Society> list = new ArrayList<Society>();
		if (tshetuan != null) {
			for (Society society : tshetuan) {
				list.add(society);
			}
		}
		socirtylist.setCount(tshetuan.size());
		socirtylist.setData(list);
		return socirtylist;
	}
	
	//成员管理
	@RequestMapping("list1")
	public String list1() {
		return "manage/record_list3";
	}
	//成员管理
	@RequestMapping("al1stu")
	@ResponseBody
	public LayuiResult<Stu> al1stu(Integer page,Integer limit,HttpSession session,Stu stu) {
		LayuiResult<Stu> stuResult = new LayuiResult<Stu>();
		Society society = (Society) session.getAttribute("currentUser");
		Society society2 = societyDao.get(Society.class, society.getT_id());
		Set<Stu> setStu = society2.getSetStu();
		List<Stu> list = new ArrayList<Stu>();
		if (setStu != null) {
			if(stu.getS_name()==null||stu.getS_name().trim().equals("")){
				for (Stu s : setStu) {
				list.add(s);
				}
				stuResult.setCount(setStu.size());
			}else {
				for (Stu s : setStu) {
					System.out.println(s.getS_name());
					if(stu.getS_name().equals(s.getS_name())){
						list.add(s);
					}
				}
				stuResult.setCount(list.size());
			}
		}
		int toIndex=(page*limit)-1;
		if(toIndex>list.size()){
			toIndex=list.size();
		}
		list.subList((page-1)*limit, toIndex);
		stuResult.setData(list);
		return stuResult;
		}
			
    //删除我的申请
	@RequestMapping("delete")
	@ResponseBody
	public ServerRespose<String> delete(Integer id) {
		Apply record = applyDao.get(Apply.class, id);
		if(record.getApply_is().equals("已通过")){
			return new ServerRespose<String>(500, "您已通过申请，无法取消申请！");
		}else if(record.getApply_is().equals("已拒绝")){
			applyDao.delete(record);
			return new ServerRespose<String>(200, "删除成功");
		}else {
			applyDao.delete(record);
			return new ServerRespose<String>(200, "取消成功");
		}
	}

	// 退出社团
	@RequestMapping("delete2")
	@ResponseBody
	public ServerRespose<String> delete2(Integer id, HttpSession session) {
		Stu stu = (Stu) session.getAttribute("currentUser");
		Stu stu2 = stuDao.get(Stu.class, stu.getS_id());
		Society society = societyDao.get(Society.class, id);
		stu2.getSetTshetuan().remove(society);
		stuDao.update(stu2);
		return new ServerRespose<String>(200, "退出成功");
	}

	// 删除成员
	@RequestMapping("delete3")
	@ResponseBody
	public ServerRespose<String> delete3(Integer id, HttpSession session) {
		Society society = (Society) session.getAttribute("currentUser");
		Society society2 = societyDao.get(Society.class, society.getT_id());
		Stu stu = stuDao.get(Stu.class, id);
		society2.getSetStu().remove(stu);
		societyDao.update(society2);
		return new ServerRespose<String>(200, "删除成功");
	}

	// 申请社团
	@RequestMapping("add")
	public String add(Apply apply, HttpSession session,
			HttpServletRequest request) throws IOException {
		Stu stu = (Stu) session.getAttribute("currentUser");
		Post post = postDao.get(Post.class, apply.getId());
		String hqlCount = "select count(*) from Apply u where u.apply_user='"
				+ stu.getS_name() + "' and u.apply_name='" + post.getZ_name()
				+ "'";
		Integer count = applyDao.getCount(hqlCount);
		if (count > 0) {
			request.setAttribute("msg", 0);
			return "manage/job_list";
		} else {
			Apply a = new Apply();
			a.setApply_name(post.getZ_name());
			a.setApply_post(post.getZ_zhiwei());
			a.setApply_time(Const.getCurrentDay());
			a.setApply_user(stu.getS_name());
			a.setApply_why(apply.getApply_why());
			a.setApply_is("已申请");
			applyDao.add(a);
			request.setAttribute("msg", 1);
			return "manage/job_list";
		}
	}

	// 同意申请
	@RequestMapping("update")
	@ResponseBody
	public ServerRespose<String> update(Integer id) throws IOException {
		System.out.println(id);
		Apply apply = applyDao.get(Apply.class, id);
		if(apply.getApply_is().equals("已通过")){
			return new ServerRespose<String>(200, "你已同意过了！");
		}else if(apply.getApply_is().equals("已申请")){
			apply.setApply_is("已通过");
			applyDao.update(apply);
			String hql = "from Stu where s_name=?";
			String hql2 = "from Society where t_society=?";
			List<Stu> stu = stuDao.getByHql(hql, apply.getApply_user());
			List<Society> society = societyDao.getByHql(hql2, apply.getApply_name());
			if (stu.size() > 0 && society.size() > 0) {
				Society society2 = society.get(0);
				Stu stu2 = stu.get(0);
				stu2.getSetTshetuan().add(society2);
				stuDao.update(stu2);
			}
			return new ServerRespose<String>(200, "已同意申请！");
		}else {
			return new ServerRespose<String>(200, "您已拒绝，无法同意！");
		}
	}
    //拒绝申请
	@RequestMapping("refuse")
	@ResponseBody
	public ServerRespose<String> Refuse(Integer id) {
		System.out.println(id);
		Apply apply = applyDao.get(Apply.class, id);
		if(apply.getApply_is().equals("已申请")){
			apply.setApply_is("已拒绝");
			applyDao.update(apply);
			return new ServerRespose<String>(200, "已拒绝！");
		}else if(apply.getApply_is().equals("已拒绝")){
			return new ServerRespose<String>(200, "您已经拒绝过了！");
		}else {
			return new ServerRespose<String>(200, "您已经同意申请了，不能再拒绝！");
		}
	}
	 //删除申请
	@RequestMapping("delete1")
	@ResponseBody
	public ServerRespose<String> delete1(Integer id) {
		Apply record = applyDao.get(Apply.class, id);
		if(record.getApply_is().equals("已申请")){
		   return new ServerRespose<String>(200, "请同意或拒绝再删除！");
		}else {
			applyDao.delete(record);
			return new ServerRespose<String>(200, "删除成功！");
		}
	}
	
	//删除批量申请
	@RequestMapping(value="alldel",produces="application/json;charset=utf-8")
	@ResponseBody
	public ServerRespose<String> alldel(String ids) {
		//String ids = stu.getS_number();        //ids和id都存在于实体类User
		String a[] = ids.split(",");
		try{
			int p=0;
			for (int i = 0; i < a.length; i++) {
				Integer id = Integer.valueOf(a[i]);
				Apply apply = applyDao.get(Apply.class, id);
				if(!apply.getApply_is().equals("已申请")){
					applyDao.delete(apply);
				}else {
					p=p+1;
				}
			}
			if(p>0){
				return new ServerRespose<String>(200, "无法删除"+p+"条已申请的，请同意或拒绝再删除！");
			}else {
				return new ServerRespose<String>(200, "删除成功！");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return new ServerRespose<String>(500, "删除失败！");
		}
	}

	// 导出excel
	@RequestMapping("doex")
	public void doex(HttpServletRequest request,HttpServletResponse res,HttpSession session) throws Exception {
		  //获取数据
		Society society = (Society) session.getAttribute("currentUser");
		Society society2 = societyDao.get(Society.class, society.getT_id());
		Set<Stu> setStu = society2.getSetStu();
		List<Stu> list = new ArrayList<Stu>();
		if(setStu!=null){
			for (Stu stu : setStu) {
				list.add(stu);
			}
		}
		System.out.println(list.size());
		HSSFWorkbook wb = new HSSFWorkbook();
	        // 2.在workbook中添加一个sheet，对应Excel中的一个sheet
	        HSSFSheet sheet = wb.createSheet("成员表");
	        // 3.在sheet中添加表头第0行，老版本poi对excel行数列数有限制short
	        HSSFRow row = sheet.createRow((int) 0);
	        // 4.创建单元格，设置值表头，设置表头居中
	        HSSFCellStyle style = wb.createCellStyle();
	        // 居中格式
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	   
	        // 设置表头
	        HSSFCell cell = row.createCell(0);
	        cell.setCellValue("学号");
	        cell.setCellStyle(style);
	        
	        cell = row.createCell(1);
	        cell.setCellValue("姓名");
	        cell.setCellStyle(style);
	   
	        cell = row.createCell(2);
	        cell.setCellValue("班级");
	        cell.setCellStyle(style);
	   
	        cell = row.createCell(3);
	        cell.setCellValue("年级");
	        cell.setCellStyle(style);
	   
	        cell = row.createCell(4);
	        cell.setCellValue("学院");
	        cell.setCellStyle(style);
	   
	        cell = row.createCell(5);
	        cell.setCellValue("电话号码");
	        cell.setCellStyle(style);
	        
	        for (int i = 0; i < list.size(); i++) {
	            row = sheet.createRow((int) i + 1);
	             Stu stu = list.get(i);
	            // 创建单元格，设置值
	             row.createCell(0).setCellValue(stu.getS_number());
	            row.createCell(1).setCellValue(stu.getS_name());
	            row.createCell(2).setCellValue(stu.getS_class());
	            row.createCell(3).setCellValue(stu.getS_grade());
	            row.createCell(4).setCellValue(stu.getS_college());
	            row.createCell(5).setCellValue(stu.getS_phone());
	          }
	        String fileName = society2.getT_society()+"成员表";
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        wb.write(os);
	        byte[] content = os.toByteArray();
	        InputStream is = new ByteArrayInputStream(content);
	        // 设置response参数，可以打开下载页面
	        res.reset();
	        res.setContentType("application/vnd.ms-excel;charset=utf-8");
	        res.setHeader("Content-Disposition", "attachment;filename="
	            + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
	        ServletOutputStream out = res.getOutputStream();
	        BufferedInputStream bis = null;
	        BufferedOutputStream bos = null;
	   
	        try {
	          bis = new BufferedInputStream(is);
	          bos = new BufferedOutputStream(out);
	          byte[] buff = new byte[2048];
	          int bytesRead;
	          // Simple read/write loop.
	          while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	            bos.write(buff, 0, bytesRead);
	          }
	        } catch (Exception e) {
	          // TODO: handle exception
	          e.printStackTrace();
	        } finally {
	          if (bis != null)
	            bis.close();
	          if (bos != null)
	            bos.close();
	        }

	}
}
