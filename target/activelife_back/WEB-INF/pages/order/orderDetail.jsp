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
<link rel="stylesheet" type="text/css" href="jquery-ui/themes/jquery.ui.all.css">
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span>
        <c:if test="${flag == 'DETAIL'}">
            <span class="crumb_right">订单管理&nbsp;&gt;&gt;&nbsp;订单详细信息</span>
        </c:if>
        <c:if test="${flag == 'AUDIT'}">
            <span class="crumb_right">订单管理&nbsp;&gt;&gt;&nbsp;订单处理</span>
        </c:if>
    </div>
    <div class="body">
        <form action="manageOrder.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">订单编号：</td>
                    <td>${orderVo.orderCode}<input type="hidden" name="orderId" value="${order.orderId}" /></td>
                </tr>
                <tr>
                    <td class="field_name">订单价格：</td>
                    <td>${orderVo.price}</td>
                </tr>
                <tr>
                    <td class="field_name">订单审核状态：</td>
                    <td>${orderVo.status}</td>
                </tr>
                <tr>
                    <td class="field_name">订单支付状态：</td>
                    <td>${orderVo.paymentStatus}</td>
                </tr>
               
                <c:if test="${flag == 'AUDIT'}">
                    <tr>
                        <td class="field_name">审核状态：</td>
                        <td colspan="3"><select name="status" class="generic_select">
                                <option>请选择</option>
                                <c:forEach items="${orderStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                    </tr>              
                    <tr>
                        <td class="field_name">支付状态：</td>
                        <td colspan="3"><select name="paymentStatus" class="generic_select">
                                <option>请选择</option>
                                <c:forEach items="${paymentStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td><input type="submit" value="保存" /></td>
                    </tr>
                </c:if>
                
                
            </table>
        </form>
    </div>

</body>
</html>