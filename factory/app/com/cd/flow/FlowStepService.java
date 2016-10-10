package com.cd.flow;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("FlowStepService")
public class FlowStepService {
    
    @Autowired
    @Qualifier(value="FlowStepDao")
    private FlowStepDao flowStepDao;
    
    public List<FlowStep> getStepsByDatabase(String database) {
        return this.flowStepDao.getStepsByDatabase(database);
    }
    
    public void addStep(String database, String stepName, String stepUser) {
        FlowStep step = new FlowStep();
        step.setDatabaseKey(database);
        step.setStepName(stepName);
        step.setStepUser(stepUser);
        int stepNum = this.flowStepDao.getStepsByDatabase(database).size() + 1;
        step.setStepNum(stepNum);
        this.flowStepDao.save(step);
    }
    
    public FlowStep getFlowStep(String stepId) {
        return this.flowStepDao.get(FlowStep.class, stepId);
    }
    
    public void updateStep(String stepId, String stepName, String stepUser) {
        FlowStep step = this.getFlowStep(stepId);
        step.setStepName(stepName);
        step.setStepUser(stepUser);
        this.flowStepDao.update(step);
    }
    
    public void deleteStep(String stepId) {
        FlowStep step = this.getFlowStep(stepId);
        List<FlowStep> steps = this.getStepsByDatabase(step.getDatabaseKey());
        for(FlowStep s : steps) {
            if(s.getStepNum() > step.getStepNum()) {
                s.setStepNum(s.getStepNum() - 1);
                this.flowStepDao.update(s);
            }
        }
        this.flowStepDao.getHibernateTemplate().delete(step);
    }
    
    public void moveUpStep(String stepId) {
        FlowStep step = this.getFlowStep(stepId);
        List<FlowStep> steps = this.getStepsByDatabase(step.getDatabaseKey());
        for(FlowStep s : steps) {
            if(s.getStepNum() == step.getStepNum() - 1) {
                s.setStepNum(s.getStepNum() + 1);
                this.flowStepDao.update(s);
            }
        }
        step.setStepNum(step.getStepNum() - 1);
        this.flowStepDao.update(step);
    }
    
    public void moveDownStep(String stepId) {
        FlowStep step = this.getFlowStep(stepId);
        List<FlowStep> steps = this.getStepsByDatabase(step.getDatabaseKey());
        for(FlowStep s : steps) {
            if(s.getStepNum() == step.getStepNum() + 1) {
                s.setStepNum(s.getStepNum() - 1);
                this.flowStepDao.update(s);
            }
        }
        step.setStepNum(step.getStepNum() + 1);
        this.flowStepDao.update(step);
    }
    
}
