package com.cd.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cd.dao.GridData;
import com.cd.utils.MD5Util;

@Transactional
@Service("UserService")
public class UserService {
    
    @Autowired
    @Qualifier(value="UserDao")
    private UserDao userDao;
    
    public GridData<User> getUserListByDepartment(String departmentId, int start, int limit) {
        List<User> list = this.userDao.getUserListByDepartment(departmentId, start, limit);
        int total = this.userDao.getUserCountByDepartment(departmentId);
        GridData<User> grid = new GridData<User>();
        grid.setList(list);
        grid.setTotal(total);
        return grid;
    }
    
    public User getUser(String userId) {
        return this.userDao.get(User.class, userId);
    }
    
    public List<User> getUserByLoginName(String loginName) {
        return this.userDao.getUserListByLoginName(loginName);
    }
    
    public void createUser(String loginName, String userName, String sex, String university, String title, String phone, String departmentId) {
        User user = new User();
        user.setLoginName(loginName);
        user.setUserName(userName);
        user.setPassword(MD5Util.MD5Encode("123456"));
        user.setSex(sex);
        user.setUniversity(university);
        user.setTitle(title);
        user.setPhoneNumber(phone);
        user.setDepartmentId(departmentId);
        this.userDao.save(user);
    }
    
    public void updateUser(String userId, String userName, String sex, String university, String title, String phone) {
        User user = this.getUser(userId);
        user.setUserName(userName);
        user.setSex(sex);
        user.setUniversity(university);
        user.setTitle(title);
        user.setPhoneNumber(phone);
        this.userDao.update(user);
    }
    
    public void resetPassword(String userId) {
        User user = this.getUser(userId);
        user.setPassword(MD5Util.MD5Encode("123456"));
        this.userDao.update(user);
    }
    
    public void updatePassword(String userId, String oldPassword, String newPassword) throws Exception {
        User user = this.getUser(userId);
        if(!user.getPassword().equals(MD5Util.MD5Encode(oldPassword))) {
            throw new Exception("密码输入错误！");
        }
        user.setPassword(MD5Util.MD5Encode(newPassword));
        this.userDao.update(user);
    }
    
    public void deleteUser(String userId) {
        User user = this.getUser(userId);
        this.userDao.getHibernateTemplate().delete(user);
    }
    
}
