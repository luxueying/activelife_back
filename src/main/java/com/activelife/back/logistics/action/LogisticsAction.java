package com.activelife.back.logistics.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.activelife.back.base.action.BaseAction;
import com.activelife.back.httpClient.httpPost;
import com.activelife.back.logistics.service.LogisticsCompanyService;
import com.activelife.back.logistics.service.LogisticsService;
import com.activelife.common.base.po.Page;
import com.activelife.common.exception.BusinessException;
import com.activelife.common.exception.StatusCode;
import com.activelife.common.logistics.po.Logistics;
import com.activelife.common.logistics.po.LogisticsCompany;
import com.activelife.common.utils.StringUtil;
import com.activelife.common.vo.ClientMessage;

/**
 * 物流信息控制器
 * 
 * @author lxy
 * 
 */
@Controller
public class LogisticsAction extends BaseAction {
    private static final String URL_PREFIX = "/logistics";
    private static final String LOGISTICS_DETAIL_PAGE = URL_PREFIX + "/logisticsDetail";
    private static final String LOGISTICS_LIST_PAGE = URL_PREFIX + "/logisticsList";
    private String url="http://www.kuaidiapi.cn/rest";
    private ObjectMapper jsonMapper = new ObjectMapper();
    /**
     * 注入物流服务
     */
    @Autowired
    private LogisticsService logisticsService;
    

    
//跳转到物流信息列表的页面
    @RequestMapping(value = "/showLogisticsList")
    public String showLogisticsList(Model model, Logistics logistics) throws BusinessException {

        return LOGISTICS_LIST_PAGE;
    }
//    按条件查询
    @RequestMapping(value = "/listLogistics")
    public String listLogistics(Model model, Logistics logistics, Page page)
            throws BusinessException {
        page.setUrl("listLogisticsCompany");
        Map<String, Object> params = getSearchParams(page);

        if (logistics!= null) {
            // 有条件查询
            params.put("companyName", logistics.getCompanyName());
            params.put("logisticsCode", logistics.getLogisticsCode());
            params.put("orderId", logistics.getOrderId());
            params.put("status", logistics.getStatus());
        }

        List<Logistics> logisticsList = logisticsService.findLogisticssByParams(params);
        int count = logisticsService.getTotalCount(params);
        page.setTotalSize(count);
        model.addAttribute("logisticsList", logisticsList);
        model.addAttribute("page", page);

        return LOGISTICS_LIST_PAGE;
    }

    //    查看物流信息
    @RequestMapping(value = "/showLogistics")
    public String showLogistics(Model model, Logistics logistics, Page page)
            throws BusinessException {
        if (!StringUtil.isEmpty(logistics.getLogisticsId())) {
        	Logistics DbLogistics=new Logistics();
        	DbLogistics= logisticsService.findLogisticsById(logistics.getLogisticsId());
            model.addAttribute("logistics", DbLogistics);
        }

        return LOGISTICS_DETAIL_PAGE;
    }
    

    
//  查看物流详情
  @RequestMapping(value = "/showLogisticsDetail")
  public void showLogisticsDetail(Model model, Logistics logistics,ServletRequest request,ServletResponse response){
	  LOG.info("查看物流详情");
    	  String logisticsCode=request.getParameter("logisticsCode");
    	  String companyId=request.getParameter("companyId"); 
    	  System.out.println(logisticsCode+companyId);
    	  try {
    			httpPost httpPost=new httpPost();
//          	设置url的参数
    			List<NameValuePair> params = new ArrayList<NameValuePair>();
         	 	params.add(new BasicNameValuePair("uid","43150"));
         	 	params.add(new BasicNameValuePair("key","f0ca164631334002a4fb9f67511de2db"));
         	 	params.add(new BasicNameValuePair("order",logisticsCode));
         	 	params.add(new BasicNameValuePair("id",companyId));
              
                String json=(httpPost.post(url, params)); 
    		    String responseStr = jsonMapper.writeValueAsString(json);
  				System.out.println("返回信息：" + responseStr );
  			    response.getWriter().write(responseStr);
  		} catch (JsonGenerationException e) {
  			e.printStackTrace();
  		} catch (JsonMappingException e) {
  			e.printStackTrace();
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
         
      } 
  }
  

