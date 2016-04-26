package com.activelife.back.country.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.country.service.CountryService;
import com.activelife.common.base.po.Page;
import com.activelife.common.country.po.Country;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 国家控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class CountryAction extends BaseAction {
    private static final String URL_PREFIX = "/country";
    private static final String COUNTRY_EDIT_PAGE = URL_PREFIX + "/countryEditor";
    private static final String COUNTRY_LIST_PAGE = URL_PREFIX + "/countryList";
    /**
     * 注入国家服务
     */
    @Autowired
    private CountryService countryService;

    @RequestMapping(value = "/showCountryEditor")
    public String showCountryEditor(Model model, Country country) throws BusinessException {
        if (!StringUtil.isEmpty(country.getCountryCode())) {
            country = countryService.findCountryById(country.getCountryCode());
            model.addAttribute("country", country);
        }

        return COUNTRY_EDIT_PAGE;
    }

    @RequestMapping(value = "/showCountryList")
    public String showCountryList(Model model, Country country) throws BusinessException {

        return COUNTRY_LIST_PAGE;
    }

    @RequestMapping(value = "/editCountry")
    public String editCountry(Model model, Country country) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        Country dbCountry = countryService.findCountryById(country.getCountryCode());
        if (dbCountry == null) {
            // 新增
            String countryCode = countryService.saveCountry(country);
            if (StringUtil.isEmpty(countryCode)) {
                LOG.info("新增国家失败！");
                clientMessage.setMessage("新增国家失败！");
            } else {
                model.addAttribute("country", country);
            }
        } else {
            // 更新
            dbCountry.setCountryName(country.getCountryName());
            dbCountry.setEnName(country.getEnName());
            dbCountry.setStatus(country.getStatus());
            int num = countryService.updateCountry(dbCountry);
            if (num != 1) {
                LOG.info("更新国家失败！" + country.getCountryCode());
                clientMessage.setMessage("更新国家失败！");
            }
            model.addAttribute("country", dbCountry);
        }
        model.addAttribute("clientMessage", clientMessage);

        return COUNTRY_EDIT_PAGE;
    }

    @RequestMapping(value = "/editCountryStatus")
    @ResponseBody
    public Object editCountryStatus(Model model, Country country) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", country.getStatus());
        Country dbCountry = countryService.findCountryById(country.getCountryCode());
        if (dbCountry == null) {
            LOG.info("更新国家状态失败！" + country.getCountryCode());
            clientMessage.setMessage("更新国家状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbCountry.setStatus(country.getStatus());
            int num = countryService.updateCountry(dbCountry);
            if (num != 1) {
                LOG.info("更新国家状态失败！" + country.getCountryCode());
                clientMessage.setMessage("更新国家状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/listCountry")
    public String listCountry(Model model, Country country, Page page) throws BusinessException {
        page.setUrl("listCountry");
        Map<String, Object> params = getSearchParams(page);

        if (country != null) {
            // 有条件查询
            params.put("countryCode", country.getCountryCode());
            params.put("countryName", country.getCountryName());
            params.put("enName", country.getEnName());
            params.put("status", country.getStatus());
        }

        List<Country> countryList = countryService.findCountrysByParams(params);
        int count = countryService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("countryList", countryList);
        model.addAttribute("page", page);

        return COUNTRY_LIST_PAGE;
    }
}
