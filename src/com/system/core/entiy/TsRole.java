package com.system.core.entiy;

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
@Table(name = "T_S_ROLE")
@JsonIgnoreProperties(value={"tsUser_Roles","tsRole_Functions"})
public class TsRole extends IdEntity{
	
	/**
	 * 角色名称
	 */
	private String rname;
	
	/**
	 * 角色编码
	 */
	private String rnum;
	
	/**
	 * 用户权限
	 */
	private Set<TsUser> tsUser_Roles;
	
	/**
	 * 用户菜单
	 */
	private Set<TsRole_Function> tsRole_Functions;

	
	@Column(name = "RNAME", nullable = false, length = 50)
	public String getRname() {
		return rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}
	@Column(name = "RNUM", nullable = false, length = 50)
	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	 @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsRole")
	public Set<TsUser> getTsUser_Roles() {
		return tsUser_Roles;
	}

	public void setTsUser_Roles(Set<TsUser> tsUser_Roles) {
		this.tsUser_Roles = tsUser_Roles;
	}
	 @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsRole")
	public Set<TsRole_Function> getTsRole_Functions() {
		return tsRole_Functions;
	}

	public void setTsRole_Functions(Set<TsRole_Function> tsRole_Functions) {
		this.tsRole_Functions = tsRole_Functions;
	}
	
}
