package com.activelife.back.city.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.city.service.CityService;
import com.activelife.common.city.po.City;
import com.activelife.common.exception.BusinessException;
import com.activelife.db.city.dao.CityDao;

/**
 * 市服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class CityServiceImpl implements CityService {
    private static final Log LOG = LogFactory.getLog(CityServiceImpl.class);

    @Autowired
    private CityDao cityDao;

    public String saveCity(City city) throws BusinessException {
        LOG.info("start method<saveCity>" + city);
        cityDao.saveCity(city);
        String cityCode = city.getCityCode();

        return cityCode;
    }

    public int updateCity(City city) throws BusinessException {
        LOG.info("start method<updateCity>" + city);
        int num = cityDao.updateCity(city);

        return num;
    }

    public City findCityByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCityByParams>" + params);
        City city = cityDao.findCityByParams(params);

        return city;
    }

    public City findCityById(String cityCode) throws BusinessException {
        LOG.info("start method<findCityById>" + cityCode);
        City city = cityDao.findCityById(cityCode);

        return city;
    }

    public List<City> findCitysByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCitysByParams>" + params);
        List<City> cityList = cityDao.findCitysByParams(params);

        return cityList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = cityDao.getTotalCount(params);

        return count;
    }

}
