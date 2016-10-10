package com.cd.flow;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FLOW_STEP_INSTANCE")
public class FlowStepInstance {
    
    private String stepInstanceId;
    
    private String databaseKey;
    
    private String dataId;
    
    private String stepName;
    
    private int stepNum;
    
    private String stepUser;
    
    private String stepUserName;
    
    private String status;
    
    private Date receiveTime;
    
    private Date approvalTime;
    
    private String memo;
    
    private String parentId;
    
    private String stepType;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "STEP_INSTANCE_ID", length = 50, nullable = false)
    public String getStepInstanceId() {
        return stepInstanceId;
    }

    public void setStepInstanceId(String stepInstanceId) {
        this.stepInstanceId = stepInstanceId;
    }

    @Column(name = "DATABASE_KEY", length = 100, nullable = false)
    public String getDatabaseKey() {
        return databaseKey;
    }

    public void setDatabaseKey(String databaseKey) {
        this.databaseKey = databaseKey;
    }

    @Column(name = "DATA_ID", length = 50, nullable = false)
    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    @Column(name = "STEP_NAME", length = 100, nullable = true)
    public String getStepName() {
        return stepName;
    }

    public void setStepName(String stepName) {
        this.stepName = stepName;
    }

    @Column(name = "STEP_NUM", nullable = true)
    public int getStepNum() {
        return stepNum;
    }

    public void setStepNum(int stepNum) {
        this.stepNum = stepNum;
    }

    @Column(name = "STEP_USER", length = 50, nullable = true)
    public String getStepUser() {
        return stepUser;
    }

    public void setStepUser(String stepUser) {
        this.stepUser = stepUser;
    }

    @Column(name = "STEP_USER_NAME", length = 100, nullable = true)
    public String getStepUserName() {
        return stepUserName;
    }

    public void setStepUserName(String stepUserName) {
        this.stepUserName = stepUserName;
    }

    @Column(name = "STEP_STATUS", length = 50, nullable = true)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "RECEIVE_TIME", nullable = true)
    public Date getReceiveTime() {
        return receiveTime;
    }

    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    @Column(name = "APPROVAL_TIME", nullable = true)
    public Date getApprovalTime() {
        return approvalTime;
    }

    public void setApprovalTime(Date approvalTime) {
        this.approvalTime = approvalTime;
    }

    @Column(name = "MEMO", length=1000, nullable = true)
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Column(name = "PARENT_ID", length=50, nullable = true)
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    @Column(name = "STEP_TYPE", length=20, nullable = true)
    public String getStepType() {
        return stepType;
    }

    public void setStepType(String stepType) {
        this.stepType = stepType;
    }
    
}
