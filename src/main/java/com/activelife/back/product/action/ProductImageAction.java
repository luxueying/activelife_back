package com.activelife.back.product.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.product.service.ProductImageService;
import com.activelife.back.product.service.ProductService;
import com.activelife.back.utils.FileUpload;
import com.activelife.common.base.po.Page;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.product.po.Product;
import com.activelife.common.product.po.ProductImage;
import com.activelife.common.product.vo.ProductImageVo;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 
 * @author lxy
 * 
 */
@Controller
public class ProductImageAction extends BaseAction {
    private static final String URL_PREFIX = "/product";
    private static final String PRODUCT_IMAGE_LIST_PAGE = URL_PREFIX + "/productImageList";
    private static final String PRODUCT_IMAGE_EDIT_PAGE = URL_PREFIX + "/productImageEditor";
    /**
     * 注入产品图片服务
     */
    @Autowired
    private ProductImageService productImageService;
    /**
     * 注入产品服务
     */
    @Autowired
    private ProductService productService;

    @Value("${darren_back.uploadFolder}")
    private String folderName;

    @Value("${darren_back.productImageFieldName}")
    private String fieldName;

    @RequestMapping(value = "/uploadProductImage")
    @ResponseBody
    public Object uploadProductImage(HttpServletRequest req, ProductImage productImage) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        String filePath = null;
        if (CommonEnum.IMAGE_TYPE.COMPUTER_HOME_PAGE.getCode().equals(productImage.getImageType())
                || CommonEnum.IMAGE_TYPE.PHONE_HOME_PAGE.getCode().equals(productImage.getImageType())) {

            Map<String, Object> params = new HashMap<String, Object>();
            params.put("imageType", productImage.getImageType());
            params.put("productId", productImage.getProductId());

            List<ProductImage> imageList = productImageService.findProductImagesByParams(params);
            if (imageList != null) {
                if (imageList.size() == 0) {
                    try {
                        filePath = FileUpload.uploadFile(req, fieldName, folderName);
                        productImage.setImageUrl(filePath);
                        String imageId = productImageService.saveProductImage(productImage);
                        if (imageId == null) {
                            LOG.info(productImage.getImageType() + "类型的图片保存失败！");
                            clientMessage.setMessage(productImage.getImageType() + "类型的图片保存失败！");
                            clientMessage.setStatusCode(StatusCode.CREATE_ERROR);
                        } else {
                            clientMessage.addAttribute("url", productImage.getImageUrl());
                            clientMessage.addAttribute("imageId", imageId);
                        }
                    } catch (Exception e) {
                        LOG.info(productImage.getImageType() + "类型的图片保存失败！");
                        clientMessage.setMessage(productImage.getImageType() + "类型的图片保存失败！");
                        clientMessage.setStatusCode(StatusCode.CREATE_ERROR);
                    }

                } else {
                    LOG.info(productImage.getImageType() + "类型的图片已存在！");
                    clientMessage.setMessage(productImage.getImageType() + "类型的图片已存在！");
                    clientMessage.setStatusCode(StatusCode.CREATE_ERROR);
                }
            }
        } else {
            try {
                filePath = FileUpload.uploadFile(req, fieldName, folderName);
                productImage.setImageUrl(filePath);
                String imageId = productImageService.saveProductImage(productImage);
                if (imageId == null) {
                    LOG.info(productImage.getImageType() + "类型的图片保存失败！");
                    clientMessage.setMessage(productImage.getImageType() + "类型的图片保存失败！");
                    clientMessage.setStatusCode(StatusCode.CREATE_ERROR);
                } else {
                    clientMessage.addAttribute("url", productImage.getImageUrl());
                    clientMessage.addAttribute("imageId", imageId);
                }
            } catch (Exception e) {
                e.printStackTrace();
                LOG.info(productImage.getImageType() + "类型的图片保存失败！");
                clientMessage.setMessage(productImage.getImageType() + "类型的图片保存失败！");
                clientMessage.setStatusCode(StatusCode.CREATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/deleteProductImage")
    @ResponseBody
    public Object deleteProductImage(HttpServletRequest req, ProductImage productImage) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        String targetPath = req.getSession().getServletContext().getRealPath(folderName);
        targetPath = targetPath.substring(0, targetPath.length() - folderName.length());
        String imageId = productImage.getImageId();
        productImage = productImageService.findProductImageById(imageId);
        if (productImage != null) {
            String filePath = targetPath + productImage.getImageUrl();
            boolean result = FileUpload.deleteFile(filePath);
            if (result) {
                productImageService.deleteProductImageById(imageId);
                LOG.info("删除成功！");
                clientMessage.setMessage("删除成功！");
            } else {
                LOG.info("删除失败！");
                clientMessage.setMessage("删除失败！");
                clientMessage.setStatusCode(StatusCode.DELETE_ERROR);
            }
        } else {
            LOG.info("查找失败失败！" + imageId);
            clientMessage.setMessage("删除失败！");
            clientMessage.setStatusCode(StatusCode.DELETE_ERROR);
        }

        return clientMessage;
    }

    @RequestMapping(value = "/showProductImageList")
    public String showProductImageList(Model model, ProductImage productImage) throws BusinessException {
        this.prepareImageType(model);

        return PRODUCT_IMAGE_LIST_PAGE;
    }

    @RequestMapping(value = "/listProductImage")
    public String listProductImage(Model model, ProductImage productImage, Page page) throws BusinessException {
        page.setUrl("listProductImage");
        Map<String, Object> params = getSearchParams(page);
        params.put("imageType", productImage.getImageType());
        params.put("status", productImage.getStatus());

        List<ProductImage> productImageList = productImageService.findProductImagesByParams(params);
        List<ProductImageVo> productImageVoList = new ArrayList<ProductImageVo>();
        if (productImageList != null) {
            for (ProductImage image : productImageList) {
                Product product = productService.findProductById(image.getProductId());
                ProductImageVo productImageVo = changePoToVo(image);
                productImageVo.setProductName(product.getProductName());
                productImageVoList.add(productImageVo);
            }
        }
        int count = productImageService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("productImageVoList", productImageVoList);
        model.addAttribute("page", page);

        this.prepareImageType(model);

        return PRODUCT_IMAGE_LIST_PAGE;
    }

    @RequestMapping(value = "/showProductImageEditor")
    public String showProductImageEditor(Model model, ProductImage productImage) throws BusinessException {
        if (!StringUtil.isEmpty(productImage.getImageId())) {
            productImage = productImageService.findProductImageById(productImage.getImageId());
            model.addAttribute("productImage", productImage);
        }

        this.prepareImageType(model);

        return PRODUCT_IMAGE_EDIT_PAGE;
    }

    @RequestMapping(value = "/editProductImage")
    @ResponseBody
    public Object editProductImage(Model model, ProductImage productImage) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        ProductImage dbProductImage = productImageService.findProductImageById(productImage.getImageId());
        if (dbProductImage == null) {
            LOG.info("更新图片状态失败！" + productImage.getImageId());
            clientMessage.setMessage("更新图片状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            if (CommonEnum.IMAGE_TYPE.COMPUTER_HOME_PAGE.getCode().equals(productImage.getImageType())
                    || CommonEnum.IMAGE_TYPE.PHONE_HOME_PAGE.getCode().equals(productImage.getImageType())) {

                Map<String, Object> params = new HashMap<String, Object>();
                params.put("imageType", productImage.getImageType());
                params.put("productId", productImage.getProductId());

                List<ProductImage> imageList = productImageService.findProductImagesByParams(params);
                if (imageList != null) {
                    if (imageList.size() == 0) {
                        dbProductImage.setStatus(productImage.getStatus());
                        dbProductImage.setImageType(productImage.getImageType());
                        int num = productImageService.updateProductImage(dbProductImage);
                        if (num != 1) {
                            LOG.info("更新图片失败！" + productImage.getImageId());
                            clientMessage.setMessage("更新图片失败！");
                            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
                        }
                    } else {
                        LOG.info(productImage.getImageType() + "类型的图片已存在！");
                        clientMessage.setMessage(productImage.getImageType() + "类型的图片已存在！");
                        clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
                    }
                }
            } else {
                dbProductImage.setStatus(productImage.getStatus());
                dbProductImage.setImageType(productImage.getImageType());
                int num = productImageService.updateProductImage(dbProductImage);
                if (num != 1) {
                    LOG.info("更新图片失败！" + productImage.getImageId());
                    clientMessage.setMessage("更新图片失败！");
                    clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
                }
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/editProductImageStatus")
    @ResponseBody
    public Object editProductImageStatus(Model model, ProductImage productImage) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", productImage.getStatus());
        ProductImage dbProductImage = productImageService.findProductImageById(productImage.getImageId());
        if (dbProductImage == null) {
            LOG.info("更新图片状态失败！" + productImage.getImageId());
            clientMessage.setMessage("更新图片状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbProductImage.setStatus(productImage.getStatus());
            int num = productImageService.updateProductImage(dbProductImage);
            if (num != 1) {
                LOG.info("更新图片状态失败！" + productImage.getImageId());
                clientMessage.setMessage("更新图片状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    /**
     * 给页面准备状态数据
     * 
     * @param model
     */
    private void prepareImageType(Model model) {
        Map<String, String> imageTypes = new HashMap<String, String>();
        CommonEnum.IMAGE_TYPE[] imageType = CommonEnum.IMAGE_TYPE.values();
        for (CommonEnum.IMAGE_TYPE type : imageType) {
            imageTypes.put(type.getCode(), type.getCnName());
        }

        model.addAttribute("imageTypes", imageTypes);
    }

    private ProductImageVo changePoToVo(ProductImage productImage) {
        ProductImageVo productImageVo = new ProductImageVo();
        productImageVo.setImageId(productImage.getImageId());
        productImageVo.setImageType(productImage.getImageType());
        productImageVo.setImageUrl(productImage.getImageUrl());
        productImageVo.setStatus(productImage.getStatus());
        productImageVo.setProductId(productImage.getProductId());

        return productImageVo;
    }
}
