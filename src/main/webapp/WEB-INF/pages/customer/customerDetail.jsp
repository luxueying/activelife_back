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
<link rel="stylesheet" type="text/css" href="css/back.css">
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span>
        <c:if test="${flag == 'DETAIL'}">
            <span class="crumb_right">用户管理&nbsp;&gt;&gt;&nbsp;用户详情</span>
        	<button style="right: 0;"><a href="showCustomerList.do">返回到用户列表</a></button>	
        </c:if>
        <c:if test="${flag == 'AUDIT'}">
            <span class="crumb_right">用户管理&nbsp;&gt;&gt;&nbsp;修改用户状态</span>
        	<button style="right: 0;"><a href="showCustomerList.do">返回到用户列表</a></button>
        </c:if>
        
    </div>
    <div class="body">
        <form action="auditCustomer.do" method="post">
            <table style="padding-top: 40px;" align="center">
                <tr>
                    <td class="field_name">用户ID：</td>
                   <td><input disabled="disabled" type="text" value="${customerVo.customerId}"/> </td>
                    <td class="field_name">用户姓名：</td>
                    <td><input disabled="disabled" type="text" value="${customerVo.realName}"/></td>
                </tr>
                <tr>
                    <td class="field_name">手机号：</td>
                    <td><input disabled="disabled" type="text" value="${customerVo.phoneNumber}"/></td>
                    <td class="field_name">邮箱：</td>
 					<td><input disabled="disabled" type="text" value="${customerVo.email}"/></td>
                </tr>
                <tr>
                    <td class="field_name">地址：</td>
                    <td><input disabled="disabled" type="text" value="${customerVo.address}"/></td>
                    <td class="field_name">产品审核状态：</td>
                    <td><c:forEach items="${customerStatus}" var="status">
                            <c:if test="${customerVo.status == status.key}"><input disabled="disabled" type="text" value="${status.value}"/></c:if>
                        </c:forEach></td>
                </tr> 
                <c:if test="${flag == 'AUDIT'}">
                    <tr>
                        <td class="field_name">审核状态：</td>
                        <td colspan="3"><select name="status" class="generic_select">
                                <option>请选择</option>
                                <c:forEach items="${customerStatus}" var="status">
                                  
                                        <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3"><input type="submit" value="保存" /></td>
                    </tr>
                </c:if>
            </table>
        </form>
    </div>
</body>
</html>