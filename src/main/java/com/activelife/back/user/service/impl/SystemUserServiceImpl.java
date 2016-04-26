package com.activelife.back.user.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.activelife.back.user.service.SystemUserService;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.user.po.SystemUser;
import com.activelife.common.utils.MD5;
import com.activelife.db.user.dao.SystemUserDao;

/**
 * 用户服务接口实现
 * 
 * @author zhangpanfeng
 * 
 */
@Service
public class SystemUserServiceImpl implements SystemUserService {
    private static final Log LOG = LogFactory.getLog(SystemUserServiceImpl.class);
    @Autowired
    private SystemUserDao systemUserDao;

    public String saveSystemUser(SystemUser systemUser) throws BusinessException {
        LOG.info("start method<saveSystemUser>" + systemUser);
        systemUser.setPassword(MD5.md5(systemUser.getPassword()));
        systemUser.setCreateTime(new Date());
        systemUserDao.saveSystemUser(systemUser);
        String result = systemUser.getUserId();

        return result;
    }

    public int updateSystemUser(SystemUser systemUser) throws BusinessException {
        LOG.info("start method<updateSystemUser>" + systemUser);
        int result = systemUserDao.updateSystemUser(systemUser);

        return result;
    }

    public SystemUser findSystemUserByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findSystemUserByParams>" + params);
        SystemUser systemUser = systemUserDao.findSystemUserByParams(params);

        return systemUser;
    }

    public SystemUser findSystemUserById(String userId) throws BusinessException {
        LOG.info("start method<findSystemUserById>" + userId);
        SystemUser systemUser = systemUserDao.findSystemUserById(userId);

        return systemUser;
    }

    public List<SystemUser> findSystemUsersByParams(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<findSystemUsersByParams>" + params);
        List<SystemUser> systemUserList = systemUserDao.findSystemUsersByParams(params);

        return systemUserList;
    }

    public int getTotalCount(Map<String, Object> params) throws BusinessException {
        LOG.info("start method<getTotalCount>" + params);
        int count = systemUserDao.getTotalCount(params);

        return count;
    }

}
