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
@Table(name = "T_BOOK")
@JsonIgnoreProperties(value={"book_Orders","bookSales"})
public class Books extends IdEntity {

	/**
	 * 教材名称
	 */
	private String bookName;
	/**
	 * 作者
	 */
	private String auther;

	/**
	 * 出版社
	 */
	private String press;

	/**
	 * 价格
	 */

	private String price;
	/**
	 * 出版时间
	 */
	private String time;
	
	/**
	 * 订购信息
	 */
	private Set<Book_Order> book_Orders;
	
	/**
	 * 库存
	 */
	private String bookStocks;
	
	/**
	 * 出售信息
	 */
	
	private Set<BookSale> bookSales;
	
	@Column(name = "BOOKNAME", nullable = false, length = 150)
	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	@Column(name = "AUTHER",  length = 150)
	public String getAuther() {
		return auther;
	}

	public void setAuther(String auther) {
		this.auther = auther;
	}

	@Column(name = "PRESS",  length = 150)
	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press;
	}
	@Column(name = "PRICE",  length = 150)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	@Column(name = "TIME", length = 150)
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "book")
	public Set<Book_Order> getBook_Orders() {
		return book_Orders;
	}

	public void setBook_Orders(Set<Book_Order> book_Orders) {
		this.book_Orders = book_Orders;
	}

	@Column(name = "BOOKNUM",nullable = false, length = 150)
	public String getBookStocks() {
		return bookStocks;
	}

	public void setBookStocks(String bookStocks) {
		this.bookStocks = bookStocks;
	}
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "book")
	public Set<BookSale> getBookSales() {
		return bookSales;
	}

	public void setBookSales(Set<BookSale> bookSales) {
		this.bookSales = bookSales;
	}
	
	
}
