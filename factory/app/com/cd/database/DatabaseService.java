package com.cd.database;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("DatabaseService")
public class DatabaseService {
    
    @Autowired
    @Qualifier(value="DatabaseDao")
    private DatabaseDao databaseDao;
    
    public List<Database> getDatabaseList() {
        return this.databaseDao.getDatabaseList();
    }
    
}
