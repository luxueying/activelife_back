<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/activelife-submit-util.js"></script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">订单管理&nbsp;&gt;&gt;&nbsp;订单信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listOrder.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">订单编号：</td>
                        <td><input type="text" name="orderCode" class="generic_input" /></td>
                        <td class="field_name">创建时间：</td>
                        <td><input type="text" name="createTimeBegin" class="generic_input" />-<input type="text" name="createTimeEnd" class="generic_input" /></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field_name">订单状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <c:forEach items="${orderStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                        <td class="field_name">支付状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <c:forEach items="${paymentStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                        <td><input type="submit" value="查询" /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listOrder.do" method="post">
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
            </form>
        </div>
    </div>
</body>
</html>