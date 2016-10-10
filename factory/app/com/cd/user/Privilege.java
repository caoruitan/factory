package com.cd.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "PRIVILEGE")
public class Privilege {
    
    private String privilegeId;
    
    private String userId;
    
    private String modelId;
    
    private String functionId;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "PRIVILEGE_ID", length = 50, nullable = false)
    public String getPrivilegeId() {
        return privilegeId;
    }

    public void setPrivilegeId(String privilegeId) {
        this.privilegeId = privilegeId;
    }

    @Column(name = "USER_ID", length = 50, nullable = false)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column(name = "MODEL_ID", length = 50, nullable = false)
    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    @Column(name = "FUNCTION_ID", length = 50, nullable = false)
    public String getFunctionId() {
        return functionId;
    }

    public void setFunctionId(String functionId) {
        this.functionId = functionId;
    }
    
}
