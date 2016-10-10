package com.cd.database;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="SYSDB")
public class Database {

    private String key;
    
    private String name;
    
    private String type;

    @Id
    @Column(name = "DATABASE_KEY", length = 100, nullable = false)
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Column(name = "DATABASE_NAME", length = 100, nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "DATABASE_TYPE", length = 100, nullable = false)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
}
