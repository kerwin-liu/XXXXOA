package com.ljt.project.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.system.util.AjaxJson;
import com.system.util.entiy.ReadExcel;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/projectController")
public class ProjectController {

	@Autowired
	private SystemService systemService;

	@RequestMapping(params = "go")
	public ModelAndView go(HttpServletRequest request) {

		request.setAttribute("error", null);
		return new ModelAndView("web/project");
	}

	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request) {

		String id = request.getParameter("id");

		String sql = "select * from project where id='" + id + "'";

		Map<String, Object> map = systemService.findOneForJdbc(sql);

		request.setAttribute("m", map);

		return new ModelAndView("web/projectAdd");
	}

	@RequestMapping(params = "addAndSave")
	public ModelAndView addAndSave(HttpServletRequest request) {
		String id = request.getParameter("id");
		String name1 = request.getParameter("names1");
		String name2 = request.getParameter("names2");
		String price = request.getParameter("price");
		String num = request.getParameter("num");
		String balance1 = request.getParameter("balance1");
		String balance2 = request.getParameter("balance2");
		String balance3 = request.getParameter("balance3");
		String time = request.getParameter("time");
		String sql = "insert into project (`NAME1`,`NAME2`,`PRICE`,`NUM`,`BAlANCE1`,`BAlANCE2`,`BAlANCE3`,`TIME`) values('"
				+ name1
				+ "','"
				+ name2
				+ "','"+price+"','"+num+"','"
				+ balance1
				+ "','"
				+ balance2
				+ "','" + balance3 + "','" + time + "')";
		String updata = "update project set name1='" + name1 + "',name2='"+ name2 + "', price = '"+price+"' , num = '"+num+"',balance1='" + balance1 + "',balance2='" + balance2
				+ "',balance3='" + balance3 + "' where id='" + id + "'";

		
		
		if (id.length() > 0) {
			systemService.executeSql(updata);

		} else {
			String sql1="SELECT * FROM PROJECT WHERE NAME1='"+name1+"' AND NAME2 ='"+name2+"' AND BALANCE1='"+balance1+"' AND "
					+ " BALANCE2='"+balance2+"' AND TIME ='"+time+"'";
			List<Map<String, Object>> list = systemService.findForJdbc(sql1);
			if(list.size()>0){
				request.setAttribute("error", "插入的已存在");
			}else{
				systemService.executeSql(sql);
			}
		}

		return new ModelAndView("web/project");
	}

	@RequestMapping(params = "tbdata")
	@ResponseBody
	public AjaxJson tbdata(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();

		String name1 = request.getParameter("names1");
		String name2 = request.getParameter("names2");
		String balance2 = request.getParameter("balance2");
		String time1 = request.getParameter("time1");
		String time2 = request.getParameter("time2");

		String sql = "select * from project where 1=1";
		String sql1 = "SELECT SUM(BALANCE1) AS NUM FROM PROJECT where 1=1";
		String sql2 = "SELECT SUM(NUM) AS NUM FROM PROJECT where 1=1";

		if (!"0".equals(name1)) {

			sql = sql + " and name1 like '%" + name1 + "%'";
			sql1 = sql1 + " and name1 like '%" + name1 + "%'";
			sql2 = sql2 + " and name1 like '%" + name1 + "%'";

		}
		if (!"0".equals(name2)) {

			sql = sql + " and name2 like '%" + name2 + "%'";
			sql1 = sql1 + " and name2 like '%" + name2 + "%'";
			sql2 = sql2 + " and name2 like '%" + name2 + "%'";
		}
		if (!"0".equals(balance2)) {
			sql = sql + " and balance2 like '%" + balance2 + "%'";
			sql1 = sql1 + " and balance2 like '%" + balance2 + "%'";
			sql2 = sql2 + " and balance2 like '%" + balance2 + "%'";
		}
		if (!time1.equals(time2)) {
			sql = sql
					+ " and DATE_FORMAT(TIME,'%Y%m%d%H%i%s') between  DATE_FORMAT('"
					+ time1 + "','%Y%m%d%H%i%s') and DATE_FORMAT('" + time2
					+ "','%Y%m%d%H%i%s')";
			sql1 = sql1
					+ " and DATE_FORMAT(TIME,'%Y%m%d%H%i%s') between  DATE_FORMAT('"
					+ time1 + "','%Y%m%d%H%i%s') and DATE_FORMAT('" + time2
					+ "','%Y%m%d%H%i%s')";
			sql2 = sql2
					+ " and DATE_FORMAT(TIME,'%Y%m%d%H%i%s') between  DATE_FORMAT('"
					+ time1 + "','%Y%m%d%H%i%s') and DATE_FORMAT('" + time2
					+ "','%Y%m%d%H%i%s')";
		}

		List<Map<String, Object>> list = systemService.findForJdbc(sql);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list", list);

		j.setObj(systemService.findOneForJdbc(sql1).get("NUM")+","+systemService.findOneForJdbc(sql2).get("NUM"));
		j.setAttributes(map);
		
		return j;
	}

	@RequestMapping(params = "deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request) {
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");

		String sql = "DELETE FROM project WHERE ID = '" + id + "' ";

		systemService.executeSql(sql);

		return json;
	}

	@RequestMapping(params = "name1")
	@ResponseBody
	public AjaxJson name1() {
		AjaxJson j = new AjaxJson();

		String sql = "select DISTINCT name1 as id,name1 as text from project";

		List<Map<String, Object>> list = systemService.findForJdbc(sql);

		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("id", "0");
		maps.put("text", "请选择----");
		maps.put("selected", true);
		list.add(0, maps);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list", list);

		j.setAttributes(map);

		return j;
	}

	@RequestMapping(params = "name2")
	@ResponseBody
	public AjaxJson name2() {
		AjaxJson j = new AjaxJson();

		String sql = "select DISTINCT name2 as id,name2 as text from project";

		List<Map<String, Object>> list = systemService.findForJdbc(sql);

		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("id", "0");
		maps.put("text", "请选择----");
		maps.put("selected", true);
		list.add(0, maps);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list", list);

		j.setAttributes(map);
		return j;
	}

	@RequestMapping(params = "type")
	@ResponseBody
	public AjaxJson type(HttpServletRequest request) {
		AjaxJson json = new AjaxJson();
		String sql = "SELECT TYPE AS ID,TYPE AS TEXT FROM TYPE";
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		if (list.size() > 0) {
			list.get(0).put("selected", true);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		json.setAttributes(map);

		return json;
	}

	@RequestMapping(params = "type1")
	@ResponseBody
	public AjaxJson type1(HttpServletRequest request) {
		AjaxJson json = new AjaxJson();
		String sql = "SELECT TYPE AS ID,TYPE AS TEXT FROM TYPE";
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("ID", "0");
		maps.put("TEXT", "请选择----");
		maps.put("selected", true);
		list.add(0, maps);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		json.setAttributes(map);

		return json;
	}

	@RequestMapping(params = "impgo")
	public ModelAndView impgo() {
		return new ModelAndView("web/imports");
	}

	@RequestMapping(params = "imports")
	@ResponseBody
	public AjaxJson imports(HttpServletRequest request) {
		AjaxJson json = new AjaxJson();
		ReadExcel r = new ReadExcel();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		String errors = "";
		String ss="";
		try {
			List<FileItem> list = upload.parseRequest(request);
			for (int i = 0; i < list.size(); i++) {
				FileItem item = list.get(i);
				if (item.isFormField()) {
					// 输出表单字段值
					System.out.println(new String(item.getString().getBytes(
							"ISO-8859-1"), "utf-8"));
				} else {
					String fileName = item.getName();
					String extName = fileName.substring(fileName
							.lastIndexOf("."));
					// 生成UUID文件名
					String newName = UUID.randomUUID().toString();
					String rootPath = request.getServletContext().getRealPath(
							"\\upload");
					String newPath = rootPath + "/" + newName + extName;

					item.write(new File(newPath));
					// euc.ConnectorDatabase(newPath);
					Map<String, Object> maps = r.readExcelFile(newPath);
					Set<String> set = maps.keySet();
					for (String string : set) {
						String sql[] = string.split(";");
						List<Map<String, Object>> list2=systemService.findForJdbc(sql[0]);
						if(list2.size()>0){
								ss += string+",";
						}else{
							int num = systemService.executeSql(sql[1]);
							if (num == 0) {
								errors += string + ",";
								json.setSuccess(false);
							}
						}
						
					}

				}
			}

		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		json.setMsg(errors);
		json.setObj(ss);
		return json;
	}

	@RequestMapping(params = "exports")
	@ResponseBody
	public AjaxJson exports(HttpServletRequest request) {
		AjaxJson json = new AjaxJson();
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet();
		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row = sheet.createRow((int) 0);
		// 第四步，创建单元格，并设置值表头 设置表头居中
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
		sheet.setColumnWidth(0, 3500);
		sheet.setColumnWidth(1, 3500);
		sheet.setColumnWidth(2, 3500);
		sheet.setColumnWidth(3, 2800);
		sheet.setColumnWidth(4, 2800);
		sheet.setColumnWidth(5, 7000);
		
		
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellValue("对方姓名");
		cell.setCellStyle(style);
		cell = row.createCell((short) 1);
		cell.setCellValue("对方账号");
		cell.setCellStyle(style);
		cell = row.createCell((short) 2);
		cell.setCellValue("收入/支出金额");
		cell.setCellStyle(style);
		cell = row.createCell((short) 3);
		cell.setCellValue("类型");
		cell.setCellStyle(style);
		cell = row.createCell((short) 4);
		cell.setCellValue("备注");
		cell.setCellStyle(style);
		cell = row.createCell((short) 5);
		cell.setCellValue("交易时间");
		cell.setCellStyle(style);
		
		String sql="SELECT * FROM PROJECT";
		List<Map<String, Object>> list=systemService.findForJdbc(sql);
		for (int i = 0; i < list.size(); i++) {
			row = sheet.createRow((int) i + 1);
			row.createCell((short) 0).setCellValue(list.get(i).get("NAME1").toString()); 
			row.createCell((short) 1).setCellValue(list.get(i).get("NAME2").toString());
			row.createCell((short) 2).setCellValue(list.get(i).get("BALANCE1").toString());
			row.createCell((short) 3).setCellValue(list.get(i).get("BALANCE2").toString());
			row.createCell((short) 4).setCellValue(list.get(i).get("BALANCE3").toString());
			row.createCell((short) 5).setCellValue(list.get(i).get("TIME").toString()); 
		}
		 FileOutputStream fout;
		 
		 Date date = new Date();
		 SimpleDateFormat format = new SimpleDateFormat("YYYYMMDDhhmm");
		 
		 String path="D:/"+format.format(date)+".xls";
		try {
			fout = new FileOutputStream(path);
			 wb.write(fout);  
	         fout.close();  
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
        json.setMsg(path);
	
		return json;
	}
	
	@RequestMapping(params="look")
	public ModelAndView look(HttpServletRequest request){
		request.setAttribute("error", null);
		return new ModelAndView("web/project1");
	}
}
