package com.activelife.back.user.service;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.activelife.common.user.po.SystemUser;

public class SystemUserServiceTest{
    private SystemUserService systemUserService;
    
    @Before
    public void before(){                                                                   
        @SuppressWarnings("resource")
        ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"classpath:applicationContext.xml"
                ,"classpath:springmvc-servlet.xml"});
        systemUserService = (SystemUserService) context.getBean("systemUserServiceImpl");
    }
    @Test
    public void testSaveSystemUser(){
        SystemUser systemUser = new SystemUser();
        systemUser.setUserName("admin");
        systemUser.setPassword("admin");
        systemUserService.saveSystemUser(systemUser);
    }
}
