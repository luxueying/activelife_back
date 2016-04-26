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
            <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品详细信息</span>
        <button style="right: 0;"><a href="showProductList.do">返回到产品列表</a></button>	
        </c:if>
        <c:if test="${flag == 'AUDIT'}">
            <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品审核</span>
            <button style="right: 0;"><a href="showProductList.do">返回到产品列表</a></button>	
        </c:if>
    </div>
    <div class="body">
        <form action="auditProduct.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">产品编号：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.productCode}"/><input type="hidden" name="productId" value="${product.productId}" /></td>
                    <td class="field_name">产品名称：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.productName}"/></td>
                </tr>
                <tr>
                    <td class="field_name">原始价格：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.oldPrice}"/></td>
                    <td class="field_name">产品价格：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.price}"/></td>
                </tr>
                <tr>
                    <td class="field_name">产品库存：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.stock}"/></td>
                    <td class="field_name">产品审核状态：</td>
                    <td><c:forEach items="${productStatus}" var="status">
                            <c:if test="${productVo.status == status.key}"><input disabled="disabled" value="${status.value}"/></c:if>
                        </c:forEach></td>
                </tr>
                <tr>
                    <td class="field_name">所属国家：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.countryName}"/></td>
                    <td class="field_name">所属省份：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.provinceName}"/></td>
                </tr>
                <tr>
                    <td class="field_name">所属城市：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.cityName}"/></td>
                    <td class="field_name">所属县：</td>
                    <td><input disabled="disabled" type="text" value="${productVo.countyName}"/></td>
                </tr>
                <tr>
                    <td class="field_name">详细地址：</td>
                    <td colspan="3"><input disabled="disabled" type="text" value="${productVo.address}"/></td>
                </tr>
                <c:if test="${flag == 'AUDIT'}">
                    <tr>
                        <td class="field_name">审核状态：</td>
                        <td colspan="3"><select name="status" class="generic_select">
                                <option>请选择</option>
                                <c:forEach items="${productStatus}" var="status">
                                    <c:if test="${status.key != 'UNAUDITED'}">
                                        <option value="${status.key}">${status.value}</option>
                                    </c:if>
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