package com.cd.flow;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cd.dao.GridData;
import com.cd.datalib.DataLibService;
import com.cd.user.PrivilegeService;
import com.cd.user.User;

@Transactional
@Service("FlowStepInstanceService")
public class FlowStepInstanceService {
    
    @Autowired
    @Qualifier(value="FlowStepService")
    private FlowStepService flowStepService;

    @Autowired
    @Qualifier("PrivilegeService")
    private PrivilegeService privilegeService;

    @Autowired
    @Qualifier("FlowStepInstanceDao")
    private FlowStepInstanceDao flowStepInstanceDao;
    
    @Autowired
    @Qualifier("DataLibService")
    private DataLibService dataLibService;
    
    public void sendApproval(String database, String dataId) {
        List<FlowStepInstance> oldSteps = this.getFlowStepInstanceByDataId(database, dataId);
        if(oldSteps != null && oldSteps.size() > 0) {
            for(FlowStepInstance step : oldSteps) {
                this.flowStepInstanceDao.getHibernateTemplate().delete(step);
            }
        }
        List<FlowStep> steps = this.flowStepService.getStepsByDatabase(database);
        List<User> userList = privilegeService.findUsersByPrivilege(database, "APPROVAL");
        Map<String, String> userNames = new HashMap<String, String>();
        for(User user : userList) {
            userNames.put(user.getUserId(), user.getUserName());
        }
        
        for(FlowStep step : steps) {
            FlowStepInstance instance = new FlowStepInstance();
            instance.setDatabaseKey(database);
            instance.setDataId(dataId);
            instance.setStepNum(step.getStepNum());
            instance.setStepName(step.getStepName());
            instance.setStepUser(step.getStepUser());
            instance.setStepUserName(userNames.get(step.getStepUser()));
            instance.setStepType("1");
            if(step.getStepNum() == 1) {
                instance.setStatus("RUNNING");
                instance.setReceiveTime(new Date());
            } else {
                instance.setStatus("READY");
            }
            this.flowStepInstanceDao.save(instance);
        }
        this.dataLibService.updateDataLibStatus(dataId, null, "审核中");
    }
    
    public GridData<FlowStepInstance> getFlowStepByUser(String userId, int start, int limit) {
        GridData<FlowStepInstance> grid = new GridData<FlowStepInstance>();
        List<FlowStepInstance> list = this.flowStepInstanceDao.getFlowStepByUser(userId, start, limit);
        int total = this.flowStepInstanceDao.getFlowStepCountByUser(userId);
        grid.setList(list);
        grid.setTotal(total);
        return grid;
    }
    
    public FlowStepInstance getFlowStepInstance(String stepInstanceId) {
        return this.flowStepInstanceDao.getHibernateTemplate().get(FlowStepInstance.class, stepInstanceId);
    }
    
    public List<FlowStepInstance> getFlowStepInstanceByDataId(String database, String dataId) {
        return this.flowStepInstanceDao.getFlowStepInstanceByDataId(database, dataId);
    }
    
    public void approval(String stepInstanceId, boolean result, String memo) {
        FlowStepInstance step = this.getFlowStepInstance(stepInstanceId);
        step.setStatus(result ? "PASS" : "UNPASS");
        step.setMemo(memo);
        step.setApprovalTime(new Date());
        this.flowStepInstanceDao.save(step);
        
        if(step.getStepType().equals("1")) {
            if(result) {
                List<FlowStepInstance> steps = this.flowStepInstanceDao.getFlowStepInstanceByDataId(step.getDatabaseKey(), step.getDataId());
                boolean hasNext = false;
                for(FlowStepInstance st : steps) {
                    if(st.getStepNum() == step.getStepNum() + 1) {
                        st.setStatus("RUNNING");
                        st.setReceiveTime(new Date());
                        this.flowStepInstanceDao.update(step);
                        hasNext = true;
                        break;
                    }
                }
                if(!hasNext) {
                    this.dataLibService.updateDataLibStatus(step.getDataId(), null, "审核通过");
                }
            } else {
                this.dataLibService.updateDataLibStatus(step.getDataId(), null, "编辑中");
            }
        }
    }
    
    public void invitExpert(String stepInstanceId, String[] experts) {
        FlowStepInstance step = this.getFlowStepInstance(stepInstanceId);
        
        List<User> userList = privilegeService.findUsersByPrivilege(step.getDatabaseKey(), "EXPERT");
        Map<String, String> userNames = new HashMap<String, String>();
        for(User user : userList) {
            userNames.put(user.getUserId(), user.getUserName());
        }
        
        Date currentDate = new Date();
        for(String expert : experts) {
            FlowStepInstance instance = new FlowStepInstance();
            instance.setDatabaseKey(step.getDatabaseKey());
            instance.setDataId(step.getDataId());
            instance.setStepNum(step.getStepNum());
            instance.setStepName(step.getStepName());
            instance.setStepUser(expert);
            instance.setStepUserName(userNames.get(expert));
            instance.setStatus("RUNNING");
            instance.setReceiveTime(currentDate);
            instance.setParentId(step.getStepInstanceId());
            instance.setStepType("2");
            this.flowStepInstanceDao.save(instance);
        }
    }
    
}
