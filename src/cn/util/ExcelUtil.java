package cn.util;

import java.io.FileOutputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import cn.entity.Stu;

/**
 * @作者 yan
 * @创建日期
 * @版本 V1.0
 * @描述 Excel 导出通用工具类
 */
public class ExcelUtil {

    public static void export(List<Stu> list) throws Exception {

    	// 1.创建一个workbook，对应一个Excel文件
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
        cell.setCellValue("姓名");
        cell.setCellStyle(style);
   
        cell = row.createCell(1);
        cell.setCellValue("班级");
        cell.setCellStyle(style);
   
        cell = row.createCell(2);
        cell.setCellValue("年级");
        cell.setCellStyle(style);
   
        cell = row.createCell(3);
        cell.setCellValue("学院");
        cell.setCellStyle(style);
   
        cell = row.createCell(4);
        cell.setCellValue("电话号码");
        cell.setCellStyle(style);
        for (int i = 0; i < list.size(); i++) {
            row = sheet.createRow((int) i + 1);
             Stu stu = list.get(i);
            // 创建单元格，设置值
            row.createCell(0).setCellValue(stu.getS_name());
            row.createCell(1).setCellValue(stu.getS_class());
            row.createCell(2).setCellValue(stu.getS_grade());
            row.createCell(3).setCellValue(stu.getS_college());
            row.createCell(4).setCellValue(stu.getS_phone());
          }
        FileOutputStream out =new FileOutputStream("E:/XXX.xls");
        wb.write(out); 
        out.close();


    }
}