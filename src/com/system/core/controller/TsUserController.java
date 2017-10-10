package com.system.core.controller;

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

import com.system.core.entiy.TsRole;
import com.system.core.entiy.TsUser;
import com.system.core.service.TsUserService;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/tsUserController")
public class TsUserController {

	@Autowired
	private TsUserService tsUserService;
	

	@Autowired
	private SystemService systemService;
	
	@RequestMapping(params = "go")
	public ModelAndView go(HttpServletRequest request){
		
		return new ModelAndView("web/tsuserlist");
	}

	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request){
		
		String id = request.getParameter("id");
		
		TsUser tsUser = systemService.get(TsUser.class, id);
		
		List<TsRole> roles = systemService.loadAll(TsRole.class);
		
		request.setAttribute("user", tsUser);
		request.setAttribute("list", roles);
		
		return new ModelAndView("web/tsuserAdd");
	}
	
	@RequestMapping(params="save")
	public ModelAndView save(HttpServletRequest request,TsUser tsUser){
		String id = request.getParameter("rid");
		TsRole role = systemService.get(TsRole.class, id);
		tsUser.setTsRole(role);
		if(tsUser.getId().length()>0){
			systemService.updateEntitie(tsUser);
		}else{
			systemService.save(tsUser);
		}
		return new ModelAndView("web/tsuserlist");
	}
	@RequestMapping(params = "userdata")
	@ResponseBody
	public AjaxJson userdata(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		List<TsUser> tsUsers = systemService.loadAll(TsUser.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", tsUsers);
		
		json.setAttributes(map);
		
		return json;
	}
	@RequestMapping(params = "deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String  id = request.getParameter("id");
		systemService.deleteEntityById(TsUser.class, id);
		return j;
	}
	
}
