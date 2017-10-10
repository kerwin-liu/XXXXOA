package com.gx.book.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.gx.book.entiy.BookSale;
import com.gx.book.entiy.Books;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

@Scope("prototype")
@Controller
@RequestMapping("/bookSaleController")
public class BookSaleController {

	@Autowired
	private SystemService systemService;
	
	@RequestMapping(params = "go")
	public ModelAndView go(HttpServletRequest request){
		
		
		
		return new ModelAndView("web/bookSalelist");
	}
	
	@RequestMapping(params ="goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
		BookSale sale = systemService.get(BookSale.class, id);
		request.setAttribute("sale", sale);
		return new ModelAndView("web/BookSaleAdd");
	}
	
	@RequestMapping(params = "save")
	public ModelAndView save(HttpServletRequest request,BookSale sale){
		String book = request.getParameter("bookid");
		Books books = systemService.get(Books.class, book);
		
		//BookSale sale2 = systemService.get(BookSale.class, sale.getId());
		String num2 = request.getParameter("num2");
		int num =0;
		if(num2.length()>0){
			num = Integer.valueOf(books.getBookStocks())-(Integer.valueOf(sale.getNum())-Integer.valueOf(num2));
		}else{
			num = Integer.valueOf(books.getBookStocks())-(Integer.valueOf(sale.getNum()));
		}
		books.setBookStocks(num+"");
		sale.setBook(books);
		if(sale.getId().length()>0){
		systemService.updateEntitie(sale);	
		}else{
			systemService.save(sale);
		}
		return new ModelAndView("web/bookSalelist");
	}
	
	@RequestMapping(params = "BookSaleData")
	@ResponseBody
	public AjaxJson BookSaleData(){
		AjaxJson j = new AjaxJson();
		String sql = "SELECT S.ID, B.BOOKNAME AS BNAME,S.NUM AS SNUM,S.TIME FROM T_BOOKSALE AS S LEFT JOIN T_BOOK AS B"
				+ " ON S.B_ID =B.ID";
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		j.setAttributes(map);
		
		return j;
	}
	
	@RequestMapping(params = "books")
	@ResponseBody
	public AjaxJson books(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String sql = "SELECT ID ,BOOKNAME AS TEXT FROM T_BOOK";
		
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		if(list.size()>0){
			list.get(0).put("selected", true);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		j.setAttributes(map);
		
		
		return j;
	}
	
	
	
	@RequestMapping(params = "deletes")
	@ResponseBody
	public AjaxJson  deletes(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		System.err.println(id);
		systemService.deleteEntityById(BookSale.class, id);
		return json;
	}
	
	@RequestMapping(params = "booknum")
	@ResponseBody
	public AjaxJson booknum(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		Books books = systemService.get(Books.class, id);
		String num = books.getBookStocks();
		json.setMsg(num);
		return json;
	}
	@RequestMapping(params = "getEcharts")
	@ResponseBody
	public AjaxJson getEcharts(){
		AjaxJson j = new AjaxJson();
		
		String sql = "SELECT  BK.BOOKNAME,TB.NUM FROM T_BOOKSALE AS TB LEFT JOIN T_BOOK AS BK ON TB.B_ID = BK.ID   ORDER BY TB.NUM ";
	
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		List<Map<String, Object>> list2 = new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < (list.size()>5?5:list.size()); i++) {
			list2.add(list.get(i));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list2);
		
		j.setAttributes(map);
		
		return j;
	}
	
	
}
