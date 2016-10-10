package com.cd.user;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("PrivilegeDao")
public class PrivilegeDao extends BaseDaoImpl<Privilege> {

    @SuppressWarnings("unchecked")
    public List<Privilege> getPrivilegeOfUser(String userId) {
        String hql = "from Privilege p where p.userId = '" + userId + "'";
        return (List<Privilege>) this.find(hql);
    }
    
    public void deletePrivilegeOfUser(String userId) {
        String sql = "delete from privilege where user_id = '" + userId + "'";
        SQLQuery q = this.getSessionFactory().getCurrentSession().createSQLQuery(sql);
        q.executeUpdate();
    }
    
    @SuppressWarnings("unchecked")
    public List<User> findUsersByPrivilege(String modelId, String functionId) {
        String hql = "select p.userId from Privilege p where p.modelId=:modelId and p.functionId=:functionId";
        List<String> userIds = (List<String>) this.findByNamedParam(hql, new String[]{"modelId", "functionId"}, new Object[]{modelId, functionId});
        List<User> users = new ArrayList<User>();
        if(userIds != null && userIds.size() > 0) {
            String hql2 = "from User u where u.userId in :userIds";
            users = (List<User>) this.findByNamedParam(hql2, "userIds", userIds);
        }
        return users;
    }
    
}
