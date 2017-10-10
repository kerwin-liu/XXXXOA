package com.ljt.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/typeController")
public class TypeController {


	@Autowired
	private SystemService systemService;
	
	@RequestMapping(params="go")
	public ModelAndView go(HttpServletRequest request){
		
		return new ModelAndView("web/Typelist");
	}
	
	@RequestMapping(params="goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
		if(id.length()>0){
			String sql = "SELECT * FROM TYPE WHERE ID='"+id+"'";
			Map<String, Object> map = systemService.findOneForJdbc(sql);
			request.setAttribute("type", map);
		}else{
			
		}
		
		return new ModelAndView("web/TypeAdd");
	}

	@RequestMapping(params="tbdata")
	@ResponseBody
	public AjaxJson tbdata(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String sql = "SELECT * FROM TYPE";
		Map<String,Object> map = new HashMap<String, Object>();

		try {
	
			List<Map<String, Object>> list = systemService.findForJdbc(sql);
			
			map.put("list", list);
		} catch (Exception e) {
			// TODO: handle exception
			map.put("list", null);
		}
		
		json.setAttributes(map);
		
		return json;
	}
	
	@RequestMapping(params = "saveAndUpdate")
	public ModelAndView saveAndUpdate(HttpServletRequest request){
		String id=request.getParameter("id");
		String type = request.getParameter("type");
		String sql1="insert into `platform`.`type` (type) values('"+type+"')";
		String sql2="update `platform`.`type` set type='"+type+"' WHERE ID ='"+id+"'";
		if(id.length()>0){
			systemService.executeSql(sql2);
		}else{
			systemService.executeSql(sql1);
		}
		return new ModelAndView("web/Typelist");
	}
	
	@RequestMapping(params="deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		String sql = "DELETE FROM TYPE WHERE ID='"+id+"'";
		
		try {
			int num = systemService.executeSql(sql);
			if(num>0){
				json.setSuccess(true);
			}else{
				json.setSuccess(false);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			json.setSuccess(false);
			json.setMsg(e.getMessage());
		}
		
		return json;
	}	
	
	@RequestMapping(params="check")
	@ResponseBody
	public AjaxJson check(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String type = request.getParameter("type");
		String sql = "SELECT * FROM TYPE WHERE TYPE='"+type+"'";
		
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		if(list.size()>0){
			json.setSuccess(false);
		}else{
			json.setSuccess(true);
		}
		
		
		
		return json;
	}
	
	
}
