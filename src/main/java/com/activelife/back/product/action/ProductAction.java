package com.activelife.back.product.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.city.service.CityService;
import com.activelife.back.country.service.CountryService;
import com.activelife.back.county.service.CountyService;
import com.activelife.back.product.service.ProductService;
import com.activelife.back.province.service.ProvinceService;
import com.activelife.common.base.po.Page;
import com.activelife.common.city.po.City;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.country.po.Country;
import com.activelife.common.county.po.County;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.product.po.Product;
import com.activelife.common.product.vo.ProductVo;
import com.activelife.common.province.po.Province;
import com.activelife.common.user.po.SystemUser;
import com.activelife.common.utils.DateUtil;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 产品控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class ProductAction extends BaseAction {
    private static final String URL_PREFIX = "/product";
    private static final String PRODUCT_EDIT_PAGE = URL_PREFIX + "/productEditor";
    private static final String PRODUCT_DETAIL_PAGE = URL_PREFIX + "/productDetail";
    private static final String PRODUCT_LIST_PAGE = URL_PREFIX + "/productList";

    @Autowired
    private ProductService productService;
    /**
     * 注入国家服务
     */
    @Autowired
    private CountryService countryService;
    /**
     * 注入省份服务
     */
    @Autowired
    private ProvinceService provinceService;
    /**
     * 注入市服务
     */
    @Autowired
    private CityService cityService;
    /**
     * 注入县服务
     */
    @Autowired
    private CountyService countyService;
//跳转到编辑的页面
    @RequestMapping(value = "/showProductEditor")
    public String showProductEditor(Model model, HttpServletRequest req, Product product) {
        if (!StringUtil.isEmpty(product.getProductId())) {
            product = productService.findProductById(product.getProductId());
            model.addAttribute("product", product);

            this.prepareSelectLocation(model, product);
        }

        return PRODUCT_EDIT_PAGE;
    }
  //更改商品
    @RequestMapping(value = "/editProduct")
    public String editProduct(Model model, HttpServletRequest req, Product product) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        SystemUser systemUser = getSystemUser(req);
        System.out.println("!!!"+product.getProductId()+StringUtil.isEmpty(product.getProductId())+"!!!!!!!!!!");
        if (StringUtil.isEmpty(product.getProductId())) {
            // 新建
            product.setCreateBy(systemUser.getUserName());
            String productId = productService.saveProduct(product);
            if (productId == null) {
                LOG.info("保存产品失败！");
                clientMessage.setMessage("保存产品失败！");
            } else {
                model.addAttribute("product", product);
            }
        } else {
            // 更新
            Product dbProduct = productService.findProductById(product.getProductId());
            if (dbProduct == null) {
                LOG.info("查询产品失败！");
                clientMessage.setMessage("更新产品失败！");
            } else {
                dbProduct.setUpdateBy(systemUser.getUserName());
                dbProduct.setProductName(product.getProductName());
                dbProduct.setProductCode(product.getProductCode());
                dbProduct.setPrice(product.getPrice());
                dbProduct.setStock(product.getStock());

                int num = productService.updateProduct(dbProduct);
                if (num != 1) {
                    LOG.info("更新产品失败！");
                    clientMessage.setMessage("更新产品失败！");
                } else {
                    model.addAttribute("product", dbProduct);
                }
            }
        }

        this.prepareSelectLocation(model, product);

        model.addAttribute("clientMessage", clientMessage);

        return PRODUCT_EDIT_PAGE;
    }

    @RequestMapping(value = "/editProductLocation")
    public String editProductLocation(Model model, HttpServletRequest req, Product product) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        SystemUser systemUser = getSystemUser(req);
        Product dbProduct = productService.findProductById(product.getProductId());
        if (dbProduct == null) {
            LOG.info("查询产品失败！");
            clientMessage.setMessage("更新产品位置信息失败！");
        } else {
            dbProduct.setUpdateBy(systemUser.getUserName());
            dbProduct.setCountryCode(product.getCountryCode());
            dbProduct.setProvinceCode(product.getProvinceCode());
            dbProduct.setCityCode(product.getCityCode());
            dbProduct.setCountyCode(product.getCountyCode());
            dbProduct.setAddress(product.getAddress());

            int num = productService.updateProduct(dbProduct);
            if (num != 1) {
                LOG.info("更新产品位置信息失败！");
                clientMessage.setMessage("更新产品位置信息失败！");
            } else {
                model.addAttribute("product", dbProduct);
            }
        }

        this.prepareSelectLocation(model, dbProduct);

        model.addAttribute("clientMessage", clientMessage);

        return PRODUCT_EDIT_PAGE;
    }
