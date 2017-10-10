package com.system.util.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.persister.entity.AbstractEntityPersister;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.system.util.dao.SystemDao;
import com.system.util.entiy.DBTable;


@Repository("systemDao")
public class SystemDaoImpl implements SystemDao {

	
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	@Autowired
	@Qualifier("jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	@Qualifier("namedParameterJdbcTemplate")
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;


	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public List<Map<String, Object>> findForJdbc(String sql, Object... objects) {
		// TODO Auto-generated method stub
		return jdbcTemplate.queryForList(sql, objects);
	}

	@Override
	public List<DBTable> getAllDbTableName() {
		// TODO Auto-generated method stub
		 List<DBTable> resultList = new ArrayList<DBTable>();
	        SessionFactory factory = getSession().getSessionFactory();
	        Map<String, ClassMetadata> metaMap = factory.getAllClassMetadata();
	        for (String key : metaMap.keySet()) {
	            DBTable dbTable = new DBTable();
	            AbstractEntityPersister classMetadata = (AbstractEntityPersister) metaMap.get(key);
	            dbTable.setTableName(classMetadata.getTableName());
	            dbTable.setEntityName(classMetadata.getEntityName());
	            Class<?> clazz;
	            try {
	                clazz = Class.forName(key);
	                PlatformEntityTitle title = clazz.getAnnotation(PlatformEntityTitle.class);
	                dbTable.setTableTitle(title != null ? title.name() : "");
	            } catch (ClassNotFoundException e) {
	                e.printStackTrace();
	            }
	            resultList.add(dbTable);
	        }
	        return resultList;
	}

	@Override
	public Integer getAllDbTableSize() {
		// TODO Auto-generated method stub
		 	SessionFactory factory = getSession().getSessionFactory();
	        Map<String, ClassMetadata> metaMap = factory.getAllClassMetadata();
	        return metaMap.size();
	}

	@Override
	public <T> Serializable save(T entity) {
		// TODO Auto-generated method stub
		 try {
	            Serializable id = getSession().save(entity);
	            getSession().flush();
	            return id;
	        } catch (RuntimeException e) {
	            throw e;
	        }
	}

	@Override
	public <T> void batchSave(List<T> entitys) {
		// TODO Auto-generated method stub
		 for (int i = 0; i < entitys.size(); i++) {
	            getSession().save(entitys.get(i));
	            if (i % 20 == 0) {
	                // 20个对象后才清理缓存，写入数据库
	                getSession().flush();
	                getSession().clear();
	            }
	        }
	        // 最后清理一下----防止大于20小于40的不保存
	        getSession().flush();
	        getSession().clear();
	}

	@Override
	public <T> void saveOrUpdate(T entity) {
		// TODO Auto-generated method stub
		try {
            getSession().saveOrUpdate(entity);
            getSession().flush();
        } catch (RuntimeException e) {
            throw e;
        }
	}

	@Override
	public <T> void delete(T entity) {
		// TODO Auto-generated method stub
		 try {
	            getSession().delete(entity);
	            getSession().flush();
	        } catch (RuntimeException e) {
	            throw e;
	        }
	}

	@Override
	public <T> T get(Class<T> entityClass, Serializable id) {
		// TODO Auto-generated method stub
		return (T) getSession().get(entityClass, id);
	}

	@Override
	public <T> T findUniqueByProperty(Class<T> entityClass,
			String propertyName, Object value) {
		// TODO Auto-generated method stub
		Assert.hasText(propertyName);
        return (T) createCriteria(entityClass, Restrictions.eq(propertyName, value)).uniqueResult();
	}
	/**
     * 创建Criteria对象，有排序功能。
     * @param <T>
     * @param entityClass
     * @param orderBy
     * @param isAsc
     * @param criterions
     * @return
     */
    private <T> Criteria createCriteria(Class<T> entityClass, boolean isAsc, Criterion... criterions) {
        Criteria criteria = createCriteria(entityClass, criterions);
        if (isAsc) {
            criteria.addOrder(Order.asc("asc"));
        } else {
            criteria.addOrder(Order.desc("desc"));
        }
        return criteria;
    }
    
    /**
     * 创建Criteria对象带属性比较
     * @param <T>
     * @param entityClass
     * @param criterions
     * @return
     */
    private <T> Criteria createCriteria(Class<T> entityClass, Criterion... criterions) {
        Criteria criteria = getSession().createCriteria(entityClass);
        for (Criterion c : criterions) {
            criteria.add(c);
        }
        return criteria;
    }
    
	@Override
	public <T> List<T> findByProperty(Class<T> entityClass,
			String propertyName, Object value) {
		// TODO Auto-generated method stub
		   Assert.hasText(propertyName);
	       return createCriteria(entityClass, Restrictions.eq(propertyName, value)).list();
	}

	@Override
	public <T> List<T> loadAll(Class<T> entityClass) {
		// TODO Auto-generated method stub
		 Criteria criteria = createCriteria(entityClass);
	      return criteria.list();
	}

	@Override
	public <T> T getEntity(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		 T t = (T) getSession().get(entityName, id);
	        if (t != null) {
	            getSession().flush();
	        }
	        return t;
	}

	@Override
	public <T> void deleteEntityById(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		delete(get(entityName, id));
        getSession().flush();
	}

	@Override
	public <T> void deleteAllEntitie(Collection<T> entitys) {
		// TODO Auto-generated method stub
		for (Object entity : entitys) {
            getSession().delete(entity);
            getSession().flush();
        }
	}

	@Override
	public <T> void updateEntitie(T pojo) {
		// TODO Auto-generated method stub
		 getSession().update(pojo);
	     getSession().flush();
	}

	@Override
	public <T> void updateEntityById(Class entityName, Serializable id) {
		// TODO Auto-generated method stub
		updateEntitie(get(entityName, id));
	}

	@Override
	public <T> List<T> findByQueryString(String query) {
		// TODO Auto-generated method stub
		 Query queryObject = getSession().createQuery(query);
	        List<T> list = queryObject.list();
	        if (list.size() > 0) {
	            getSession().flush();
	        }
	        return list;
	}

	@Override
	public <T> T singleResult(String hql) {
		// TODO Auto-generated method stub
		T t = null;
        Query queryObject = getSession().createQuery(hql);
        List<T> list = queryObject.list();
        if (list.size() == 1) {
            getSession().flush();
            t = list.get(0);
        } else if (list.size() > 0) {
        }
        return t;
	}

	@Override
	public int updateBySqlString(String query) {
		// TODO Auto-generated method stub
		Query querys = getSession().createSQLQuery(query);
        return querys.executeUpdate();
	}

	@Override
	public <T> List<T> findListbySql(String sql) {
		// TODO Auto-generated method stub
		  Query querys = getSession().createSQLQuery(sql);
	        return querys.list();
	}

	@Override
	public <T> List<T> findByPropertyisOrder(Class<T> entityClass,
			String propertyName, Object value, boolean isAsc) {
		// TODO Auto-generated method stub
        Assert.hasText(propertyName);
        return createCriteria(entityClass, isAsc, Restrictions.eq(propertyName, value)).list();
	}

	@Override
	public Integer executeSql(String sql, List<Object> param) {
		// TODO Auto-generated method stub
		 return this.jdbcTemplate.update(sql, param);
	}

	@Override
	public Integer executeSql(String sql, Object... param) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.update(sql, param);
	}

	@Override
	public Integer executeSql(String sql, Map<String, Object> param) {
		// TODO Auto-generated method stub
		 return this.namedParameterJdbcTemplate.update(sql, param);
	}


	@Override
	public Map<String, Object> findOneForJdbc(String sql, Object... objs) {
		// TODO Auto-generated method stub
		 try {
	            return this.jdbcTemplate.queryForMap(sql, objs);
	        } catch (EmptyResultDataAccessException e) {
	            return null;
	        }
	}

	@Override
	public <T> List<T> loadAll(Class<T> entityClass, String order ,String ...colname) {
		// TODO Auto-generated method stub
		Criteria criteria = getSession().createCriteria(entityClass);
		for (String string : colname) {
			if(order.equals("desc")){
				criteria.addOrder(Order.desc(string));
			}else{
				criteria.addOrder(Order.asc(string));
			}
		}
		return criteria.list();
	}

}
