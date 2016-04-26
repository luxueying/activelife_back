package com.activelife.back.address.service;

import com.activelife.common.address.po.ShippingAddress;
import com.activelife.common.exception.BusinessException;

/**
 * 收货地址服务接口
 * 
 * @author lxy
 * 
 */
public interface ShippingAddressService {

    /**
     * 根据ID查询收货地址
     * 
     * @param addressId
     *            地址ID
     * @return 地址信息
     * @throws BusinessException
     */
    ShippingAddress findShippingAddressById(String addressId) throws BusinessException;
}
