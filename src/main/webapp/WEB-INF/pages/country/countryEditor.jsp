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
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">地域管理&nbsp;&gt;&gt;&nbsp;国家信息维护</span>
    </div>
    <div class="body">
        <form action="editCountry.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">国家编号：</td>
                    <td>
                        <c:if test="${country != null && country.countryCode != null}">
                            <input type="text" class="generic_input" disabled="disabled" value="${country.countryCode}"/>
                            <input type="hidden" name="countryCode" value="${country.countryCode}" />
                        </c:if>
                        <c:if test="${country == null || country.countryCode == null}">
                            <input type="text" name="countryCode" class="generic_input" />
                        </c:if>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">国家名称：</td>
                    <td><input type="text" name="countryName" class="generic_input" value="${country.countryName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">英文名称：</td>
                    <td><input type="text" name="enName" class="generic_input" value="${country.enName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td>
                        <c:if test="${country.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if>
                        <c:if test="${country.status != 'Y'}">
                            <input type="radio" name="status" value="N" checked="checked" />无效
                            <input type="radio" name="status" value="Y" class="generic_radio" />有效
                        </c:if>
                     </td>
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