//查看商品的详情
    @RequestMapping(value = "/showProductDetail")
    public String showProductDetail(Model model, HttpServletRequest req, Product product) {
        product = productService.findProductById(product.getProductId());
        ProductVo productVo = this.changePoToVo(product);
        this.prapareDetailLocation(productVo, product);
        model.addAttribute("productVo", productVo);
        // 设置页面标示
        model.addAttribute("flag", "DETAIL");
        this.prepareStatus(model);

        return PRODUCT_DETAIL_PAGE;
    }
//跳转到修改商品状态的页面
    @RequestMapping(value = "/showProductAudit")
    public String showProductAudit(Model model, HttpServletRequest req, Product product) {
        product = productService.findProductById(product.getProductId());
        ProductVo productVo = this.changePoToVo(product);
        this.prapareDetailLocation(productVo, product);
        model.addAttribute("productVo", productVo);
        // 设置页面标示
        model.addAttribute("flag", "AUDIT");
        this.prepareStatus(model);

        return PRODUCT_DETAIL_PAGE;
    }
//更改商品的状态
    @RequestMapping(value = "/auditProduct")
    public String auditProduct(Model model, HttpServletRequest req, Product product) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        SystemUser systemUser = getSystemUser(req);
        Product dbProduct = productService.findProductById(product.getProductId());
        if (dbProduct == null) {
            LOG.info("查询产品失败！");
            clientMessage.setMessage("审核失败！");
        } else {
            dbProduct.setUpdateBy(systemUser.getUserName());
            dbProduct.setStatus(product.getStatus());
            int num = productService.updateProduct(dbProduct);
            if (num != 1) {
                LOG.info("审核失败！");
                clientMessage.setMessage("审核失败！");
            } else {
                ProductVo productVo = this.changePoToVo(dbProduct);
                this.prapareDetailLocation(productVo, dbProduct);
                model.addAttribute("productVo", productVo);
                // 设置页面标示
                model.addAttribute("flag", "DETAIL");
                this.prepareStatus(model);
            }
        }

        model.addAttribute("clientMessage", clientMessage);

        return PRODUCT_DETAIL_PAGE;
    }
