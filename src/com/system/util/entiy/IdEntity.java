package com.system.util.entiy;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;

@MappedSuperclass
public abstract class IdEntity {

	
	private String id;

	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name = "uuid",strategy = "uuid")
	@Column(name = "ID" , nullable = false , length = 32)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
	
}

