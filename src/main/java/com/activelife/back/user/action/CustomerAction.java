package com.activelife.back.user.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bouncycastle.asn1.ocsp.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.activelife.back.base.action.BaseAction;
import com.activelife.back.city.service.CityService;
import com.activelife.back.country.service.CountryService;
import com.activelife.back.county.service.CountyService;
import com.activelife.back.province.service.ProvinceService;
import com.activelife.back.user.service.CustomerService;
import com.activelife.common.base.po.Page;
import com.activelife.common.city.po.City;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.country.po.Country;
import com.activelife.common.county.po.County;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.product.po.Product;
import com.activelife.common.product.vo.ProductVo;
import com.activelife.common.province.po.Province;
import com.activelife.common.user.po.Customer;
import com.activelife.common.user.po.SystemUser;
import com.activelife.common.user.vo.CustomerVo;
import com.activelife.common.utils.DateUtil;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;
import com.mysql.fabric.Response;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
/**
 * 用户控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class CustomerAction extends BaseAction {
    /**
     * 注入用户服务
     */
    @Autowired
    private CustomerService customerService;
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
    private static final String URL_PREFIX = "/customer";
    private static final String PRODUCT_EDIT_PAGE = URL_PREFIX + "/customerEditor";
    private static final String PRODUCT_DETAIL_PAGE = URL_PREFIX + "/customerDetail";
    private static final String PRODUCT_LIST_PAGE = URL_PREFIX + "/customerList2";
    private ObjectMapper jsonMapper = new ObjectMapper();
    /**
     * 所有用户列表
     * @throws IOException 
     * @throws JsonMappingException 
     * @throws JsonGenerationException 
     */  
    @RequestMapping(value = "/showCustomerList")
    public String findCustomerList(Model model, Customer customer, Page page) throws BusinessException {
    	LOG.info("跳转到所有用户列表!!!!!!!!!!!");
    	/*page.setUrl("customerList");
    	Map<String, Object> params = new HashMap<String, Object>();
        List<Customer> customerList = customerService.findCustomersByParams(params);
        int count=customerService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("customerList", customerList);
        model.addAttribute("page",page);
        this.prepareStatus(model);*/
        return PRODUCT_LIST_PAGE;
    }
    
  /*  @RequestMapping(value="/showCustomerList")
    public String SearchEmployees(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException
    {	
    	LOG.info("所用用户列表!!!!!!!!!!!");
    	
    	Map<String, Object> params = new HashMap<String, Object>();
    	List<Customer> customerList = customerService.findCustomersByParams(params);
		System.out.println(customerList.size());
    	//转成json字符串
		String json=jsonMapper.writeValueAsString(customerList);
    	System.out.println(json);
		return json;
    }*/
    
    /**
     * 根据条件查询
     * @throws IOException 
     * @throws JsonMappingException 
     * @throws JsonGenerationException 
     */   
    @RequestMapping(value="/listCustomer")
    public String listCustomer(Model model, Customer customer, Page page) throws BusinessException, JsonGenerationException, JsonMappingException, IOException {
    	LOG.info("根据条件查询用户!!!!!!!!!!!");
    	page.setUrl("listCustomer");
        Map<String, Object> params = getSearchParams(page);
        params.put("customerCode", customer.getCustomerId());
        params.put("customerName", customer.getRealName());
        params.put("address", customer.getAddress());
        params.put("createTime", customer.getCreateTime());
        params.put("status", customer.getStatus());
        List<Customer> customerList =customerService.findCustomersByParams(params);
        /*int count = customerService.getTotalCount(params);
        page.setTotalSize(count);
        List<CustomerVo> customerVoList = new ArrayList<CustomerVo>();
        if (customerList != null) {
            for (Customer c : customerList) {
            	customerVoList.add(this.changePoToVo(c));
            }
        }
        model.addAttribute("customerList", customerVoList);
        model.addAttribute("page", page);
        this.prepareStatus(model);*/
        String json=jsonMapper.writeValueAsString(customerList);
        System.out.println(json);
        return json;
    }
    
    
