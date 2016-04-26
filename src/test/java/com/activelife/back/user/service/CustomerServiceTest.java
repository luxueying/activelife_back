package com.activelife.back.user.service;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.activelife.common.user.po.Customer;

public class CustomerServiceTest {
    private CustomerService customerService;

    @Before
    public void before() {
        @SuppressWarnings("resource")
        ApplicationContext context = new ClassPathXmlApplicationContext(new String[] {
                "classpath:applicationContext.xml", "classpath:springmvc-servlet.xml" });
        customerService = (CustomerService) context.getBean("customerServiceImpl");
    }

    @Test
    public void testSaveCustomer() {
        Customer customer = new Customer();
//        customer.setCellphone("18321353610");
        customer.setPassword("18321353610");
        customerService.saveCustomer(customer);
    }
}
