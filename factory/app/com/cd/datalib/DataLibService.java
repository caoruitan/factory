package com.cd.datalib;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cd.dao.GridData;

@Transactional
@Service("DataLibService")
public class DataLibService {

    @Autowired
	@Qualifier(value = "DataLibDao")
	private DataLibDao dataLibDao;

    private final String[] dateFormatter = new String[]{"yyyy-MM-dd", "yyyy-MM-dd hh:mm"};
    private Date defaultStart = null;
    private Date defaultEnd = null;
    {
    	Calendar startCal = Calendar.getInstance();
    	startCal.set(1970, 1, 1, 0, 0, 0);
    	this.defaultStart = startCal.getTime();

    	Calendar endCal = Calendar.getInstance();
    	endCal.set(2970, 1, 1, 0, 0, 0);
    	this.defaultEnd = endCal.getTime();
    }

    public GridData<DataLib> getDataLibListByType(DataLib dataLib, String uploadTimeStart, String uploadTimeEnd, Map<String, String> geLeMap, String start, String limit) {
    	Date uploadTimeStartDate = null;
    	Date uploadTimeEndDate   = null;
		try {
			uploadTimeStartDate = StringUtils.isEmpty(uploadTimeStart) ? this.defaultStart : DateUtils.parseDate(uploadTimeStart, this.dateFormatter);
			uploadTimeEndDate   = StringUtils.isEmpty(uploadTimeEnd)   ? this.defaultEnd   : DateUtils.parseDate(uploadTimeEnd, this.dateFormatter);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		int startNum = Integer.parseInt(start);
		int limitNum = Integer.parseInt(limit);

        List<DataLib> list = this.dataLibDao.getDataLibListByType(dataLib, uploadTimeStartDate, uploadTimeEndDate, geLeMap, startNum, limitNum);
        int total = this.dataLibDao.getDataLibCountByType(dataLib, uploadTimeStartDate, uploadTimeEndDate, geLeMap);

        GridData<DataLib> grid = new GridData<DataLib>();
        grid.setList(list);
        grid.setTotal(total);
        return grid;
    }

    public DataLib getDataLib(String dataLibId) {
        return this.dataLibDao.get(DataLib.class, dataLibId);
    }

    public List<DataLib> getUserByLoginName(String loginName) {
		return this.dataLibDao.getUserListByLoginName(loginName);
    }

	public void createDataLib(DataLib dataLib) {
		this.dataLibDao.save(dataLib);
    }

	public void updateDataLib(DataLib dataLib) {
		// User user = this.getUser(userId);
		// user.setUserName(userName);
		// user.setSex(sex);
		// user.setPhoneNumber(phone);
		this.dataLibDao.update(dataLib);
    }

	public void deleteDataLib(String id) {
		DataLib dataLib = this.getDataLib(id);
		this.dataLibDao.getHibernateTemplate().delete(dataLib);
    }

	public boolean updateDataLibStatus(String dataLibId, String srcStatusName, String destStatusName) {
		DataLib dataLib = this.dataLibDao.get(DataLib.class, dataLibId);
		dataLib.setStatus(destStatusName);
		this.dataLibDao.update(dataLib);

		return true;
	}

}
