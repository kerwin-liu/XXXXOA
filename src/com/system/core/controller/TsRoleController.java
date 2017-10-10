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

import com.system.core.entiy.TsFunction;
import com.system.core.entiy.TsRole;
import com.system.core.entiy.TsRole_Function;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/tsRoleController")
public class TsRoleController {

	@Autowired
	private SystemService systemService;

	@RequestMapping(params ="go")
	public ModelAndView go(){
		
		return new ModelAndView("web/tsrolelist");
	}
	
	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
			TsRole tsRole = systemService.get(TsRole.class, id);
		request.setAttribute("role", tsRole);
		
		return new ModelAndView("web/tsroleAdd");
	}
	
	@RequestMapping(params ="tsRoleData")
	@ResponseBody
	public AjaxJson tsRoleData(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		List<TsRole> roles = systemService.loadAll(TsRole.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", roles);
		
		json.setAttributes(map);
		
		return json;
	}
	
	@RequestMapping(params = "save")
	public ModelAndView save(HttpServletRequest request,TsRole tsRole){
		
		if(tsRole.getId().length()>0){
			systemService.updateEntitie(tsRole);
		}else{
			systemService.save(tsRole);
		}
		
		return new ModelAndView("web/tsrolelist");
	}
	
	@RequestMapping(params = "deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String id = request.getParameter("id");
		systemService.deleteEntityById(TsRole.class, id);
		return j;
	}
	
	@RequestMapping(params = "functiondata")
	@ResponseBody
	public AjaxJson functiondata(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		
		String id = request.getParameter("id");
		//List<TsFunction> tsFunctions = systemService.loadAll(TsFunction.class,"asc","functionOrder");
		String sql = "SELECT * FROM t_s_function ";
		List<Map<String, Object>> maps = systemService.findForJdbc(sql);
		List<Map<String, Object>> ss = tsmenu(maps);
		
		List<TsRole_Function> role_Functions = systemService.findByProperty(TsRole_Function.class, "tsRole.id", id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", ss);
		map.put("role", role_Functions);
		
		j.setAttributes(map);
		
		return j;
	}
	
	@RequestMapping(params = "saveRole")
	@ResponseBody
	public AjaxJson saveRole(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String roleid= request.getParameter("roleid");
		
		String fids = request.getParameter("fid");
		
		TsRole tsRole = systemService.get(TsRole.class, roleid);
		
		String fid[] = fids.split(",");
		
		List<TsRole_Function> functions = systemService.findByProperty(TsRole_Function.class, "tsRole.id",roleid);
		
		for (TsRole_Function tsRole_Function : functions) {
			systemService.deleteEntityById(TsRole_Function.class, tsRole_Function.getId());
		}

		
		
		for (String string : fid) {
			TsFunction tsFunction = systemService.get(TsFunction.class, string);
			TsRole_Function role_Function = new TsRole_Function();
			role_Function.setTsFunction(tsFunction);
			role_Function.setTsRole(tsRole);
			systemService.save(role_Function);
			
		}
		
		return j;
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
	
}
