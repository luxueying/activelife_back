package com.activelife.back.product.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.product.service.ProductImageService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.product.po.ProductImage;
import com.activelife.db.product.dao.ProductImageDao;

/**
 * 产品图片服务实现
 * 
 * @author lxy
 * 
 */
@Service
public class ProductImageServiceImpl implements ProductImageService {
    private static final Log LOG = LogFactory.getLog(ProductImageServiceImpl.class);
    @Autowired
    private ProductImageDao productImageDao;

    public String saveProductImage(ProductImage image) throws BusinessException {
        LOG.info("start method<saveProductImage>" + image);
        image.setStatus("Y");
        productImageDao.saveProductImage(image);
        String imageId = image.getImageId();

        return imageId;
    }

    public int updateProductImage(ProductImage image) throws BusinessException {
        LOG.info("start method<updateProductImage>" + image);
        int num = productImageDao.updateProductImage(image);

        return num;
    }

    public ProductImage findProductImageById(String imageId) throws BusinessException {
        LOG.info("start method<findProductImageById>" + imageId);
        ProductImage image = productImageDao.findProductImageById(imageId);

        return image;
    }

    public List<ProductImage> findProductImagesByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findProductImagesByParams>" + params);
        List<ProductImage> imageList = productImageDao.findProductImagesByParams(params);

        return imageList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = productImageDao.getTotalCount(params);

        return count;
    }

    public int deleteProductImageById(String imageId) throws BusinessException {
        LOG.info("start method<deleteProductImageById>" + imageId);
        int num = productImageDao.deleteProductImageById(imageId);

        return num;
    }

}
