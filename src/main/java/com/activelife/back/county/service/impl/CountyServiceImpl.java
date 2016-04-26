package com.activelife.back.county.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.county.service.CountyService;
import com.activelife.common.county.po.County;
import com.activelife.common.exception.BusinessException;
import com.activelife.db.county.dao.CountyDao;

/**
 * 县级信息服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class CountyServiceImpl implements CountyService {
    private static final Log LOG = LogFactory.getLog(CountyServiceImpl.class);

    @Autowired
    private CountyDao countyDao;

    public String saveCounty(County county) throws BusinessException {
        LOG.info("start method<saveCounty>" + county);
        countyDao.saveCounty(county);
        String countyCode = county.getCountyCode();

        return countyCode;
    }

    public int updateCounty(County county) throws BusinessException {
        LOG.info("start method<updateCounty>" + county);
        int num = countyDao.updateCounty(county);

        return num;
    }

    public County findCountyByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCountyByParams>" + params);
        County county = countyDao.findCountyByParams(params);

        return county;
    }

    public County findCountyById(String countyCode) throws BusinessException {
        LOG.info("start method<findCountyById>" + countyCode);
        County county = countyDao.findCountyById(countyCode);

        return county;
    }

    public List<County> findCountysByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCountysByParams>" + params);
        List<County> countyList = countyDao.findCountysByParams(params);

        return countyList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = countyDao.getTotalCount(params);

        return count;
    }

}
