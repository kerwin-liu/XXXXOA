package com.system.util.service.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.system.util.dao.SystemDao;
import com.system.util.entiy.DBTable;
import com.system.util.service.SystemService;




@Service("systemService")
public class SystemServiceImpl implements SystemService{

	@Autowired
	public SystemDao systemDao;
	
	@Override
	public List<Map<String, Object>> findForJdbc(String sql, Object... objects) {
		// TODO Auto-generated method stub
		return systemDao.findForJdbc(sql, objects);
	}

	@Override
	public List<DBTable> getAllDbTableName() {
		// TODO Auto-generated method stub
		return systemDao.getAllDbTableName();
	}

	@Override
	public Integer getAllDbTableSize() {
		// TODO Auto-generated method stub
		return systemDao.getAllDbTableSize();
	}

	@Override
	public <T> Serializable save(T entity) {
		// TODO Auto-generated method stub
		return systemDao.save(entity);
	}

	@Override
	public <T> void batchSave(List<T> entitys) {
		// TODO Auto-generated method stub
		systemDao.batchSave(entitys);
	}

	@Override
	public <T> void saveOrUpdate(T entity) {
		// TODO Auto-generated method stub
		systemDao.saveOrUpdate(entity);
	}

	@Override
	public <T> void delete(T entitie) {
		// TODO Auto-generated method stub
		systemDao.delete(entitie);
	}

	@Override
	public <T> T get(Class<T> entityName, Serializable id) {
		// TODO Auto-generated method stub
		return systemDao.get(entityName, id);
	}

	@Override
	public <T> T findUniqueByProperty(Class<T> entityClass,
			String propertyName, Object value) {
		// TODO Auto-generated method stub
		return systemDao.findUniqueByProperty(entityClass, propertyName, value);
	}

	@Override
	public <T> List<T> findByProperty(Class<T> entityClass,
			String propertyName, Object value) {
		// TODO Auto-generated method stub
		return systemDao.findByProperty(entityClass, propertyName, value);
	}

	@Override
	public <T> List<T> loadAll(Class<T> entityClass) {
		// TODO Auto-generated method stub
		return systemDao.loadAll(entityClass);
	}

	@Override
	public <T> T getEntity(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		return systemDao.getEntity(entityName, id);
	}

	@Override
	public <T> void deleteEntityById(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		systemDao.deleteEntityById(entityName, id);
	}

	@Override
	public <T> void deleteAllEntitie(Collection<T> entities) {
		// TODO Auto-generated method stub
		systemDao.deleteAllEntitie(entities);
	}

	@Override
	public <T> void updateEntitie(T pojo) {
		// TODO Auto-generated method stub
		systemDao.updateEntitie(pojo);
	}

	@Override
	public <T> void updateEntityById(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		systemDao.updateEntityById(entityName, id);
	}

	@Override
	public <T> List<T> findByQueryString(String hql) {
		// TODO Auto-generated method stub
		return systemDao.findByQueryString(hql);
	}

	@Override
	public <T> T singleResult(String hql) {
		// TODO Auto-generated method stub
		return systemDao.singleResult(hql);
	}

	@Override
	public int updateBySqlString(String sql) {
		// TODO Auto-generated method stub
		return systemDao.updateBySqlString(sql);
	}

	@Override
	public <T> List<T> findListbySql(String query) {
		// TODO Auto-generated method stub
		return systemDao.findListbySql(query);
	}

	@Override
	public <T> List<T> findByPropertyisOrder(Class<T> entityClass,
			String propertyName, Object value, boolean isAsc) {
		// TODO Auto-generated method stub
		return systemDao.findByPropertyisOrder(entityClass, propertyName, value, isAsc);
	}

	@Override
	public Integer executeSql(String sql, List<Object> param) {
		// TODO Auto-generated method stub
		return systemDao.executeSql(sql, param);
	}

	@Override
	public Integer executeSql(String sql, Object... param) {
		// TODO Auto-generated method stub
		return systemDao.executeSql(sql, param);
	}

	@Override
	public Integer executeSql(String sql, Map<String, Object> param) {
		// TODO Auto-generated method stub
		return systemDao.executeSql(sql, param);
	}

	@Override
	public Map<String, Object> findOneForJdbc(String sql, Object... objs) {
		// TODO Auto-generated method stub
		return systemDao.findOneForJdbc(sql, objs);
	}

	@Override
	public <T> List<T> loadAll(Class<T> entityClass, String order,
			String... colname) {
		// TODO Auto-generated method stub
		return systemDao.loadAll(entityClass, order, colname);
	}
	
}
