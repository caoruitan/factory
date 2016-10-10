package com.cd.flow;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("FlowStepDao")
public class FlowStepDao extends BaseDaoImpl<FlowStep> {
    
    @SuppressWarnings("unchecked")
    public List<FlowStep> getStepsByDatabase(String database) {
        String hql = "from FlowStep s where s.databaseKey = :databaseKey order by s.stepNum";
        return (List<FlowStep>)this.findByNamedParam(hql, "databaseKey", database);
    }
    
}
