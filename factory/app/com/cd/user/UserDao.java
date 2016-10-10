package com.cd.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("UserDao")
public class UserDao extends BaseDaoImpl<User> {

    public List<User> getUserListByDepartment(String departmentId, int start, int limit) {
        String hql = "from User u where u.departmentId = '" + departmentId + "'";
        return this.getListForPage(hql, start, limit);
    }
    
    @SuppressWarnings("unchecked")
    public int getUserCountByDepartment(String departmentId) {
        String hql = "from User u where u.departmentId = '" + departmentId + "'";
        List<User> list = this.getHibernateTemplate().find(hql);
        return list.size();
    }
    
    @SuppressWarnings("unchecked")
    public List<User> getUserListByLoginName(String loginName) {
        String hql = "from User u where u.loginName = '" + loginName + "'";
        return (List<User>) this.find(hql);
        
    }
    
}
