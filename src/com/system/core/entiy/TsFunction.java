package com.system.core.entiy;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name = "T_S_FUNCTION")
@JsonIgnoreProperties(value={"children","tsRole_Functions"})
public class TsFunction extends IdEntity{

	private TsFunction tsFunction;// 父菜单
	
	private String functionName;// 菜单名称

	private String functionUrl;// 菜单地址
	
	private String type;//菜单类型  0_父类, 1_子类

	private String functionOrder;// 菜单排序

	private List<TsFunction> children = new ArrayList<TsFunction>();

	private Set<TsRole_Function> tsRole_Functions;

	 @ManyToOne(fetch = FetchType.EAGER)
	 @JoinColumn(name = "PARENTFUNCTIONID")
	public TsFunction getTsFunction() {
		return tsFunction;
	}

	public void setTsFunction(TsFunction tsFunction) {
		this.tsFunction = tsFunction;
	}
	@Column(name = "FNAME", nullable = false, length = 150)
	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	@Column(name = "FURL", length = 50)
	public String getFunctionUrl() {
		return functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl;
	}
	@Column(name = "FORDER", nullable = false, length = 50)
	public String getFunctionOrder() {
		return functionOrder;
	}

	public void setFunctionOrder(String functionOrder) {
		this.functionOrder = functionOrder;
	}
	 @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsFunction")
	public List<TsFunction> getChildren() {
		return children;
	}


	public void setChildren(List<TsFunction> children) {
		this.children = children;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsFunction")
	public Set<TsRole_Function> getTsRole_Functions() {
		return tsRole_Functions;
	}

	public void setTsRole_Functions(Set<TsRole_Function> tsRole_Functions) {
		this.tsRole_Functions = tsRole_Functions;
	}
	@Column(name = "FTYPE", nullable = false, length = 50)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	
}
