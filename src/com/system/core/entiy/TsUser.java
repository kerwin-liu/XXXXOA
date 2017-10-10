package com.system.core.entiy;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name = "T_S_USER")
@JsonIgnoreProperties(value={"tsUser_Roles"})
public class TsUser  extends IdEntity{

	/**
	 * 用户名
	 */
	private String username;
	
	
	/**
	 *密码 
	 */
	private String password;
	
	/**
	 * 手机号
	 */
	private String telno;
	
	/**
	 * 微信号/qq
	 */
	private String wqnum;
	
	/**
	 * 备注
	 */
	private String desc;
	
	/**
	 * 用户角色
	 */
	private TsRole tsRole;

	 @Column(name = "USERNAME", nullable = false, length = 150)
	public String getUsername() {
		return username;
	}
	 
	public void setUsername(String username) {
		this.username = username;
	}
	 @Column(name = "PASSWORD", nullable = false, length = 50)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	 @Column(name = "TELNO",  length = 50)
	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}
	 @Column(name = "WQNUM",  length = 50)
	public String getWqnum() {
		return wqnum;
	}

	public void setWqnum(String wqnum) {
		this.wqnum = wqnum;
	}
	 @Column(name = "DESCR",  length = 50)
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	 @ManyToOne(fetch = FetchType.EAGER)
	 @JoinColumn(name = "R_ID")
	public TsRole getTsRole() {
		return tsRole;
	}

	public void setTsRole(TsRole tsRole) {
		this.tsRole = tsRole;
	}

	

	
	
}
