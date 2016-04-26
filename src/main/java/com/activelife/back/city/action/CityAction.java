package com.activelife.back.city.action;

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
import com.activelife.back.province.service.ProvinceService;
import com.activelife.common.base.po.Page;
import com.activelife.common.city.po.City;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.province.po.Province;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 市控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class CityAction extends BaseAction {
    private static final String URL_PREFIX = "/city";
    private static final String CITY_EDIT_PAGE = URL_PREFIX + "/cityEditor";
    private static final String CITY_LIST_PAGE = URL_PREFIX + "/cityList";
    /**
     * 注入市服务
     */
    @Autowired
    private CityService cityService;
    /**
     * 注入省份服务
     */
    @Autowired
    private ProvinceService provinceService;

    @RequestMapping(value = "/showCityEditor")
    public String showCityEditor(Model model, City city) throws BusinessException {
        if (!StringUtil.isEmpty(city.getCityCode())) {
            city = cityService.findCityById(city.getCityCode());
            model.addAttribute("city", city);
        }

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<Province> provinceList = provinceService.findProvincesByParams(params);
        model.addAttribute("provinceList", provinceList);

        return CITY_EDIT_PAGE;
    }

    @RequestMapping(value = "/showCityList")
    public String showCityList(Model model, City city) throws BusinessException {

        return CITY_LIST_PAGE;
    }

    @RequestMapping(value = "/editCity")
    public String editCity(Model model, City city) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        City dbCity = cityService.findCityById(city.getCityCode());
        if (dbCity == null) {
            // 新增
            String cityCode = cityService.saveCity(city);
            if (StringUtil.isEmpty(cityCode)) {
                LOG.info("新增城市失败！");
                clientMessage.setMessage("新增城市失败！");
            } else {
                model.addAttribute("city", city);
            }
        } else {
            // 更新
            dbCity.setCityName(city.getCityName());
            dbCity.setEnName(city.getEnName());
            dbCity.setStatus(city.getStatus());
            int num = cityService.updateCity(dbCity);
            if (num != 1) {
                LOG.info("更新城市失败！" + city.getCityCode());
                clientMessage.setMessage("更新城市失败！");
            }
            model.addAttribute("city", dbCity);
        }
        model.addAttribute("clientMessage", clientMessage);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", "Y");
        List<Province> provinceList = provinceService.findProvincesByParams(params);
        model.addAttribute("provinceList", provinceList);

        return CITY_EDIT_PAGE;
    }

    @RequestMapping(value = "/editCityStatus")
    @ResponseBody
    public Object editCityStatus(Model model, City city) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", city.getStatus());
        City dbCity = cityService.findCityById(city.getCityCode());
        if (dbCity == null) {
            LOG.info("更新城市状态失败！" + city.getCityCode());
            clientMessage.setMessage("更新城市状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbCity.setStatus(city.getStatus());
            int num = cityService.updateCity(dbCity);
            if (num != 1) {
                LOG.info("更新城市状态失败！" + city.getCityCode());
                clientMessage.setMessage("更新城市状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/listCity")
    public String listCity(Model model, City city, Page page) throws BusinessException {
        page.setUrl("listCity");
        Map<String, Object> params = getSearchParams(page);

        if (city != null) {
            // 有条件查询
            params.put("cityCode", city.getCityCode());
            params.put("cityName", city.getCityName());
            params.put("enName", city.getEnName());
            params.put("status", city.getStatus());
            params.put("provinceCode", city.getProvinceCode());
            params.put("provinceName", city.getProvinceName());
        }

        List<City> cityList = cityService.findCitysByParams(params);
        int count = cityService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("cityList", cityList);
        model.addAttribute("page", page);

        return CITY_LIST_PAGE;
    }
}