//商品列表
    @RequestMapping(value = "/showProductList")
    public String showProductList(Model model, Product product,Page page) throws BusinessException {
    	page.setUrl("showProductList");
    	Map<String, Object> params = new HashMap<String, Object>();
    	List<Product> productList = productService.findProductsByParams(params);
    	int count = productService.getTotalCount(params);
        page.setTotalSize(count);
    	model.addAttribute("productList", productList);
    	model.addAttribute("page", page);
    	this.prepareStatus(model);
        return PRODUCT_LIST_PAGE;
    }

    @RequestMapping(value = "/listProduct")
    public String listProduct(Model model, Product product, Page page) throws BusinessException {
        page.setUrl("listProduct");
        Map<String, Object> params = getSearchParams(page);
        params.put("productCode", product.getProductCode());
        params.put("productName", product.getProductName());
        params.put("address", product.getAddress());
        params.put("createTime", product.getCreateTime());
        params.put("status", product.getStatus());

        List<Product> productList = productService.findProductsByParams(params);
        int count = productService.getTotalCount(params);
        page.setTotalSize(count);
        List<ProductVo> productVoList = new ArrayList<ProductVo>();
        if (productList != null) {
            for (Product p : productList) {
                productVoList.add(this.changePoToVo(p));
            }
        }
        model.addAttribute("productList", productVoList);
        model.addAttribute("page", page);

        this.prepareStatus(model);

        return PRODUCT_LIST_PAGE;
    }

    @RequestMapping(value = "/deleteProduct")
    @ResponseBody
    public Object deleteProduct(HttpServletRequest req, Product product) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        SystemUser systemUser = getSystemUser(req);
        product = productService.findProductById(product.getProductId());
        if (product != null) {
            product.setDeleteBy(systemUser.getUserName());
            product.setDeleteTime(new Date());
            int num = productService.updateProduct(product);
            if (num != 1) {
                LOG.info("删除产品失败！");
                clientMessage.setMessage("删除产品失败！");
                clientMessage.setStatusCode(StatusCode.DELETE_ERROR);
            } else {
                String deleteTime = DateUtil.formatDate(product.getDeleteTime(), DateUtil.HHMMSS_DATE_FORMAT);
                clientMessage.addAttribute("deleteTime", deleteTime);
            }
        } else {
            LOG.info("删除产品失败！");
            clientMessage.setMessage("删除产品失败！");
            clientMessage.setStatusCode(StatusCode.DELETE_ERROR);
        }

        return clientMessage;
    }

    @RequestMapping(value = "/getProvinceList")
    @ResponseBody
    public Object getProvinceList(Product product) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        params.put("countryCode", product.getCountryCode());

        List<Province> provinceList = provinceService.findProvincesByParams(params);

        return provinceList;
    }

    @RequestMapping(value = "/getCityList")
    @ResponseBody
    public Object getCityList(Product product) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        params.put("provinceCode", product.getProvinceCode());

        List<City> cityList = cityService.findCitysByParams(params);

        return cityList;
    }

    @RequestMapping(value = "/getCountyList")
    @ResponseBody
    public Object getCountyList(Product product) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        params.put("cityCode", product.getCityCode());

        List<County> countyList = countyService.findCountysByParams(params);

        return countyList;
    }

    /**
     * 给页面下拉列表准备必要的位置数据
     * 
     * @param model
     * @param product
     */
    private void prepareSelectLocation(Model model, Product product) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        // 查询国家信息
        List<Country> countryList = countryService.findCountrysByParams(params);
        model.addAttribute("countryList", countryList);

        // 查询省份信息
        params.put("countryCode", product.getCountryCode());
        List<Province> provinceList = provinceService.findProvincesByParams(params);
        model.addAttribute("provinceList", provinceList);

        // 查询城市信息
        params.remove("countryCode");
        params.put("provinceCode", product.getProvinceCode());
        List<City> cityList = cityService.findCitysByParams(params);
        model.addAttribute("cityList", cityList);

        // 查询县信息
        params.remove("provinceCode");
        params.put("cityCode", product.getCityCode());
        List<County> countyList = countyService.findCountysByParams(params);
        model.addAttribute("countyList", countyList);

        // 查询图片类型信息
        Map<String, String> imageTypes = new HashMap<String, String>();
        CommonEnum.IMAGE_TYPE[] types = CommonEnum.IMAGE_TYPE.values();
        for (CommonEnum.IMAGE_TYPE type : types) {
            imageTypes.put(type.getCode(), type.getCnName());
        }
        model.addAttribute("imageTypes", imageTypes);
    }

    /**
     * 把产品PO对象装换为VO对象，为页面准备必要的数据
     * 
     * @param product
     * @return
     */
    private ProductVo changePoToVo(Product product) {
        ProductVo productVo = new ProductVo();
        productVo.setProductId(product.getProductId());
        productVo.setProductCode(product.getProductCode());
        productVo.setProductName(product.getProductName());
        productVo.setPrice(StringUtil.getValue(product.getPrice()));
        productVo.setOldPrice(StringUtil.getValue(product.getOldPrice()));
        productVo.setStock(StringUtil.getValue(product.getStock()));
        productVo.setStatus(product.getStatus());
        productVo.setAddress(product.getAddress());
        productVo.setCreateBy(product.getCreateBy());
        productVo.setUpdateBy(product.getUpdateBy());
        productVo.setDeleteBy(product.getDeleteBy());
        productVo.setCreateTime(DateUtil.formatDate(product.getCreateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        productVo.setUpdateTime(DateUtil.formatDate(product.getUpdateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        productVo.setDeleteTime(DateUtil.formatDate(product.getDeleteTime(), DateUtil.HHMMSS_DATE_FORMAT));
        return productVo;
    }

    /**
     * 给产品详情页准备位置信息
     * 
     * @param productVo
     * @param product
     */
    private void prapareDetailLocation(ProductVo productVo, Product product) {
        // 查询国家信息
        Country country = countryService.findCountryById(product.getCountryCode());
        if (country != null) {
            productVo.setCountryName(country.getCountryName());
        }

        // 查询省份信息
        Province province = provinceService.findProvinceById(product.getProvinceCode());
        if (province != null) {
            productVo.setProvinceName(province.getProvinceName());
        }

        // 查询城市信息
        City city = cityService.findCityById(product.getCityCode());
        if (city != null) {
            productVo.setCityName(city.getCityName());
        }
        // 查询县信息
        County county = countyService.findCountyById(product.getCountyCode());
        if (county != null) {
            productVo.setCountyName(county.getCountyName());
        }
    }

    /**
     * 给页面准备状态数据
     * 
     * @param model
     */
    private void prepareStatus(Model model) {
        Map<String, String> productStatus = new HashMap<String, String>();
        CommonEnum.PRODUCT_STATUS[] statusArray = CommonEnum.PRODUCT_STATUS.values();
        for (CommonEnum.PRODUCT_STATUS status : statusArray) {
            productStatus.put(status.getCode(), status.getCnName());
        }

        model.addAttribute("productStatus", productStatus);
    }

}
