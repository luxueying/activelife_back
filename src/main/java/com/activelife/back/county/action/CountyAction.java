package com.activelife.back.county.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.city.service.CityService;
import com.activelife.back.county.service.CountyService;
import com.activelife.common.base.po.Page;
import com.activelife.common.city.po.City;
import com.activelife.common.county.po.County;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 县控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class CountyAction extends BaseAction {
    private static final String URL_PREFIX = "/county";
    private static final String COUNTY_EDIT_PAGE = URL_PREFIX + "/countyEditor";
    private static final String COUNTY_LIST_PAGE = URL_PREFIX + "/countyList";
    /**
     * 注入县服务
     */
    @Autowired
    private CountyService countyService;
    /**
     * 注入市服务
     */
    @Autowired
    private CityService cityService;

    @RequestMapping(value = "/showCountyEditor")
    public String showCountyEditor(Model model, County county) throws BusinessException {
        if (!StringUtil.isEmpty(county.getCountyCode())) {
            county = countyService.findCountyById(county.getCountyCode());
            model.addAttribute("county", county);
        }

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<City> cityList = cityService.findCitysByParams(params);
        model.addAttribute("cityList", cityList);

        return COUNTY_EDIT_PAGE;
    }

    @RequestMapping(value = "/showCountyList")
    public String showCountyList(Model model, County county) throws BusinessException {

        return COUNTY_LIST_PAGE;
    }

    @RequestMapping(value = "/editCounty")
    public String editCounty(Model model, County county) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        County dbCounty = countyService.findCountyById(county.getCountyCode());
        if (dbCounty == null) {
            // 新增
            String countyCode = countyService.saveCounty(county);
            if (StringUtil.isEmpty(countyCode)) {
                LOG.info("新增县失败！");
                clientMessage.setMessage("新增县失败！");
            } else {
                model.addAttribute("county", county);
            }
        } else {
            // 更新
            dbCounty.setCountyName(county.getCountyName());
            dbCounty.setEnName(county.getEnName());
            dbCounty.setStatus(county.getStatus());
            int num = countyService.updateCounty(dbCounty);
            if (num != 1) {
                LOG.info("更新县失败！" + county.getCountyCode());
                clientMessage.setMessage("更新县失败！");
            }
            model.addAttribute("county", dbCounty);
        }
        model.addAttribute("clientMessage", clientMessage);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<City> cityList = cityService.findCitysByParams(params);
        model.addAttribute("cityList", cityList);

        return COUNTY_EDIT_PAGE;
    }

    @RequestMapping(value = "/editCountyStatus")
    @ResponseBody
    public Object editCountyStatus(Model model, County county) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", county.getStatus());
        County dbCounty = countyService.findCountyById(county.getCountyCode());
        if (dbCounty == null) {
            LOG.info("更新县状态失败！" + county.getCountyCode());
            clientMessage.setMessage("更新县状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbCounty.setStatus(county.getStatus());
            int num = countyService.updateCounty(dbCounty);
            if (num != 1) {
                LOG.info("更新县状态失败！" + county.getCountyCode());
                clientMessage.setMessage("更新县状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/listCounty")
    public String listCounty(Model model, County county, Page page) throws BusinessException {
        page.setUrl("listCounty");
        Map<String, Object> params = getSearchParams(page);

        if (county != null) {
            // 有条件查询
            params.put("countyCode", county.getCountyCode());
            params.put("countyName", county.getCountyName());
            params.put("enName", county.getEnName());
            params.put("status", county.getStatus());
            params.put("cityCode", county.getCityCode());
            params.put("cityName", county.getCityName());
        }

        List<County> countyList = countyService.findCountysByParams(params);
        int count = countyService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("countyList", countyList);
        model.addAttribute("page", page);

        return COUNTY_LIST_PAGE;
    }
}