//   查看用户个人详细信息
    @RequestMapping( value="/showCustomerDetail")
    public String showCustomerDetail(Model model, HttpServletRequest req, Customer customer) {
    	customer = customerService.findCustomerById(customer.getCustomerId());
        CustomerVo customerVo = this.changePoToVo(customer);
        this.prapareDetailLocation(customerVo, customer);
        model.addAttribute("customerVo", customerVo);
        // 设置页面标示
        model.addAttribute("flag", "DETAIL");
        this.prepareStatus(model);

        return PRODUCT_DETAIL_PAGE;
    }
// 跳转到修改状态 页面
    @RequestMapping(value = "/showCustomerAudit")
    public String showCustomerAudit(Model model, HttpServletRequest req, Customer customer) {
        customer = customerService.findCustomerById(customer.getCustomerId());
        CustomerVo customerVo = this.changePoToVo(customer);
        this.prapareDetailLocation(customerVo, customer);
        model.addAttribute("customerVo", customerVo);
        // 设置页面标示
        model.addAttribute("flag", "AUDIT");
        this.prepareStatus(model);

        return PRODUCT_DETAIL_PAGE;
    }
  //更改用户的状态
    @RequestMapping(value = "/auditCustomer")
    public String auditCustomer(Model model, HttpServletRequest req, Customer customer) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        Customer dbCustomer =customerService.findCustomerById(customer.getCustomerId());
        if (dbCustomer == null) {
            LOG.info("查询用户失败！");
            clientMessage.setMessage("审核失败！");
        } else {
        	dbCustomer.setStatus(customer.getStatus());
            int num = customerService.updateCustomer(dbCustomer);
            if (num != 1) {
                LOG.info("审核失败！");
                clientMessage.setMessage("审核失败！");
            } else {
                CustomerVo customerVo = this.changePoToVo(dbCustomer);
                this.prapareDetailLocation(customerVo, dbCustomer);
                model.addAttribute("customerVo", customerVo);
                // 设置页面标示
                model.addAttribute("flag", "DETAIL");
                this.prepareStatus(model);
            }
        }

        model.addAttribute("clientMessage", clientMessage);

        return PRODUCT_DETAIL_PAGE;
    }
    
//   跳转到编辑页面
    @RequestMapping(value = "/showCustomerEditor")
    public String showCustomerEditor(Model model, HttpServletRequest req, Customer customer) {
        if (!StringUtil.isEmpty(customer.getCustomerId())) {
        	customer = customerService.findCustomerById(customer.getCustomerId());
            model.addAttribute("customer", customer);
            this.prepareSelectLocation(model, customer);
        }

        return PRODUCT_EDIT_PAGE;
    }
//  修改保存用户信息
    @RequestMapping(value = "/editCustomer")
    public String editCustomer(Model model, HttpServletRequest req, Customer customer) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        if (StringUtil.isEmpty(customer.getCustomerId())) {      
            String customerId = customerService.saveCustomer(customer);
            if (customerId == null) {
                LOG.info("保存用户失败！");
                clientMessage.setMessage("保存产品失败！");
            } else {
                model.addAttribute("customer", customer);
            }
        } else {
           // 更新
            Customer dbCustomer = customerService.findCustomerById(customer.getCustomerId());
            if (dbCustomer == null) {
                LOG.info("查询用户失败！");
                clientMessage.setMessage("更新用户失败！");
            } else {
            
            	dbCustomer.setEmail(customer.getEmail());
                int num = customerService.updateCustomer(dbCustomer);
                if (num != 1) {
                    LOG.info("更新用户失败！");
                    clientMessage.setMessage("更新用户失败！");
                } else {
                    model.addAttribute("customer", dbCustomer);
                }
            }
        }

        this.prepareSelectLocation(model, customer);
        model.addAttribute("clientMessage", clientMessage);
        return PRODUCT_EDIT_PAGE;
    }
