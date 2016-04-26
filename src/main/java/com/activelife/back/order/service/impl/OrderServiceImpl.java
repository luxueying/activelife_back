package com.activelife.back.order.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.order.service.OrderService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.order.po.Order;
import com.activelife.db.order.dao.OrderDao;

/**
 * 订单服务接口实现
 * 
 * @author lxy
 * 
 */
@Service
public class OrderServiceImpl implements OrderService {
    private static final Log LOG = LogFactory.getLog(OrderServiceImpl.class);

    @Autowired
    private OrderDao orderDao;

    public String saveOrder(Order order) throws BusinessException {
        LOG.info("start method<saveOrder>" + order);
        orderDao.saveOrder(order);
        String id = order.getOrderId();

        return id;
    }

    public int updateOrder(Order order) throws BusinessException {
        LOG.info("start method<updateOrder>" + order);
        int num = orderDao.updateOrder(order);

        return num;
    }

    public Order findOrderByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findOrderByParams>" + params);
        Order order = orderDao.findOrderByParams(params);

        return order;
    }

    public Order findOrderById(String orderId) throws BusinessException {
        LOG.info("start method<findOrderById>" + orderId);
        Order order = orderDao.findOrderById(orderId);

        return order;
    }

    public List<Order> findOrdersByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findOrdersByParams>" + params);
        List<Order> orderList = orderDao.findOrdersByParams(params);

        return orderList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = orderDao.getTotalCount(params);

        return count;
    }

}
