package com.activelife.back.address.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.address.service.ShippingAddressService;
import com.activelife.common.address.po.ShippingAddress;
import com.activelife.common.exception.BusinessException;
import com.activelife.db.address.dao.ShippingAddressDao;

/**
 * 收货地址服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class ShippingAddressServiceImpl implements ShippingAddressService {
    private static final Log LOG = LogFactory.getLog(ShippingAddressServiceImpl.class);

    @Autowired
    private ShippingAddressDao shippingAddressDao;

    public ShippingAddress findShippingAddressById(String addressId) throws BusinessException {
        LOG.info("start method<findShippingAddressById>" + addressId);
        ShippingAddress address = shippingAddressDao.findShippingAddressById(addressId);

        return address;
    }

}
