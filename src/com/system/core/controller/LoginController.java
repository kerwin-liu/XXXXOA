package com.system.core.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.system.core.entiy.TsFunction;
import com.system.core.entiy.TsRole_Function;
import com.system.core.entiy.TsUser;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/loginController")
public class LoginController {
	
	@Autowired
	public SystemService systemService;
	
	@RequestMapping(params = "login")
	public ModelAndView login(HttpServletRequest request){
		String username = String.valueOf(request.getSession().getAttribute("username"));
		if(("").equals(username)||null==username){
			return new ModelAndView("login");
		}else{
			request.setAttribute("username", username);
			TsUser tsUser = systemService.findUniqueByProperty(TsUser.class, "username", username);
			List<TsFunction> ss = systemService.loadAll(TsFunction.class,"desc","functionOrder");
			List<TsFunction> functions2 = new ArrayList<TsFunction>();
			List<TsRole_Function> functions = systemService.findByProperty(TsRole_Function.class,"tsRole.id", tsUser.getTsRole().getId());
			for(TsFunction function:ss){
				for(TsRole_Function role_Function :functions){
					if((role_Function.getTsFunction().getId()).equals(function.getId())){
						if(function.getType().equals("0")){
							functions2.add(function);
						}
					}
					
				}
				
			}
			
			request.setAttribute("rid",tsUser.getTsRole().getId());
			request.setAttribute("list", functions2);
			
			return new ModelAndView("web/main");
		}
	}
	@RequestMapping(params = "exit")
	public ModelAndView exit(HttpServletRequest request){
		request.getSession().setAttribute("username", "退出");
		//new ModelAndView(new RedirectView("loginController.do?login"));
		return new ModelAndView(new RedirectView("loginController.do?login"));
	}
	
	@RequestMapping(params="goUpdate")
	public ModelAndView goUpdate(){
		
		return new ModelAndView("web/updatepwd");
	}
	
	@RequestMapping(params="updatePassword")
	@ResponseBody
	public AjaxJson updatePassword(HttpServletRequest request){
		AjaxJson ajaxJson = new AjaxJson();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String newpwd = request.getParameter("newpwd");
		
		String sql = " select * from t_s_user where username='"+username+"' and password = '"+password+"'";
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		if(list.size()>0){
			String sql1="update t_s_user set PASSWORD='"+newpwd+"' where id='"+list.get(0).get("id")+"' ";
			int a =systemService.executeSql(sql1);
			if(a>0){
				ajaxJson.setMsg("更新成功");
				ajaxJson.setSuccess(true);
			}
		}else{
			ajaxJson.setMsg("原始密码不正确！请重新输入！");
			ajaxJson.setSuccess(false);
		}
		return ajaxJson;
	}

	@RequestMapping(params = "check")
	@ResponseBody
	public AjaxJson check(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String username = request.getParameter("uname");
		String pwd = request.getParameter("pwd");
		
		TsUser user = systemService.findUniqueByProperty(TsUser.class, "username", username);
		String pwd1 = user.getPassword();
		if(pwd.equals(pwd1)){
			request.getSession().setAttribute("username", username);
			json.setSuccess(true);
		}else{
			json.setSuccess(false);
		}
		
		return json;
	}
	
	
}
