package com.activelife.back.country.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.country.service.CountryService;
import com.activelife.common.country.po.Country;
import com.activelife.common.exception.BusinessException;
import com.activelife.db.country.dao.CountryDao;

/**
 * 国家服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class CountryServiceImpl implements CountryService {
    private static final Log LOG = LogFactory.getLog(CountryServiceImpl.class);

    @Autowired
    private CountryDao countryDao;

    public String saveCountry(Country country) throws BusinessException {
        LOG.info("start method<saveCountry>" + country);
        countryDao.saveCountry(country);
        String countryCode = country.getCountryCode();

        return countryCode;
    }

    public int updateCountry(Country country) throws BusinessException {
        LOG.info("start method<updateCountry>" + country);
        int num = countryDao.updateCountry(country);
        return num;
    }

    public Country findCountryByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCountryByParams>" + params);
        Country country = countryDao.findCountryByParams(params);

        return country;
    }

    public Country findCountryById(String countryCode) throws BusinessException {
        LOG.info("start method<findCountryById>" + countryCode);
        Country country = countryDao.findCountryById(countryCode);

        return country;
    }

    public List<Country> findCountrysByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findCountrysByParams>" + params);
        List<Country> countryList = countryDao.findCountrysByParams(params);

        return countryList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = countryDao.getTotalCount(params);

        return count;
    }

}
