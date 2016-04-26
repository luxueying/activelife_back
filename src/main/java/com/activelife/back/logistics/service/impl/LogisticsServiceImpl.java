package com.activelife.back.logistics.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.logistics.service.LogisticsService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.logistics.po.Logistics;
import com.activelife.db.logistics.dao.LogisticsDao;

/**
 * 物流服务实现
 * 
 * @author lxy
 * 
 */

@Service
public class LogisticsServiceImpl implements LogisticsService {
    private static final Log LOG = LogFactory.getLog(LogisticsServiceImpl.class);
    @Autowired
    private LogisticsDao logisticsDao;

    public String saveLogistics(Logistics logistics) throws BusinessException {
        LOG.info("start method<saveLogistics>" + logistics);
        logisticsDao.saveLogistics(logistics);
        String logisticsId = logistics.getLogisticsId();

        return logisticsId;
    }

    public int updateLogistics(Logistics logistics) throws BusinessException {
        LOG.info("start method<updateLogistics>" + logistics);
        int num = logisticsDao.updateLogistics(logistics);

        return num;
    }

    public Logistics findLogisticsByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findLogisticsByParams>" + params);
        Logistics logistics = logisticsDao.findLogisticsByParams(params);

        return logistics;
    }

    public Logistics findLogisticsById(String logisticsId) throws BusinessException {
        LOG.info("start method<findLogisticsById>" + logisticsId);
        Logistics logistics = logisticsDao.findLogisticsById(logisticsId);

        return logistics;
    }

    public List<Logistics> findLogisticssByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findLogisticssByParams>" + params);
        List<Logistics> logisticsList = logisticsDao.findLogisticssByParams(params);

        return logisticsList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = logisticsDao.getTotalCount(params);

        return count;
    }

}
