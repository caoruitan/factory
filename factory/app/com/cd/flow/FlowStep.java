package com.cd.flow;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FLOWSTEP")
public class FlowStep {
    
    private String stepId;
    
    private int stepNum;
    
    private String stepName;
    
    private String stepUser;
    
    private String databaseKey;
    
    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "STEP_ID", length = 50, nullable = false)
    public String getStepId() {
        return stepId;
    }

    public void setStepId(String stepId) {
        this.stepId = stepId;
    }

    @Column(name = "STEP_NUM", length = 10, nullable = false)
    public int getStepNum() {
        return stepNum;
    }

    public void setStepNum(int stepNum) {
        this.stepNum = stepNum;
    }

    @Column(name = "STEP_NAME", length = 100, nullable = false)
    public String getStepName() {
        return stepName;
    }

    public void setStepName(String stepName) {
        this.stepName = stepName;
    }

    @Column(name = "STEP_USER", length = 50, nullable = false)
    public String getStepUser() {
        return stepUser;
    }

    public void setStepUser(String stepUser) {
        this.stepUser = stepUser;
    }

    @Column(name = "DATABASE_KEY", length = 100, nullable = false)
    public String getDatabaseKey() {
        return databaseKey;
    }

    public void setDatabaseKey(String databaseKey) {
        this.databaseKey = databaseKey;
    }
    
}
