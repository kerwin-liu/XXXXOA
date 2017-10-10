package com.gx.book.entiy;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name ="T_BOOKSALE")

public class BookSale extends IdEntity {
	
	/**
	 * 教材信息
	 */
	
	private Books book;
	
	/**
	 * 出售数量
	 */
	
	private String num;
	
	/**
	 * 出售时间
	 */
	private String time;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "B_ID")
	public Books getBook() {
		return book;
	}

	public void setBook(Books book) {
		this.book = book;
	}

	@Column(name = "NUM",nullable = false, length = 150)
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	@Column(name = "TIME",nullable = false, length = 150)
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	
	
}
