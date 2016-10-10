package com.cd.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cd.dao.GridData;

@Transactional
@Service("DepartmentService")
public class DepartmentService {

    @Autowired
    @Qualifier(value="DepartmentDao")
    private DepartmentDao departmentDao;

    @Autowired
    @Qualifier(value="UserService")
    private UserService userService;

    public List<Department> getSubDepartments(String parentId) {
        return this.departmentDao.getSubDepartments(parentId);
    }

    public Department getDepartment(String departmentId) {
        return this.departmentDao.get(Department.class, departmentId);
    }

    public void createDepartment(String departmentName, String description, String parentId) {
        Department parent = this.getDepartment(parentId);
        Department dep = new Department();
        dep.setDepartmentName(departmentName);
        dep.setDescription(description);
        dep.setParentId(parentId);
        this.departmentDao.save(dep);
    }

    public Department updateDepartment(String departmentId, String departmentName, String description) {
        Department dep = this.getDepartment(departmentId);
        dep.setDepartmentName(departmentName);
        dep.setDescription(description);
        this.departmentDao.update(dep);
        return dep;
    }

    public void deleteDepartment(String departmentId) throws Exception {
        Department dep = this.getDepartment(departmentId);
        List<Department> subList = this.getSubDepartments(departmentId);
        if(subList!=null && subList.size() > 0) {
			throw new Exception("当前部门下还有子部门，不能删除当前部门！");
        }
        GridData<User> userList = this.userService.getUserListByDepartment(departmentId, 0, 10);
        if(userList != null && userList.getList().size() > 0) {
			throw new Exception("当前部门下还有用户，不能删除当前部门！");
        }
        this.departmentDao.getHibernateTemplate().delete(dep);
    }
}
