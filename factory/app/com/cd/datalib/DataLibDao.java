package com.cd.datalib;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Example.PropertySelector;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.Type;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.cd.dao.BaseDaoImpl;

@Repository("DataLibDao")
public class DataLibDao extends BaseDaoImpl<DataLib> {

	private PropertySelector mySelector = new PropertySelector() {
		public boolean include(Object value, String proName, Type type) {
			return value != null
					&& (((value instanceof String) && !("").equals(value)) 
							|| ((value instanceof Number) && ((Number) value).longValue() != 0));
		}
	};
	
    public List<DataLib> getDataLibListByType(final DataLib dataLib, final Date uploadTimeStart, final Date uploadTimeEnd, final Map<String, String> geLeMap, final int start, final int limit) {
    	final String hql = "from DataLib d where d.libType=:libType and d.uploadTime between :uploadTimeStart and :uploadTimeEnd";
    	
    	return 
	    	this.getHibernateTemplate().execute(new HibernateCallback<List<DataLib>>() {
	    		
				@SuppressWarnings("unchecked")
				@Override
				public List<DataLib> doInHibernate(Session session)
						throws HibernateException, SQLException {
					Criteria c = session.createCriteria(DataLib.class);
					
					Example e = Example.create(dataLib).enableLike().excludeProperty("uploadTime").excludeProperty("libType");
					e.setPropertySelector(mySelector);
					
					c.add(e);
					c.add(Restrictions.eq("libType", dataLib.getLibType()));
					c.add(Restrictions.between("uploadTime", uploadTimeStart, uploadTimeEnd));
					
					String sampleQuantityStart = geLeMap.get("sampleQuantityStart");
					if (StringUtils.isNotEmpty(sampleQuantityStart)) {
						c.add(Restrictions.ge("sampleQuantity", new BigDecimal(sampleQuantityStart)));
					}
					String sampleQuantityEnd = geLeMap.get("sampleQuantityEnd");
					if (StringUtils.isNotEmpty(sampleQuantityEnd)) {
						c.add(Restrictions.le("sampleQuantity", new BigDecimal(sampleQuantityEnd)));
					}
					
					String auraRateStart = geLeMap.get("auraRateStart");
					if (StringUtils.isNotEmpty(auraRateStart)) {
						c.add(Restrictions.ge("auraRate", new BigDecimal(auraRateStart)));
					}
					String auraRateEnd = geLeMap.get("auraRateEnd");
					if (StringUtils.isNotEmpty(auraRateEnd)) {
						c.add(Restrictions.le("auraRate", new BigDecimal(auraRateEnd)));
					}
					
					String activationEnergyStart = geLeMap.get("activationEnergyStart");
					if (StringUtils.isNotEmpty(activationEnergyStart)) {
						c.add(Restrictions.ge("activationEnergy", new BigDecimal(activationEnergyStart)));
					}
					String activationEnergyEnd = geLeMap.get("activationEnergyEnd");
					if (StringUtils.isNotEmpty(activationEnergyEnd)) {
						c.add(Restrictions.le("activationEnergy", new BigDecimal(activationEnergyEnd)));
					}
					
					String preExponentialFactorStart = geLeMap.get("preExponentialFactorStart");
					if (StringUtils.isNotEmpty(preExponentialFactorStart)) {
						c.add(Restrictions.ge("preExponentialFactor", new BigDecimal(preExponentialFactorStart)));
					}
					String preExponentialFactorEnd = geLeMap.get("preExponentialFactorEnd");
					if (StringUtils.isNotEmpty(preExponentialFactorEnd)) {
						c.add(Restrictions.le("preExponentialFactor", new BigDecimal(preExponentialFactorEnd)));
					}
					
					String reactionOrderStart = geLeMap.get("reactionOrderStart");
					if (StringUtils.isNotEmpty(reactionOrderStart)) {
						c.add(Restrictions.ge("reactionOrder", new BigDecimal(reactionOrderStart)));
					}
					String reactionOrderEnd = geLeMap.get("reactionOrderEnd");
					if (StringUtils.isNotEmpty(reactionOrderEnd)) {
						c.add(Restrictions.le("reactionOrder", new BigDecimal(reactionOrderEnd)));
					}
					
					String reactiontStart = geLeMap.get("reactiontStart");
					if (StringUtils.isNotEmpty(reactiontStart)) {
						c.add(Restrictions.ge("reactiont", new BigDecimal(reactiontStart)));
					}
					String reactiontEnd = geLeMap.get("reactiontEnd");
					if (StringUtils.isNotEmpty(reactiontEnd)) {
						c.add(Restrictions.le("reactiont", new BigDecimal(reactiontEnd)));
					}
					
					String reactionTimeStart = geLeMap.get("reactionTimeStart");
					if (StringUtils.isNotEmpty(reactionTimeStart)) {
						c.add(Restrictions.ge("reactionTime", new BigDecimal(reactionTimeStart)));
					}
					String reactionTimeEnd = geLeMap.get("reactionTimeEnd");
					if (StringUtils.isNotEmpty(reactionTimeEnd)) {
						c.add(Restrictions.le("reactionTime", new BigDecimal(reactionTimeEnd)));
					}
					
					String negativePressureStart = geLeMap.get("negativePressureStart");
					if (StringUtils.isNotEmpty(negativePressureStart)) {
						c.add(Restrictions.ge("negativePressure", new BigDecimal(negativePressureStart)));
					}
					String negativePressureEnd = geLeMap.get("negativePressureEnd");
					if (StringUtils.isNotEmpty(negativePressureEnd)) {
						c.add(Restrictions.le("negativePressure", new BigDecimal(negativePressureEnd)));
					}
					
					String forwardPressureStart = geLeMap.get("forwardPressureStart");
					if (StringUtils.isNotEmpty(forwardPressureStart)) {
						c.add(Restrictions.ge("forwardPressure", new BigDecimal(forwardPressureStart)));
					}
					String forwardPressureEnd = geLeMap.get("forwardPressureEnd");
					if (StringUtils.isNotEmpty(forwardPressureEnd)) {
						c.add(Restrictions.le("forwardPressure", new BigDecimal(forwardPressureEnd)));
					}
					
					c.setFirstResult(start);
					c.setMaxResults(limit);
					
					c.addOrder(Order.desc("uploadTime"));
					
					return c.list();
//					return session.createQuery(hql)
//					.setString("libType", dataLib.getLibType())
//					.setDate("uploadTimeStart", uploadTimeStart)
//					.setDate("uploadTimeEnd", uploadTimeEnd)
//					.setFirstResult(start)
//					.setMaxResults(limit)
//					.list();
				}
	    		
			});
    }
    
