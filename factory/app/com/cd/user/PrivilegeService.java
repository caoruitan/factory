package com.cd.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("PrivilegeService")
public class PrivilegeService {
    
    @Autowired
    @Qualifier(value="PrivilegeDao")
    private PrivilegeDao privilegeDao;
    
    public boolean isHavePrivilege(String userId, String database, String functionId) {
        List<Privilege> privileges = this.getPrivilegeOfUser(userId);
        for(Privilege privilege : privileges) {
            if(privilege.getModelId().equals(database) && privilege.getFunctionId().equals(functionId)) {
                return true;
            }
        }
        return false;
    }
    
    public List<Privilege> getPrivilegeOfUser(String userId) {
        return this.privilegeDao.getPrivilegeOfUser(userId);
    }
    
    public void setPrivileges(String userId, List<String> privileges) {
        this.privilegeDao.deletePrivilegeOfUser(userId);
        for(String privilege : privileges) {
            String modelId = privilege.split("_")[0];
            String functionId = privilege.split("_")[1];
            Privilege p = new Privilege();
            p.setUserId(userId);
            p.setModelId(modelId);
            p.setFunctionId(functionId);
            this.privilegeDao.save(p);
        }
    }
    
    public List<User> findUsersByPrivilege(String modelId, String functionId) {
        return this.privilegeDao.findUsersByPrivilege(modelId, functionId);
    }
    
}
