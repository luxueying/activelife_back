package com.activelife.back.product.service;

import java.util.List;
import java.util.Map;

import com.activelife.common.exception.BusinessException;
import com.activelife.common.product.po.Product;

/**
 * 产品服务接口
 * 
 * @author lxy
 * 
 */
public interface ProductService {
    /**
     * 创建产品
     * 
     * @param product
     *            产品信息
     * @return 产品ID
     * 
     * @throws BusinessException
     */
    String saveProduct(Product product) throws BusinessException;

    /**
     * 更新产品
     * 
     * @param product
     * @throws BusinessException
     */
    int updateProduct(Product product) throws BusinessException;

    /**
     * 根据参数查询一个产品
     * 
     * @param params
     *            参数
     * @return 产品信息
     * @throws BusinessException
     */
    Product findProductByParams(Map<String, Object> params) throws BusinessException;

    /**
     * 根据ID查询一个产品
     * 
     * @param productId
     *            产品ID
     * @return 产品信息
     * @throws BusinessException
     */
    Product findProductById(String productId) throws BusinessException;

    /**
     * 查询产品信息列表
     * 
     * @param params
     *            参数
     * @return 产品信息列表
     * @throws BusinessException
     */
    List<Product> findProductsByParams(Map<String, Object> params) throws BusinessException;

    /**
     * 查询产品总条数
     * 
     * @param params
     *            参数
     * @return 产品条数
     * @throws BusinessException
     */
    int getTotalCount(Map<String, Object> params) throws BusinessException;
}
