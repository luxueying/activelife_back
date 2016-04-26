package com.activelife.back.logistics.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.logistics.service.LogisticsCompanyService;
import com.activelife.common.base.po.Page;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.logistics.po.LogisticsCompany;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 物流公司控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class LogisticsCompanyAction extends BaseAction {
    private static final String URL_PREFIX = "/logistics";
    private static final String LOGISTICS_COMPANY_EDIT_PAGE = URL_PREFIX + "/logisticsCompanyEditor";
    private static final String LOGISTICS_COMPANY_LIST_PAGE = URL_PREFIX + "/logisticsCompanyList";
    /**
     * 注入物流公司服务
     */
    @Autowired
    private LogisticsCompanyService logisticsCompanyService;

    @RequestMapping(value = "/showLogisticsCompanyEditor")
    public String showLogisticsCompanyEditor(Model model, LogisticsCompany logisticsCompany) throws BusinessException {
        if (!StringUtil.isEmpty(logisticsCompany.getCompanyId())) {
            logisticsCompany = logisticsCompanyService.findLogisticsCompanyById(logisticsCompany.getCompanyId());
            model.addAttribute("logisticsCompany", logisticsCompany);
        }

        return LOGISTICS_COMPANY_EDIT_PAGE;
    }

    @RequestMapping(value = "/showLogisticsCompanyList")
    public String showLogisticsCompanyList(Model model, LogisticsCompany logisticsCompany) throws BusinessException {

        return LOGISTICS_COMPANY_LIST_PAGE;
    }

    @RequestMapping(value = "/editLogisticsCompany")
    public String editLogisticsCompany(Model model, LogisticsCompany logisticsCompany) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        LogisticsCompany dbLogisticsCompany = logisticsCompanyService.findLogisticsCompanyById(logisticsCompany
                .getCompanyId());
        if (dbLogisticsCompany == null) {
            // 新增
            String companyId = logisticsCompanyService.saveLogisticsCompany(logisticsCompany);
            if (StringUtil.isEmpty(companyId)) {
                LOG.info("新增物流公司失败！");
                clientMessage.setMessage("新增物流公司失败！");
            } else {
                model.addAttribute("logisticsCompany", logisticsCompany);
            }
        } else {
            // 更新
            dbLogisticsCompany.setCompanyName(logisticsCompany.getCompanyName());
            dbLogisticsCompany.setStatus(logisticsCompany.getStatus());
            int num = logisticsCompanyService.updateLogisticsCompany(dbLogisticsCompany);
            if (num != 1) {
                LOG.info("更新物流公司失败！" + logisticsCompany.getCompanyId());
                clientMessage.setMessage("更新物流公司失败！");
            }
            model.addAttribute("logisticsCompany", dbLogisticsCompany);
        }
        model.addAttribute("clientMessage", clientMessage);

        return LOGISTICS_COMPANY_EDIT_PAGE;
    }

    @RequestMapping(value = "/editLogisticsCompanyStatus")
    @ResponseBody
    public Object editLogisticsCompanyStatus(Model model, LogisticsCompany logisticsCompany) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        clientMessage.addAttribute("status", logisticsCompany.getStatus());
        LogisticsCompany dbLogisticsCompany = logisticsCompanyService.findLogisticsCompanyById(logisticsCompany
                .getCompanyId());
        if (dbLogisticsCompany == null) {
            LOG.info("更新物流公司状态失败！" + logisticsCompany.getCompanyId());
            clientMessage.setMessage("更新物流公司状态失败！");
            clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
        } else {
            // 更新
            dbLogisticsCompany.setStatus(logisticsCompany.getStatus());
            int num = logisticsCompanyService.updateLogisticsCompany(dbLogisticsCompany);
            if (num != 1) {
                LOG.info("更新物流公司状态失败！" + logisticsCompany.getCompanyId());
                clientMessage.setMessage("更新物流公司状态失败！");
                clientMessage.setStatusCode(StatusCode.UPDATE_ERROR);
            }
        }

        return clientMessage;
    }

    @RequestMapping(value = "/listLogisticsCompany")
    public String listLogisticsCompany(Model model, LogisticsCompany logisticsCompany, Page page)
            throws BusinessException {
        page.setUrl("listLogisticsCompany");
        Map<String, Object> params = getSearchParams(page);

        if (logisticsCompany != null) {
            // 有条件查询
            params.put("companyName", logisticsCompany.getCompanyName());
            params.put("principal", logisticsCompany.getPrincipal());
            params.put("status", logisticsCompany.getStatus());
        }

        List<LogisticsCompany> logisticsCompanyList = logisticsCompanyService.findLogisticsCompanysByParams(params);
        int count = logisticsCompanyService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("logisticsCompanyList", logisticsCompanyList);
        model.addAttribute("page", page);

        return LOGISTICS_COMPANY_LIST_PAGE;
    }
}
