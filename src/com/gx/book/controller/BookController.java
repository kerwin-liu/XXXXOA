package com.gx.book.controller;

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

import com.gx.book.entiy.Books;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;


@Scope("prototype")
@Controller
@RequestMapping("/bookController")
public class BookController {

	@Autowired
	public SystemService systemService;
	
	@RequestMapping(params = "Books")
	public ModelAndView Books(HttpServletRequest request){
		return new ModelAndView("web/Book");
	}
	
	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
		Books book = systemService.get(Books.class, id);
		request.setAttribute("book", book);
		return new ModelAndView("web/bookAdd");
	}
	
	@RequestMapping(params = "bookdata",produces = "application/json; charset=utf-8")
	@ResponseBody
	public AjaxJson bookdata(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		//List<Book> books = systemService.loadAll(Book.class);
		List<Map<String, Object>> books = systemService.findForJdbc("SELECT * FROM T_BOOK");
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list",books);
		
		j.setMsg("");
		j.setAttributes(map);
		
		return j;
	}
	
	
	@RequestMapping(params = "save")
	public ModelAndView save(HttpServletRequest request ,Books book){
		String id = book.getId();
		if(id.length()>0){
			systemService.updateEntitie(book);
		}
		systemService.save(book);
		
		return new ModelAndView("web/Book");
	}
	
	@RequestMapping(params = "deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		systemService.deleteEntityById(Books.class, id);
		return json;
	}
	
	@RequestMapping(params = "getEcharts")
	@ResponseBody
	public AjaxJson getEcharts(){
		AjaxJson j = new AjaxJson();
		
		String sql = "SELECT BOOKNAME AS NAME, BOOKNUM AS VALUE FROM T_BOOK ORDER BY BOOKNUM";
		
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		j.setAttributes(map);
		
		return j;
	}
}