    public int getDataLibCountByType(final DataLib dataLib, final Date uploadTimeStart, final Date uploadTimeEnd, final Map<String, String> geLeMap) {
        final String hql = "select count(*) from DataLib d where d.libType=:libType";
        
        return
        this.getHibernateTemplate().execute(new HibernateCallback<Long>() {
    		
			@Override
			public Long doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria c = session.createCriteria(DataLib.class);
				
				Example e = Example.create(dataLib).enableLike().excludeProperty("uploadTime").excludeProperty("libType");
				e.setPropertySelector(mySelector);
				
				c.add(e);
				c.add(Restrictions.eq("libType", dataLib.getLibType()));
				c.add(Restrictions.between("uploadTime", uploadTimeStart, uploadTimeEnd));
				
				String sampleQuantityStart = geLeMap.get("sampleQuantityStart");
				if (StringUtils.isNotEmpty(sampleQuantityStart)) {
					c.add(Restrictions.ge("sampleQuantity", new BigDecimal(sampleQuantityStart)));
				}
				String sampleQuantityEnd = geLeMap.get("sampleQuantityEnd");
				if (StringUtils.isNotEmpty(sampleQuantityEnd)) {
					c.add(Restrictions.le("sampleQuantity", new BigDecimal(sampleQuantityEnd)));
				}
				
				String auraRateStart = geLeMap.get("auraRateStart");
				if (StringUtils.isNotEmpty(auraRateStart)) {
					c.add(Restrictions.ge("auraRate", new BigDecimal(auraRateStart)));
				}
				String auraRateEnd = geLeMap.get("auraRateEnd");
				if (StringUtils.isNotEmpty(auraRateEnd)) {
					c.add(Restrictions.le("auraRate", new BigDecimal(auraRateEnd)));
				}
				
				String activationEnergyStart = geLeMap.get("activationEnergyStart");
				if (StringUtils.isNotEmpty(activationEnergyStart)) {
					c.add(Restrictions.ge("activationEnergy", new BigDecimal(activationEnergyStart)));
				}
				String activationEnergyEnd = geLeMap.get("activationEnergyEnd");
				if (StringUtils.isNotEmpty(activationEnergyEnd)) {
					c.add(Restrictions.le("activationEnergy", new BigDecimal(activationEnergyEnd)));
				}
				
				String preExponentialFactorStart = geLeMap.get("preExponentialFactorStart");
				if (StringUtils.isNotEmpty(preExponentialFactorStart)) {
					c.add(Restrictions.ge("preExponentialFactor", new BigDecimal(preExponentialFactorStart)));
				}
				String preExponentialFactorEnd = geLeMap.get("preExponentialFactorEnd");
				if (StringUtils.isNotEmpty(preExponentialFactorEnd)) {
					c.add(Restrictions.le("preExponentialFactor", new BigDecimal(preExponentialFactorEnd)));
				}
				
				String reactionOrderStart = geLeMap.get("reactionOrderStart");
				if (StringUtils.isNotEmpty(reactionOrderStart)) {
					c.add(Restrictions.ge("reactionOrder", new BigDecimal(reactionOrderStart)));
				}
				String reactionOrderEnd = geLeMap.get("reactionOrderEnd");
				if (StringUtils.isNotEmpty(reactionOrderEnd)) {
					c.add(Restrictions.le("reactionOrder", new BigDecimal(reactionOrderEnd)));
				}
				
				String reactiontStart = geLeMap.get("reactiontStart");
				if (StringUtils.isNotEmpty(reactiontStart)) {
					c.add(Restrictions.ge("reactiont", new BigDecimal(reactiontStart)));
				}
				String reactiontEnd = geLeMap.get("reactiontEnd");
				if (StringUtils.isNotEmpty(reactiontEnd)) {
					c.add(Restrictions.le("reactiont", new BigDecimal(reactiontEnd)));
				}
				
				String reactionTimeStart = geLeMap.get("reactionTimeStart");
				if (StringUtils.isNotEmpty(reactionTimeStart)) {
					c.add(Restrictions.ge("reactionTime", new BigDecimal(reactionTimeStart)));
				}
				String reactionTimeEnd = geLeMap.get("reactionTimeEnd");
				if (StringUtils.isNotEmpty(reactionTimeEnd)) {
					c.add(Restrictions.le("reactionTime", new BigDecimal(reactionTimeEnd)));
				}
				
				String negativePressureStart = geLeMap.get("negativePressureStart");
				if (StringUtils.isNotEmpty(negativePressureStart)) {
					c.add(Restrictions.ge("negativePressure", new BigDecimal(negativePressureStart)));
				}
				String negativePressureEnd = geLeMap.get("negativePressureEnd");
				if (StringUtils.isNotEmpty(negativePressureEnd)) {
					c.add(Restrictions.le("negativePressure", new BigDecimal(negativePressureEnd)));
				}
				
				String forwardPressureStart = geLeMap.get("forwardPressureStart");
				if (StringUtils.isNotEmpty(forwardPressureStart)) {
					c.add(Restrictions.ge("forwardPressure", new BigDecimal(forwardPressureStart)));
				}
				String forwardPressureEnd = geLeMap.get("forwardPressureEnd");
				if (StringUtils.isNotEmpty(forwardPressureEnd)) {
					c.add(Restrictions.le("forwardPressure", new BigDecimal(forwardPressureEnd)));
				}
				
				c.setProjection(Projections.rowCount());
				return (Long) c.uniqueResult();
				
//				return (Long) session.createQuery(hql)
//				.setString("libType", dataLib.getLibType())
//				.uniqueResult();
			}
    		
		}).intValue();
    }
    
    @SuppressWarnings("unchecked")
    public List<DataLib> getUserListByLoginName(String loginName) {
        String hql = "from DataLib u where u.loginName = '" + loginName + "'";
        return (List<DataLib>) this.find(hql);
        
    }
    
}
