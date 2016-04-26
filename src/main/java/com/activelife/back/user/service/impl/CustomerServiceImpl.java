package com.activelife.back.user.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.user.service.CustomerService;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.user.po.Customer;
import com.activelife.common.utils.MD5;
import com.activelife.db.user.dao.CustomerDao;

/**
 * 用户服务接口实现
 * 
 * @author zhangpanfeng
 * 
 */
@Service
public class CustomerServiceImpl implements CustomerService {
	private static final Log LOG = LogFactory.getLog(CustomerServiceImpl.class);

	@Autowired
	private CustomerDao customerDao;

	public String saveCustomer(Customer customer) throws BusinessException {
		LOG.info("start method<saveCustomer>" + customer);
		customer.setPassword(MD5.md5(customer.getPassword()));
		customer.setCreateTime(new Date());
		customer.setStatus(CommonEnum.CUSTOMER_STATUS.C.getCode());
		customerDao.saveCustomer(customer);
		String id = customer.getCustomerId();

		return id;
	}

	public int updateCustomer(Customer customer) throws BusinessException {
		LOG.info("start method<updateCustomer>" + customer);
		int num = customerDao.updateCustomer(customer);

		return num;
	}
//按条件查询
	public Customer findCustomerByParams(Map<String, Object> params)
			throws BusinessException {
		LOG.info("start method<findCustomerByParams>" + params);
		Customer customer = customerDao.findCustomerByParams(params);

		return customer;
	}
//按id查询
	public Customer findCustomerById(String customerId)
			throws BusinessException {
		LOG.info("start method<findCustomerById>" + customerId);
		Customer customer = customerDao.findCustomerById(customerId);

		return customer;
	}
//按条件查询
	public List<Customer> findCustomersByParams(Map<String, Object> params)
			throws BusinessException {
		LOG.info("start method<findCustomersByParams>" + params);
		List<Customer> customerList = customerDao.findCustomersByParams(params);

		return customerList;
	}


	public int getTotalCount(Map<String, Object> params)
			throws BusinessException {
		LOG.info("start method<getTotalCount>" + params);
		int count = customerDao.getTotalCount(params);

		return count;
	}

}
