package com.system.core.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.core.service.TsFunctionService;
import com.system.util.dao.SystemDao;

@Service("tsFunctionService")
public class TsFunctionServiceImpl  implements TsFunctionService{

	@Autowired
	private SystemDao systemDao;
	
	@Override
	public int saveAndUpdate(String sql) {
		// TODO Auto-generated method stub
		return systemDao.executeSql(sql);
	}

}
