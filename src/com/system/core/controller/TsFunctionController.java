package com.system.core.controller;

import java.util.ArrayList;
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.system.core.entiy.TsFunction;
import com.system.core.entiy.TsRole_Function;
import com.system.core.service.TsFunctionService;
import com.system.util.AjaxJson;
import com.system.util.entiy.TsMenu;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/tsFunctionController")
public class TsFunctionController {

	@Autowired
	private TsFunctionService tsFunctionService;
	
	@Autowired
	private SystemService systemService;
	
	@RequestMapping(params = "functionList")
	public ModelAndView FunctionList(){
		
		return new ModelAndView("web/tsFunctionlist");
	}
	@RequestMapping(params="functionData",produces = "application/json; charset=utf-8")
	@ResponseBody
	public AjaxJson FunctionData(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String sql = "SELECT * FROM t_s_function ";
		List<Map<String, Object>> maps = systemService.findForJdbc(sql);
		List<Map<String, Object>> ss = tsmenu(maps);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", ss);
		j.setAttributes(map);
		
		return j;
	}
	
	
	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
			TsFunction list =systemService.get(TsFunction.class, id);
			request.setAttribute("ss", list);
		
		return new ModelAndView("web/tsFunctionAdd");
	}
	
	
	@RequestMapping(params = "menu",produces = "application/json; charset=utf-8")
	@ResponseBody
	public AjaxJson menu(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String rid = request.getParameter("rid");
		String fid = request.getParameter("fid");
		
		String sql = "SELECT * FROM t_s_function where id in (SELECT F_ID FROM t_s_role_function WHERE R_ID='"+rid+"')";
		List<Map<String, Object>> maps = systemService.findForJdbc(sql);
		List<Map<String, Object>> ss = lmenu(maps,fid);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", ss);
		j.setAttributes(map);
		return j;
	}
	
	@RequestMapping(params = "save")
	public ModelAndView save(HttpServletRequest request,TsFunction tsFunction){
		String menus = tsFunction.getType();
		if(menus.equals("0")){
			
		}
		if(menus.equals("1")){
			String id = request.getParameter("menu");
			TsFunction tsFunction2 = systemService.get(TsFunction.class, id);
			tsFunction.setTsFunction(tsFunction2);
		}
		if(tsFunction.getId().length()>0){
			systemService.updateEntitie(tsFunction);
		}else{
		systemService.save(tsFunction);
		}
		
		return new ModelAndView("web/tsFunctionlist");
	}
	
	@RequestMapping(params = "deletes",produces = "application/json; charset=utf-8")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		systemService.deleteEntityById(TsFunction.class, id);
		return json;
	}
	
	@RequestMapping(params = "menudata")
	@ResponseBody
	public AjaxJson menudata(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String sql = "SELECT * FROM t_s_function ";
		List<Map<String, Object>> maps = systemService.findForJdbc(sql);
		List<Map<String, Object>> ss = tsmenu(maps);
		//List<TsFunction> ss = systemService.loadAll(TsFunction.class,"asc","functionOrder");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", ss);
		json.setAttributes(map);
		return json;
	}
	public List<Map<String, Object>> tsmenu(List<Map<String, Object>> list){
		List<Map<String, Object>> list1= new ArrayList<Map<String,Object>>();
		for(int i=0;i<list.size();i++){
			if(null==list.get(i).get("PARENTFUNCTIONID")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", list.get(i).get("ID"));
				map.put("text",list.get(i).get("FNAME"));
				map.put("url", list.get(i).get("FURL"));
				map.put("order", list.get(i).get("FORDER"));
				List<Map<String, Object>> list2 = cmenu(list, list.get(i).get("ID").toString());
				map.put("children", list2);
				list1.add(map);
			}
					
		}
		return list1;
	}
	
	public List<Map<String, Object>> cmenu(List<Map<String, Object>> list,String id){
	List<Map<String, Object>> list2= new ArrayList<Map<String,Object>>();
		for(int i=0;i<list.size();i++){
			Map<String, Object> map= new HashMap<String, Object>();
				try {
					if(list.get(i).get("PARENTFUNCTIONID").equals(id)){
						map.put("id",list.get(i).get("ID"));
						map.put("text", list.get(i).get("FNAME"));
						map.put("url", list.get(i).get("FURL"));
						map.put("order", list.get(i).get("FORDER"));
						List<Map<String, Object>> list3 = cmenu(list, list.get(i).get("ID").toString());
						if(list3.size()>0){
							map.put("children", list3);
							list2.add(map);
						}else{
							list2.add(map);
						}
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
				
	}
		return list2;
	}
	
	public List<Map<String, Object>> lmenu(List<Map<String, Object>> list,String id){
		List<Map<String, Object>> list2= new ArrayList<Map<String,Object>>();
			for(int i=0;i<list.size();i++){
				Map<String, Object> map= new HashMap<String, Object>();
					try {
						if(list.get(i).get("PARENTFUNCTIONID").equals(id)){
							map.put("id",list.get(i).get("ID"));
							if(list.get(i).get("FURL").toString().length()>0){
							map.put("text","<a id='btn1' href='#' onclick=addSameOneTab('"+list.get(i).get("FNAME")+"','"+list.get(i).get("FURL")+"')>"+list.get(i).get("FNAME")+"</a>");
							}else{
								map.put("text","<a id='btn1' href='#'>"+list.get(i).get("FNAME")+"</a>");
							}
							List<Map<String, Object>> list3 = cmenu(list, list.get(i).get("ID").toString());
							if(list3.size()>0){
								map.put("children", list3);
								list2.add(map);
							}else{
								list2.add(map);
							}
						}
					} catch (Exception e) {
						// TODO: handle exception
					}
		}
			return list2;
		}
}
