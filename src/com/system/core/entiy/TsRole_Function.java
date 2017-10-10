package com.system.core.entiy;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.system.util.entiy.IdEntity;

@Entity
@Table(name = "T_S_ROLE_FUNCTION")
public class TsRole_Function extends IdEntity{

	private TsFunction tsFunction;
	
	private TsRole tsRole;

	 @ManyToOne(fetch = FetchType.EAGER)
	 @JoinColumn(name = "F_ID")
	public TsFunction getTsFunction() {
		return tsFunction;
	}

	public void setTsFunction(TsFunction tsFunction) {
		this.tsFunction = tsFunction;
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
