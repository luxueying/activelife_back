package com.activelife.back.order.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.order.service.OrderService;
import com.activelife.back.user.service.SystemUserService;
import com.activelife.common.base.po.Page;
import com.activelife.common.constant.CommonEnum;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.order.po.Order;
import com.activelife.common.order.vo.OrderVo;
import com.activelife.common.product.po.Product;
import com.activelife.common.product.vo.ProductVo;
import com.activelife.common.user.po.Customer;
import com.activelife.common.user.po.SystemUser;
import com.activelife.common.user.vo.CustomerVo;
import com.activelife.common.utils.DateUtil;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 订单控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class OrderAction extends BaseAction {
    private static final String URL_PREFIX = "/order";
    private static final String ORDER_EDIT_PAGE = URL_PREFIX + "/orderEditor";
    private static final String ORDER_DETAIL_PAGE = URL_PREFIX + "/orderDetail";
    private static final String ORDER_LIST_PAGE = URL_PREFIX + "/orderList";
    private ObjectMapper jsonMapper = new ObjectMapper();
    /**
     * 注入订单服务
     */
    @Autowired
    private OrderService orderService;
    /**
     * 注入用户服务
     */
    @Autowired
    private SystemUserService systemUserService;

//订单列表
    @RequestMapping(value = "/showOrderList")
    public String showOrderList(Model model, Order order,Page page) throws BusinessException {
        
        return ORDER_LIST_PAGE;
    }
    /**
     * 根据条件查询
     */   
    @RequestMapping(value = "/listOrder")
    @ResponseBody
    public Object listOrder(String status,HttpServletResponse response,Model model, Order order, Page page) throws BusinessException {
        
    	page.setUrl("listOrder");
        Map<String, Object> params = getSearchParams(page);
//        String status = request.getParameter("status");
        params.put("orderCode", order.getOrderCode());
        params.put("status", status);
        params.put("paymentStatus", order.getPaymentStatus());
        params.put("createTime", order.getCreateTime());
        List<Order> orderList = orderService.findOrdersByParams(params);
        System.out.println(status+"!!!!!!!!!!!!!");
        int count = orderService.getTotalCount(params);
        page.setTotalSize(count);
//        List<OrderVo> orderVoList = new ArrayList<OrderVo>();
//        if (orderList != null) {
//            for (Order o : orderList) {
//            	orderVoList.add(this.changePoToVo(o));
//            }
//        }
//		System.out.println("返回信息："  );
//     
//        try {
//			String responseStr = jsonMapper.writeValueAsString(orderList);
//			System.out.println("返回信息：" + responseStr );
//			response.getWriter().write(responseStr);
//		} catch (JsonGenerationException e) {
//			e.printStackTrace();
//		} catch (JsonMappingException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	
	
//        model.addAttribute("orderList", orderList);
        model.addAttribute("page", page);

        // 准备订单状态信息
        this.prapareOrderStatus(model);
        System.out.println(orderList);
        return orderList;
    }
//查看订单详情
    @RequestMapping(value = "/showOrderDetail")
    public String showOrderDetail(Model model, Order order) throws BusinessException {
        ClientMessage clientMessage = new ClientMessage();
        String orderId = order.getOrderId();
        order = orderService.findOrderById(orderId);
        if (order != null) {
            OrderVo orderVo = this.changePoToVo(order);
            model.addAttribute("orderVo", orderVo);
        } else {
            LOG.info("查询订单失败！" + orderId);
            clientMessage.setMessage("查询订单失败！");
            clientMessage.setStatusCode(StatusCode.READ_ERROR);
        }
        model.addAttribute("clientMessage", clientMessage);
        model.addAttribute("flag", "DETAIL");
        return ORDER_DETAIL_PAGE;
    }
//  跳转到修改状态页面 
   @RequestMapping(value = "/showOrderAudit")
   public String showOrderAudit(Model model, HttpServletRequest req, Order order) {
       order = orderService.findOrderById(order.getOrderId());
       System.out.println(order.getOrderId()+order.getPaymentStatus());
       OrderVo orderVo = this.changePoToVo(order);
       model.addAttribute("orderVo", orderVo);
       // 设置页面标示
       model.addAttribute("flag", "AUDIT");
       this.prapareOrderStatus(model);

       return ORDER_DETAIL_PAGE;
   }
//   修改订单状态
   @RequestMapping(value = "/manageOrder")
   public String manageOrder(Model model, HttpServletRequest req, Order order) throws BusinessException {
       ClientMessage clientMessage = new ClientMessage();
       SystemUser systemUser = getSystemUser(req);
       Order dbOrder =orderService.findOrderById(order.getOrderId());
       if (dbOrder == null) {
           LOG.info("查询订单失败！");
           clientMessage.setMessage("审核失败！");
       } else {
    	   dbOrder.setUpdateBy(systemUser.getUserName());
    	   dbOrder.setStatus(order.getStatus());
    	   dbOrder.setPaymentStatus(order.getPaymentStatus());
    	   System.out.println(order.getStatus()+order.getPaymentStatus());
           int num = orderService.updateOrder(dbOrder);
           if (num != 1) {
               LOG.info("审核失败！");
               clientMessage.setMessage("审核失败！");
           } else {
              OrderVo orderVo = this.changePoToVo(dbOrder);
               model.addAttribute("orderVo", orderVo);
               // 设置页面标示
               model.addAttribute("flag", "DETAIL");
               this.prapareOrderStatus(model);
           }
       }

       model.addAttribute("clientMessage", clientMessage);

       return ORDER_DETAIL_PAGE;
   }
    /**
     * 给页面准备订单的状态信息
     * 
     * @param model
     */
    private void prapareOrderStatus(Model model) {
        // 准备订单状态信息
        Map<String, String> orderStatus = new HashMap<String, String>();
        CommonEnum.ORDER_STATUS[] statusArray = CommonEnum.ORDER_STATUS.values();
        for (CommonEnum.ORDER_STATUS status : statusArray) {
            orderStatus.put(status.getCode(), status.getCnName());
        }
        model.addAttribute("orderStatus", orderStatus);
        System.out.println(orderStatus);
        // 准备订单支付状态信息
        Map<String, String> paymentStatus = new HashMap<String, String>();
        CommonEnum.PAYMENT_STATUS[] paymentStatusArray = CommonEnum.PAYMENT_STATUS.values();
        for (CommonEnum.PAYMENT_STATUS status : paymentStatusArray) {
            paymentStatus.put(status.getCode(), status.getCnName());
        }
        model.addAttribute("paymentStatus", paymentStatus);
        System.out.println(paymentStatus);
    }

    /**
     * 为详情页准备数据
     * 
     * @param order
     * @return
     */
    private OrderVo changePoToVo(Order order) {
        OrderVo orderVo = new OrderVo();
        orderVo.setOrderId(order.getOrderId());
        orderVo.setOrderCode(order.getOrderCode());
        orderVo.setPrice(StringUtil.getValue(order.getPrice()));
        orderVo.setPaymentStatus(order.getPaymentStatus());
        orderVo.setStatus(order.getStatus());
        orderVo.setCreateTime(DateUtil.formatDate(order.getCreateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        orderVo.setUpdateTime(DateUtil.formatDate(order.getUpdateTime(), DateUtil.HHMMSS_DATE_FORMAT));
        orderVo.setDeleteTime(DateUtil.formatDate(order.getDeleteTime(), DateUtil.HHMMSS_DATE_FORMAT));

        return orderVo;
    }
}
