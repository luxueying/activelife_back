package com.activelife.back.base.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.activelife.common.base.po.Page;
import com.activelife.common.constant.Constant;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.ErrorMessage;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.user.po.SystemUser;
/**
 * 基类
 * 
 * @author lxy
 * 
 */
public class BaseAction {
    protected static final Log LOG = LogFactory.getLog(BaseAction.class);

    /**
     * 准备查询参数
     * 
     * @param page
     * @return
     */
    protected Map<String, Object> getSearchParams(Page page) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(Constant.ORDER_BY, page.getPageOrderBy());
        params.put(Constant.ORDER, page.getPageOrder());
        params.put(Constant.PAGE_START, page.getPageStart());
        params.put(Constant.PAGE_END, page.getPageSize());

        return params;
    }

    /**
     * 获取session用户
     * 
     * @param request
     * @return
     */
    protected SystemUser getSystemUser(HttpServletRequest request) throws BusinessException {
        SystemUser systemUser = (SystemUser) request.getSession().getAttribute("systemUser");
        if (systemUser == null) {
            throw new BusinessException(StatusCode.SESSION_TIME_OUT, ErrorMessage.SESSION_TIME_OUT);
        }

        return systemUser;
    }
}
