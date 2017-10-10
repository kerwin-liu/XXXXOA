package com.gx.book.entiy;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name="BOOK_ORDER")
@JsonIgnoreProperties(value={"bookOrder","book"})
public class Book_Order extends IdEntity {

	
	private Books book;
	
	private BookOrder bookOrder;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "B_ID")
	public Books getBook() {
		return book;
	}

	public void setBook(Books book) {
		this.book = book;
	}

	 @ManyToOne(fetch = FetchType.EAGER)
	 @JoinColumn(name = "BR_ID")
	public BookOrder getBookOrder() {
		return bookOrder;
	}

	public void setBookOrder(BookOrder bookOrder) {
		this.bookOrder = bookOrder;
	}
	
	
}
