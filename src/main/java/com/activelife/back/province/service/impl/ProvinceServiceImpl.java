package com.activelife.back.province.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.province.service.ProvinceService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.province.po.Province;
import com.activelife.db.province.dao.ProvinceDao;

/**
 * 省信息服务实现
 * 
 * @author zhangpanfeng
 * 
 */
@Service
public class ProvinceServiceImpl implements ProvinceService {
    private static final Log LOG = LogFactory.getLog(ProvinceServiceImpl.class);

    @Autowired
    private ProvinceDao provinceDao;

    public String saveProvince(Province province) throws BusinessException {
        LOG.info("start method<saveProvince>" + province);
        provinceDao.saveProvince(province);
        String provinceCode = province.getProvinceCode();

        return provinceCode;
    }

    public int updateProvince(Province province) throws BusinessException {
        LOG.info("start method<updateProvince>" + province);
        int num = provinceDao.updateProvince(province);

        return num;
    }

    public Province findProvinceByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findProvinceByParams>" + params);
        Province province = provinceDao.findProvinceByParams(params);

        return province;
    }

    public Province findProvinceById(String provinceCode) throws BusinessException {
        LOG.info("start method<findProvinceById>" + provinceCode);
        Province province = provinceDao.findProvinceById(provinceCode);

        return province;
    }

    public List<Province> findProvincesByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findProvincesByParams>" + params);
        List<Province> provinceList = provinceDao.findProvincesByParams(params);

        return provinceList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = provinceDao.getTotalCount(params);

        return count;
    }

}
