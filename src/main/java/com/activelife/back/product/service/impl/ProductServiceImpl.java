package com.activelife.back.product.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.product.service.ProductService;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.product.po.Product;
import com.activelife.db.product.dao.ProductDao;

/**
 * 产品服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class ProductServiceImpl implements ProductService {
    private static final Log LOG = LogFactory.getLog(ProductServiceImpl.class);
    @Autowired
    private ProductDao productDao;

    public String saveProduct(Product product) throws BusinessException {
        LOG.info("start method<saveProduct>" + product);
        product.setCreateTime(new Date());
        // 默认未审核
        product.setStatus(CommonEnum.PRODUCT_STATUS.UNAUDITED.getCode());
        productDao.saveProduct(product);
        String productId = product.getProductId();

        return productId;
    }

    public int updateProduct(Product product) throws BusinessException {
        LOG.info("start method<updateProduct>" + product);
        product.setUpdateTime(new Date());
        int num = productDao.updateProduct(product);

        return num;
    }

    public Product findProductByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findProductByParams>" + params);
        Product product = productDao.findProductByParams(params);

        return product;
    }

    public Product findProductById(String productId) throws BusinessException {
        LOG.info("start method<findProductById>" + productId);
        Product product = productDao.findProductById(productId);

        return product;
    }

    public List<Product> findProductsByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findProductsByParams>" + params);
        List<Product> productList = productDao.findProductsByParams(params);

        return productList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = productDao.getTotalCount(params);

        return count;
    }

}
