package com.cd.flow;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("FlowStepInstanceDao")
public class FlowStepInstanceDao extends BaseDaoImpl<FlowStepInstance> {

    public List<FlowStepInstance> getFlowStepByUser(String userId, int start, int limit) {
        String hql = "from FlowStepInstance si where si.stepUser='" + userId + "' and si.status in ('RUNNING', 'PASS', 'UNPASS') order by si.approvalTime";
        return this.getListForPage(hql, start, limit);
    }
    
    @SuppressWarnings("unchecked")
    public int getFlowStepCountByUser(String userId) {
        String hql = "from FlowStepInstance si where si.stepUser='" + userId + "' and si.status='RUNNING'";
        List<FlowStepInstance> list = this.getHibernateTemplate().find(hql);
        return list.size();
    }
    
    @SuppressWarnings("unchecked")
    public List<FlowStepInstance> getFlowStepInstanceByDataId(String database, String dataId) {
        String hql = "from FlowStepInstance si where si.databaseKey=:databaseKey and si.dataId=:dataId order by si.stepNum,si.stepType";
        List<FlowStepInstance> list = (List<FlowStepInstance>) this.findByNamedParam(hql, new String[]{"databaseKey", "dataId"}, new Object[]{database, dataId});
        return list;
    }
}
