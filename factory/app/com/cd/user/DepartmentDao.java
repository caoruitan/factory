package com.cd.user;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("DepartmentDao")
public class DepartmentDao extends BaseDaoImpl<Department> {

    @SuppressWarnings("unchecked")
	public List<Department> getSubDepartments(String parentId) {
        String hql = "from Department u where u.parentId = :parentId";
        return (List<Department>) this.findByNamedParam(hql, "parentId", parentId);
    }
}
