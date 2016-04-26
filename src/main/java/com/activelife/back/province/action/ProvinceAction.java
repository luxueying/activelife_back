package com.activelife.back.province.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.country.service.CountryService;
import com.activelife.back.province.service.ProvinceService;
import com.activelife.common.base.po.Page;
import com.activelife.common.country.po.Country;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.province.po.Province;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 省份控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class ProvinceAction extends BaseAction {
    private static final String URL_PREFIX = "/province";
    private static final String PROVINCE_EDIT_PAGE = URL_PREFIX + "/provinceEditor";
    private static final String PROVINCE_LIST_PAGE = URL_PREFIX + "/provinceList";
    /**
     * 注入省份服务
     */
    @Autowired
    private ProvinceService provinceService;
    /**
     * 注入国家服务
     */
    @Autowired
    private CountryService countryService;

    @RequestMapping(value = "/showProvinceEditor")
    public String showProvinceEditor(Model model, Province province) throws BusinessException {
        if (!StringUtil.isEmpty(province.getProvinceCode())) {
            province = provinceService.findProvinceById(province.getProvinceCode());
            model.addAttribute("province", province);
        }

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<Country> countryList = countryService.findCountrysByParams(params);
        model.addAttribute("countryList", countryList);

        return PROVINCE_EDIT_PAGE;
    }

    @RequestMapping(value = "/showProvinceList")
    public String showProvinceList(Model model, Province province) throws BusinessException {

        return PROVINCE_LIST_PAGE;
    }

    @RequestMapping(value = "/editProvince")
    public String editProvince(Model model, Province province) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        Province dbProvince = provinceService.findProvinceById(province.getProvinceCode());
        if (dbProvince == null) {
            // 新增
            String provinceCode = provinceService.saveProvince(province);
            if (StringUtil.isEmpty(provinceCode)) {
                LOG.info("新增省份失败！");
                clientMessage.setMessage("新增省份失败！");
            } else {
                model.addAttribute("province", province);
            }
        } else {
            // 更新
            dbProvince.setProvinceName(province.getProvinceName());
            dbProvince.setEnName(province.getEnName());
            dbProvince.setStatus(province.getStatus());
            int num = provinceService.updateProvince(dbProvince);
            if (num != 1) {
                LOG.info("更新省份失败！" + province.getProvinceCode());
                clientMessage.setMessage("更新省份失败！");
            }
            model.addAttribute("province", dbProvince);
        }
        model.addAttribute("clientMessage", clientMessage);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<Country> countryList = countryService.findCountrysByParams(params);
        model.addAttribute("countryList", countryList);

        return PROVINCE_EDIT_PAGE;
    }

    @RequestMapping(value = "/editProvinceStatus")
    @ResponseBody
    public Object editProvinceStatus(Model model, Province province) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", province.getStatus());
        Province dbProvince = provinceService.findProvinceById(province.getProvinceCode());
        if (dbProvince == null) {
            LOG.info("更新省份状态失败！" + province.getProvinceCode());
            clientMessage.setMessage("更新省份状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbProvince.setStatus(province.getStatus());
            int num = provinceService.updateProvince(dbProvince);
            if (num != 1) {
                LOG.info("更新省份状态失败！" + province.getProvinceCode());
                clientMessage.setMessage("更新省份状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/listProvince")
    public String listProvince(Model model, Province province, Page page) throws BusinessException {
        page.setUrl("listProvince");
        Map<String, Object> params = getSearchParams(page);

        if (province != null) {
            // 有条件查询
            params.put("provinceCode", province.getProvinceCode());
            params.put("provinceName", province.getProvinceName());
            params.put("enName", province.getEnName());
            params.put("status", province.getStatus());
            params.put("countryCode", province.getCountryCode());
            params.put("countryName", province.getCountryName());
        }

        List<Province> provinceList = provinceService.findProvincesByParams(params);
        int count = provinceService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("provinceList", provinceList);
        model.addAttribute("page", page);

        return PROVINCE_LIST_PAGE;
    }
}
