package com.activelife.back.logistics.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.logistics.service.LogisticsCompanyService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.logistics.po.LogisticsCompany;
import com.activelife.db.logistics.dao.LogisticsCompanyDao;

/**
 * 物流公司服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class LogisticsCompanyServiceImpl implements LogisticsCompanyService {
    private static final Log LOG = LogFactory.getLog(LogisticsCompanyServiceImpl.class);
    @Autowired
    private LogisticsCompanyDao logisticsCompanyDao;

    public String saveLogisticsCompany(LogisticsCompany company) throws BusinessException {
        LOG.info("start method<saveLogisticsCompany>" + company);
        logisticsCompanyDao.saveLogisticsCompany(company);
        String companyId = company.getCompanyId();

        return companyId;
    }

    public int updateLogisticsCompany(LogisticsCompany company) throws BusinessException {
        LOG.info("start method<updateLogisticsCompany>" + company);
        int num = logisticsCompanyDao.updateLogisticsCompany(company);

        return num;
    }

    public LogisticsCompany findLogisticsCompanyById(String companyId) throws BusinessException {
        LOG.info("start method<findLogisticsCompanyById>" + companyId);
        LogisticsCompany company = logisticsCompanyDao.findLogisticsCompanyById(companyId);

        return company;
    }

    public List<LogisticsCompany> findLogisticsCompanysByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findLogisticsCompanysByParams>" + params);
        List<LogisticsCompany> companyList = logisticsCompanyDao.findLogisticsCompanysByParams(params);

        return companyList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = logisticsCompanyDao.getTotalCount(params);

        return count;
    }

}
