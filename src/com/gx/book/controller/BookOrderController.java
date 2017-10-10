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

import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonObject;
import com.gx.book.entiy.BookOrder;
import com.gx.book.entiy.Book_Order;
import com.gx.book.entiy.Books;
import com.system.util.AjaxJson;
import com.system.util.service.SystemService;

import dm.jdbc.byacc.t;

@Scope("prototype")
@Controller
@RequestMapping("/bookOrderController")
public class BookOrderController {

	@Autowired
	private SystemService systemService;
	
	@RequestMapping(params = "go")
	public ModelAndView go(HttpServletRequest request){
		
		return new ModelAndView("web/bookOrderlist");
	}
	
	@RequestMapping(params = "goadd")
	public ModelAndView goadd(HttpServletRequest request){
		String id = request.getParameter("id");
		String tid = request.getParameter("tid");
		BookOrder order = systemService.get(BookOrder.class, id);
		List<Book_Order> book_Order = systemService.findByProperty(Book_Order.class, "bookOrder.id", id);
		if(book_Order.size()>0){
			request.setAttribute("border", book_Order.get(0));
		}else{
			request.setAttribute("border", null);
		}
		request.setAttribute("tid", tid);
		request.setAttribute("order", order);
		
		
		return new ModelAndView("web/BookOrderAdd");
	}
	
	@RequestMapping(params = "saveAndUpdate")
	public ModelAndView saveAndUpdate(HttpServletRequest request){
		String id = request.getParameter("id");
		String bookid = request.getParameter("bookid");
		String num  = request.getParameter("bookStocks");
		String time = request.getParameter("time");
		String tid = request.getParameter("tid");
		Books books = systemService.get(Books.class, bookid);
		BookOrder order = new BookOrder();
		order.setNum(num);
		
		order.setTime(time);
		if(id.length()>0){
			order.setId(id);
			systemService.updateEntitie(order);
		}else{
			systemService.save(order);
		}
		Book_Order book_Order = new Book_Order();
		book_Order.setBook(books);
		book_Order.setBookOrder(order);
		if(id.length()>0){
			book_Order.setId(tid);
			systemService.updateEntitie(book_Order);
		}else{
			systemService.save(book_Order);
		}
		
		return new ModelAndView("web/bookOrderlist");
	}
	
	@RequestMapping(params ="BOData")
	@ResponseBody
	public AjaxJson BookOrderData(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		
		String sql = "SELECT T1.ID AS TID , T2.ID ,T3.BOOKNAME AS BOOK , T2.NUM AS NUM ,t2.TIME AS TIME FROM BOOK_ORDER AS T1 LEFT JOIN T_BOOKORDER AS T2  ON T1.BR_ID = T2.ID "
				+ " LEFT JOIN T_BOOK AS T3 ON T1.B_ID = T3.ID ";
		
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		json.setAttributes(map);
		
		return json;
	}
	
	@RequestMapping(params ="deletes")
	@ResponseBody
	public AjaxJson deletes(HttpServletRequest request){
		AjaxJson json = new AjaxJson();
		String id = request.getParameter("id");
		systemService.deleteEntityById(BookOrder.class, id);
		return json;
	}
	
	@RequestMapping(params ="Border")
	public ModelAndView Border(HttpServletRequest request){
		String id = request.getParameter("id");
		request.setAttribute("id", id);
		String sql="SELECT NUM  FROM T_BOOKORDER  RIGHT JOIN  ID='"+id+"'";
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		//List<Book_Order> list = systemService.findByProperty(Book_Order.class, "bookOrder.id", id);
		JSONObject jsonObject = new JSONObject();
		request.setAttribute("list", jsonObject.toJSONString(list));
		return new ModelAndView("web/OrderAdd");
	}
	
	@RequestMapping(params = "saveorder")
	
	public ModelAndView saveorder(HttpServletRequest request){
		String id = request.getParameter("id");
		BookOrder bookOrder = systemService.get(BookOrder.class,id);
		List<Book_Order> list = systemService.findByProperty(Book_Order.class,"bookOrder", bookOrder);
		for(int i=0;i<list.size();i++){
			systemService.deleteEntityById(Book_Order.class, list.get(i).getId());
		}
		String bid = request.getParameter("bid");
		String bids[] = bid.split(",");
		for (int i = 0; i < bids.length; i++) {
			if(bids[i].trim().length()>0){
				Books books = systemService.get(Books.class, bids[i]);
				Book_Order order = new Book_Order();
				order.setBook(books);
				order.setBookOrder(bookOrder);
				systemService.save(order);
			}
		}
		
		return new ModelAndView("web/bookOrderlist");
	}
	
	@RequestMapping(params="looks")
	public ModelAndView looks(HttpServletRequest request){
		String id = request.getParameter("id");
		request.setAttribute("id", id);
		return new ModelAndView("web/looks");
	}
	
	@RequestMapping(params = "lookdata")
	@ResponseBody
	public AjaxJson lookdata(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String id = request.getParameter("id");
		//List<Book> books = systemService.loadAll(Book.class);
		List<Map<String, Object>> books = systemService.findForJdbc("SELECT * FROM T_BOOK WHERE ID IN (SELECT B_ID FROM BOOK_ORDER WHERE BR_ID='"+id+"')");
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list",books);
		
		j.setMsg("");
		j.setAttributes(map);
		
		return j;
	}
	
	@RequestMapping(params = "getEcharts")
	@ResponseBody
	public AjaxJson getEcharts(){
		AjaxJson j = new AjaxJson();
		String sql = "SELECT T3.BOOKNAME AS CPN , T2.NUM AS NUM FROM BOOK_ORDER AS T1 LEFT JOIN T_BOOKORDER AS T2  ON T1.BR_ID = T2.ID "
					+ " LEFT JOIN T_BOOK AS T3 ON T1.B_ID = T3.ID ORDER BY T2.NUM  LIMIT 0, 10";
		 List<Map<String, Object>> list = systemService.findForJdbc(sql);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		j.setAttributes(map);
		
		return j;
	}
	
}
