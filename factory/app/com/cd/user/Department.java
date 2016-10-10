package com.cd.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "DEPARTMENT")
public class Department {

    private String departmentId;

    private String departmentName;

    private String description;

    private String parentId;
    
    private String level;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "DEPARTMENT_ID", length = 50, nullable = false)
    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    @Column(name = "DEPARTMENT_NAME", length = 200, nullable = false)
    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    @Column(name = "DESCRIPTION", length = 2000, nullable = false)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "PARENT_ID", length = 100, nullable = false)
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    @Column(name = "LEVEL", length = 10, nullable = true)
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

}
