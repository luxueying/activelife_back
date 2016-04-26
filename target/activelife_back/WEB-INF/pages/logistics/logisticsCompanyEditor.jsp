<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">物流管理&nbsp;&gt;&gt;&nbsp;物流公司信息维护</span>
    </div>
    <div class="body">
        <form action="editLogisticsCompany.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">公司名称：</td>
                    <td><input type="text" name="companyName" class="generic_input" value="${logisticsCompany.companyName}" /> <input type="hidden" name="companyId" value="${logisticsCompany.companyId}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">公司电话：</td>
                    <td><input type="text" name="companyPhone" class="generic_input" value="${logisticsCompany.companyPhone}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">公司负责人：</td>
                    <td><input type="text" name="principal" class="generic_input" value="${logisticsCompany.principal}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">负责人电话：</td>
                    <td><input type="text" name="telephone" class="generic_input" value="${logisticsCompany.telephone}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">负责人手机：</td>
                    <td><input type="text" name="cellphone" class="generic_input" value="${logisticsCompany.cellphone}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td><c:if test="${logisticsCompany.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if> <c:if test="${logisticsCompany.status != 'Y'}">
                            <input type="radio" name="status" value="N" checked="checked" />无效
                            <input type="radio" name="status" value="Y" class="generic_radio" />有效
                        </c:if></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="保存" /></td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>