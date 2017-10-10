package com.gx.book.core;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.system.core.entiy.TsUser;
import com.system.util.service.SystemService;



public class AuthInterceptor implements HandlerInterceptor{
	
	@Autowired
    private SystemService systemService;
	
	private List<String> excludeUrls;
	 
    public List<String> getExcludeUrls() {
        return excludeUrls;
    }

    public void setExcludeUrls(List<String> excludeUrls) {
        this.excludeUrls = excludeUrls;
    }
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object object) throws Exception {
		// TODO Auto-generated method stub
		String requestPath = request.getRequestURI() + "?" + request.getQueryString();
        if (requestPath.indexOf("&") > -1) {// 去掉其他参数
            requestPath = requestPath.substring(0, requestPath.indexOf("&"));
        }
        requestPath = requestPath.substring(request.getContextPath().length() + 1);
		String username = request.getParameter("UserName");
		String password = request.getParameter("PassWord");
		if(!requestPath.equals("loginController.do?login")){
			return true;
		}
		if("退出".equals(request.getSession().getAttribute("username"))){
				request.getSession().setAttribute("username", "");
				response.sendRedirect("login.jsp");
				return false;
		}else{
				TsUser tsUser = systemService.findUniqueByProperty(TsUser.class, "username", username);
				if((null!=tsUser)&&password.equals(tsUser.getPassword())){
					request.getSession().setAttribute("username", username);
					return true;
				}else{
					if(null!=request.getSession().getAttribute("username")&&!"".equals(request.getSession().getAttribute("username"))){
						return true;
					}else{
						request.getSession().setAttribute("username", "");
						response.sendRedirect("login.jsp");
						return false;	
					}
				}
		}
	}
	 /**
     * 转发
     * @param user
     * @param req
     * @return
     */
    public ModelAndView forword(HttpServletRequest request) {
        return new ModelAndView("login");
    }
}
