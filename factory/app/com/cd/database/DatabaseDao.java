package com.cd.database;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("DatabaseDao")
public class DatabaseDao extends BaseDaoImpl<Database> {
    
    @SuppressWarnings("unchecked")
    public List<Database> getDatabaseList() {
        String hql = "from Database";
        return (List<Database>)this.find(hql);
    }
    
}