//    删除用户
    @RequestMapping(value = "/deleteCustomer")
    public String deleteCustomer(Model model, HttpServletRequest req, Customer customer){
    	 ClientMessage clientMessage = new ClientMessage();
         SystemUser systemUser = getSystemUser(req); 
    	//删除，把用户的状态设置成D
        Customer dbCustomer = customerService.findCustomerById(customer.getCustomerId());
        if (dbCustomer == null) {
            LOG.info("查询用户失败！");
            clientMessage.setMessage("更新用户失败！");
        } else {
        	dbCustomer.setDeleteBy(systemUser.getUserName());
        	dbCustomer.setStatus("D");
            int num = customerService.updateCustomer(dbCustomer);
            if (num != 1) {
                LOG.info("删除用户失败！");
                clientMessage.setMessage("删除用户失败！");
            } else {
                model.addAttribute("customer", dbCustomer);
            }
        }

    this.prepareSelectLocation(model, customer);
    model.addAttribute("clientMessage", clientMessage);
    return PRODUCT_LIST_PAGE;
}
    /**
     * 给页面下拉列表准备必要的位置数据
     * 
     * @param model
     * @param product
     */
    private void prepareSelectLocation(Model model, Customer customer) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        // 查询国家信息
        List<Country> countryList = countryService.findCountrysByParams(params);
        model.addAttribute("countryList", countryList);

        // 查询省份信息
        params.put("countryCode", customer.getCountryCode());
        List<Province> provinceList = provinceService.findProvincesByParams(params);
        model.addAttribute("provinceList", provinceList);

        // 查询城市信息
        params.remove("countryCode");
        params.put("provinceCode", customer.getProvinceCode());
        List<City> cityList = cityService.findCitysByParams(params);
        model.addAttribute("cityList", cityList);

        // 查询县信息
        params.remove("provinceCode");
        params.put("cityCode", customer.getCityCode());
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
     * @param customer
     * @return
     */
    private CustomerVo changePoToVo(Customer customer) {
        CustomerVo customerVo = new CustomerVo();
        
        customerVo.setCustomerId(customer.getCustomerId());
        customerVo.setRealName(customer.getRealName());
        customerVo.setNewPassword(customer.getNickName());
        customerVo.setPhoneNumber(customer.getPhoneNumber());
        customerVo.setPassword(customer.getPassword());
        customerVo.setHeadPhoto(customer.getHeadPhoto());
        customerVo.setEmail(customer.getEmail());
        customerVo.setAddress(customer.getAddress());
        customerVo.setCountryCode(customer.getCountryCode());
        customerVo.setProvinceCode(customer.getProvinceCode());
        customerVo.setCityCode(customer.getCityCode());
        customerVo.setCountyCode(customer.getCountyCode());
        customerVo.setIsMarried(customer.getIsMarried());
        customerVo.setBirthday(customer.getBirthday());
        customerVo.setGender(customer.getGender());
        customerVo.setStatus(customer.getStatus());
        customerVo.setAddressId(customer.getAddressId());
        LOG.info("in po to vo!!!!!!!!!!!!!!!!!!!!!!");
        customerVo.setDeleteBy(customer.getDeleteBy());
        customerVo.setCreateTime(DateUtil.formatDate(customer.getCreateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        customerVo.setUpdateTime(DateUtil.formatDate(customer.getUpdateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        customerVo.setDeleteTime(DateUtil.formatDate(customer.getDeleteTime(), DateUtil.HHMMSS_DATE_FORMAT));
        return customerVo; 
        
    }
    /**
     * 给产品详情页准备位置信息
     * 
     * @param customerVo
     * @param customer
     */
    private void prapareDetailLocation(CustomerVo customerVo, Customer customer) {
        // 查询国家信息
       LOG.info("给产品详情页准备位置信息!!!!!!!!!!!!!!");
    	Country country = countryService.findCountryById(customer.getCountryCode());
        if (country != null) {
        	customerVo.setCountryCode(customer.getCountryCode());
        }

        // 查询省份信息
        Province province = provinceService.findProvinceById(customer.getProvinceCode());
        if (province != null) {
            customerVo.setProvinceCode(province.getProvinceCode());
        }

        // 查询城市信息
        City city = cityService.findCityById(customer.getCityCode());
        if (city != null) {
            customerVo.setCityCode(city.getCityCode());
        }
        // 查询县信息
        County county = countyService.findCountyById(customer.getCountyCode());
        if (county != null) {
            customerVo.setCountyCode(county.getCountyCode());
        }
    }

    /**
     * 给页面准备状态数据
     * 
     * @param model
     */
    private void prepareStatus(Model model) {
        Map<String, String> customerStatus = new HashMap<String, String>();
        CommonEnum.CUSTOMER_STATUS[] statusArray = CommonEnum.CUSTOMER_STATUS.values();
        for (CommonEnum.CUSTOMER_STATUS status : statusArray) {
        	customerStatus.put(status.getCode(), status.getCnName());
        }

        model.addAttribute("customerStatus", customerStatus);
    }
}
