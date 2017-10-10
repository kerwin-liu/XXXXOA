package com.system.core.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.core.service.TsUserService;
import com.system.util.dao.SystemDao;
import com.system.util.dao.impl.SystemDaoImpl;

@Service("tsUserService")
public class TsUserServiceImpl  implements TsUserService{

	/*@Autowired
	private SystemDao systemDao;
	
	@Override
	public List<Map<String, Object>> tsuser(String sql) {
		// TODO Auto-generated method stub
		return systemDao.findForJdbc(sql);
	}*/

}
