package com.cd.dao;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

public class BaseDaoImpl<T> {

    @Autowired
    private HibernateTemplate hibernateTemplate;

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public SessionFactory getSessionFactory() {
        return this.getHibernateTemplate().getSessionFactory();
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.getHibernateTemplate().setSessionFactory(sessionFactory);
    }

    public List<?> find(String queryString, Object... values) throws DataAccessException {
        return this.getHibernateTemplate().find(queryString, values);
    }

    public List<?> find(String queryString, Object value) throws DataAccessException {
        return this.getHibernateTemplate().find(queryString, value);
    }

    public List<?> find(String queryString) throws DataAccessException {
        return this.getHibernateTemplate().find(queryString);
    }

    public List<?> findByExample(Object exampleEntity, int firstResult, int maxResults) throws DataAccessException {
        return this.getHibernateTemplate().findByExample(exampleEntity, firstResult, maxResults);
    }

    public List<?> findByExample(Object exampleEntity) throws DataAccessException {
        return this.getHibernateTemplate().findByExample(exampleEntity);
    }

    public List<?> findByExample(String entityName, Object exampleEntity, int firstResult, int maxResults) throws DataAccessException {
        return this.getHibernateTemplate().findByExample(entityName, exampleEntity, firstResult, maxResults);
    }

    public List<?> findByExample(String entityName, Object exampleEntity) throws DataAccessException {
        return this.getHibernateTemplate().findByExample(entityName, exampleEntity);
    }

    public List<?> findByNamedParam(String queryString, String paramName, Object value) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedParam(queryString, paramName, value);
    }

    public List<?> findByNamedParam(String queryString, String[] paramNames, Object[] values) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedParam(queryString, paramNames, values);
    }

    public List<?> findByNamedQuery(String queryName, Object... values) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQuery(queryName, values);
    }

    public List<?> findByNamedQuery(String queryName, Object value) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQuery(queryName, value);
    }

    public List<?> findByNamedQuery(String queryName) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQuery(queryName);
    }

    public List<?> findByNamedQueryAndNamedParam(String queryName, String paramName, Object value) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQueryAndNamedParam(queryName, paramName, value);
    }

    public List<?> findByNamedQueryAndNamedParam(String queryName, String[] paramNames, Object[] values) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQueryAndNamedParam(queryName, paramNames, values);
    }

    public List<?> findByNamedQueryAndValueBean(String queryName, Object valueBean) throws DataAccessException {
        return this.getHibernateTemplate().findByNamedQueryAndValueBean(queryName, valueBean);
    }

    public List<?> findByValueBean(String queryString, Object valueBean) throws DataAccessException {
        return this.getHibernateTemplate().findByValueBean(queryString, valueBean);
    }

    @SuppressWarnings("hiding")
    public <T> T get(Class<T> entityClass, Serializable id, LockMode lockMode) throws DataAccessException {
        return this.getHibernateTemplate().get(entityClass, id, lockMode);
    }

    @SuppressWarnings("hiding")
    public <T> T get(Class<T> entityClass, Serializable id) throws DataAccessException {
        return this.getHibernateTemplate().get(entityClass, id);
    }

    public Object get(String entityName, Serializable id, LockMode lockMode) throws DataAccessException {
        return this.getHibernateTemplate().get(entityName, id, lockMode);
    }

    public Object get(String entityName, Serializable id) throws DataAccessException {
        return this.getHibernateTemplate().get(entityName, id);
    }

    @SuppressWarnings("hiding")
    public <T> T load(Class<T> entityClass, Serializable id, LockMode lockMode) throws DataAccessException {
        return this.getHibernateTemplate().load(entityClass, id, lockMode);
    }

    @SuppressWarnings("hiding")
    public <T> T load(Class<T> entityClass, Serializable id) throws DataAccessException {
        return this.getHibernateTemplate().load(entityClass, id);
    }

    public void load(Object entity, Serializable id) throws DataAccessException {
        this.getHibernateTemplate().load(entity, id);
    }

    public Object load(String entityName, Serializable id, LockMode lockMode) throws DataAccessException {
        return this.getHibernateTemplate().load(entityName, id, lockMode);
    }

    public Object load(String entityName, Serializable id) throws DataAccessException {
        return this.getHibernateTemplate().load(entityName, id);
    }

    @SuppressWarnings("hiding")
    public <T> List<T> loadAll(Class<T> entityClass) throws DataAccessException {
        return this.getHibernateTemplate().loadAll(entityClass);
    }

    public void lock(Object entity, LockMode lockMode) throws DataAccessException {
        this.getHibernateTemplate().lock(entity, lockMode);
    }

    public void lock(String entityName, Object entity, LockMode lockMode) throws DataAccessException {
        this.getHibernateTemplate().lock(entityName, entity, lockMode);
    }

    @SuppressWarnings("hiding")
    public <T> T merge(String entityName, T entity) throws DataAccessException {
        return this.getHibernateTemplate().merge(entityName, entity);
    }

    @SuppressWarnings("hiding")
    public <T> T merge(T entity) throws DataAccessException {
        return this.getHibernateTemplate().merge(entity);
    }

    public void persist(Object entity) throws DataAccessException {
        this.getHibernateTemplate().persist(entity);
    }

    public void persist(String entityName, Object entity) throws DataAccessException {
        this.getHibernateTemplate().persist(entityName, entity);
    }

    public void refresh(Object entity, LockMode lockMode) throws DataAccessException {
        this.getHibernateTemplate().refresh(entity, lockMode);
    }

    public void refresh(Object entity) throws DataAccessException {
        this.getHibernateTemplate().refresh(entity);
    }

    public Serializable save(Object entity) throws DataAccessException {
        return this.getHibernateTemplate().save(entity);
    }

    public Serializable save(String entityName, Object entity) throws DataAccessException {
        return this.getHibernateTemplate().save(entityName, entity);
    }

    public void saveOrUpdate(Object entity) throws DataAccessException {
        this.getHibernateTemplate().saveOrUpdate(entity);
    }

    public void saveOrUpdate(String entityName, Object entity) throws DataAccessException {
        this.getHibernateTemplate().saveOrUpdate(entityName, entity);
    }

    @SuppressWarnings("rawtypes")
    public void saveOrUpdateAll(Collection entities) throws DataAccessException {
        this.getHibernateTemplate().saveOrUpdateAll(entities);
    }

    public void update(Object entity, LockMode lockMode) throws DataAccessException {
        this.getHibernateTemplate().update(entity, lockMode);
    }

    public void update(Object entity) throws DataAccessException {
        this.getHibernateTemplate().update(entity);
    }

    public void update(String entityName, Object entity, LockMode lockMode) throws DataAccessException {
        this.getHibernateTemplate().update(entityName, entity, lockMode);
    }

    public void update(String entityName, Object entity) throws DataAccessException {
        this.getHibernateTemplate().update(entityName, entity);
    }
    
    @SuppressWarnings("unchecked")
    public List<T> getListForPage(final String hql, final int start, final int limit) {
        List<T> list1 = getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query q = session.createQuery(hql);
                q.setFirstResult(start);
                q.setMaxResults(limit);
                List<?> list = q.list();
                return list;
            }
        });
        return list1;
    }

    public int getCurrentPage(int start, int limit) {
        return (start / limit) + 1;
    }
}
