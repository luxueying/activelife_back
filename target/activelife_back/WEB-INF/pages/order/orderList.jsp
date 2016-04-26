<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="jquery-ui/themes/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="jquery-ui/ui/jquery-ui.js"></script>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<script type="text/javascript" src="js/activelife-submit.js"></script>
<script type="text/javascript" src="js/activelife-dialog.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#tabs").tabs();   
        
    });
    function listOrder(){ 
    	var urlStr = '${pageContext.request.contextPath }/listOrder.do';
    	$.ajax({
    			url: urlStr,
    			type: "POST",
    			data:{status:"SEND"},
    			dataType: "json",
    			success:function(date){
    				 /* data=JSON.parse(data); 
    				alert("!!!!!!!!!!!!!!!!!!!!");
    				alert(data); */
    				/*  alert("!!!!!!!!!!!!!!!!"); */
    				/* var orderList;//ajax 异步从后台取回的json [{id:1},{id:2}] */
    				alert("!!!!!!!!!!!!!!!!");
    				var orderList = eval("("+data+")");
    				alert("!!!!!!!!!!!!!!!!");
    				for(var i=0;i<orderList.length;i++){
    				   alert("!!!!!!!!!!!!!!!!");
    					alert(orderList[i].status);
    				}
    			},
    			error : function(XMLHttpRequest, textStatus, errorThrown) {
    				alert(XMLHttpRequest + "__" + textStatus + "__" + errorThrown);
    			}
    		});
        	
        	}
</script>

</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品维护</span>
    </div>
    <div class="body">
        <div id="tabs">
            <ul>
             	<li><a href="#tabs-1" onclick="listOrder('action1')">所有订单</a></li>
                <li><a href="#tabs-2" onclick="listOrder('action2')">等待买家付款</a></li>
                <li><a href="#tabs-2" onClick="listOrder('action3')">等待发货</a></li>
                <li><a href="#tabs-2" onClick="listOrder('action4')">已发货</a></li>
                <li><a href="#tabs-2" onClick="listOrder('action5')">退款中</a></li>
                <li><a href="#tabs-2" onClick="listOrder('action6')">成功的订单</a></li>
                <li><a href="#tabs-2" onClick="listOrder('action6')">关闭的订单</a></li>
            </ul>
            <div id="tabs-1">
             <div class="search_header">
            <form action="listOrder.do" method="get">
                <table align="left">
                    <tr>
                  		<td class="field_name">订单号：</td>
                        <td><input type="text" name="orderId" class="generic_input" /></td>
                        <td><input type="submit" value="查询" /></td>
                    </tr>
                </table>
            </form>
        </div>
        
                    <table class="list_table" cellspacing="1" cellpadding="0">
                    
                    
                    <thead>
                        <tr>
                            <th>订单编号</th>
                            <th>订单状态</th>
                            <th>支付状态</th>
                            <th>生成时间</th>
                            <th>创建人</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderList}" var="order">
                            <tr>
                                <td class="align_left">${order.orderCode}</td>
                                 <td class="align_center">
                                 <c:forEach items="${orderStatus}" var="status">
                                        <c:if test="${order.status == 'FINISH' && order.status == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'SEND_BACK' && order.status == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'CANCEL' && order.status == status.key}">
                                            <span class="status status_yellow">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'SEND' && order.status == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                 <td class="align_center">
                                 <c:forEach items="${paymentStatus}" var="status">
                                        <c:if test="${order.paymentStatus == 'PAIED' && order.paymentStatus == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.paymentStatus == 'UNPAIED' && order.paymentStatus == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.paymentStatus == 'CASH_ON_DELIVERY' && order.paymentStatus == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                      
                                    </c:forEach>
                                </td>
                                <td class="align_left">${order.createTime}</td>
                                <td class="align_left">${order.createBy}</td>
                              <td class="align_center"><a href="showOrderDetail.do?OrderId=${order.orderId}" class="href">查看</a> <a href="showOrderAudit.do?OrderId=${order.orderId}" class="href">审核</a> <a href="showOrderEditor.do?OrderId=${order.orderId}" class="href">编辑</a> <a href="javascript:void(0)" class="href" OrderId=${order.orderId}">删除</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="8" style="position: relative;"><jsp:include page="../base/pagenation.jsp"></jsp:include></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
           
            <div id="tabs-2">
                    <table class="list_table" cellspacing="1" cellpadding="0">          
                    <thead>
                        <tr>
                            <th>订单编号</th>
                            <th>订单状态</th>
                            <th>支付状态</th>
                            <th>生成时间</th>
                            <th>创建人</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderList}" var="order">
                            <tr>
                                <td class="align_left">${order.orderCode}</td>
                                 <td class="align_center">
                                 <c:forEach items="${orderStatus}" var="status">
                                        <c:if test="${order.status == 'FINISH' && order.status == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'SEND_BACK' && order.status == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'CANCEL' && order.status == status.key}">
                                            <span class="status status_yellow">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.status == 'SEND' && order.status == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                 <td class="align_center">
                                 <c:forEach items="${paymentStatus}" var="status">
                                        <c:if test="${order.paymentStatus == 'PAIED' && order.paymentStatus == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.paymentStatus == 'UNPAIED' && order.paymentStatus == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${order.paymentStatus == 'CASH_ON_DELIVERY' && order.paymentStatus == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                      
                                    </c:forEach>
                                </td>
                                <td class="align_left">${order.createTime}</td>
                                <td class="align_left">${order.createBy}</td>
                              <td class="align_center"><a href="showOrderDetail.do?OrderId=${order.orderId}" class="href">查看</a> <a href="showOrderAudit.do?OrderId=${order.orderId}" class="href">审核</a> <a href="showOrderEditor.do?OrderId=${order.orderId}" class="href">编辑</a> <a href="javascript:void(0)" class="href" OrderId=${order.orderId}">删除</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="8" style="position: relative;"><jsp:include page="../base/pagenation.jsp"></jsp:include></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            
        </div>
    </div>

</body>
</html>