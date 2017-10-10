package com.gx.book.entiy;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name = "T_BOOKORDER")
@JsonIgnoreProperties(value={"book_Orders"})
public class BookOrder extends IdEntity{

	/**
	 * 教材信息
	 */
	private Set<Book_Order> book_Orders;
	
	/**
	 * 数量
	 */
	private String num;
	
	/**
	 * 时间
	 */
	private String time;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "bookOrder")
	public Set<Book_Order> getBook_Orders() {
		return book_Orders;
	}

	public void setBook_Orders(Set<Book_Order> book_Orders) {
		this.book_Orders = book_Orders;
	}

	@Column(name = "NUM",  length = 150)
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	@Column(name = "TIME",  length = 150)
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	
	
}
