<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#countryCode").change(function() {
            var name = $("#countryCode option:selected").text();
            $("#countryName").val(name);
        });

    });
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">地域管理&nbsp;&gt;&gt;&nbsp;省份信息维护</span>
    </div>
    <div>
        <form action="editProvince.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">所属国家：</td>
                    <td><select name="countryCode" class="generic_select" id="countryCode">
                            <option>请选择</option>
                            <c:forEach items="${countryList}" var="country">
                                <c:if test="${province.countryCode == country.countryCode}">
                                    <option value="${country.countryCode}" selected="selected">${country.countryName}</option>
                                </c:if>
                                <c:if test="${province.countryCode != country.countryCode}">
                                    <option value="${country.countryCode}">${country.countryName}</option>
                                </c:if>
                            </c:forEach>
                    </select> <input type="hidden" name="countryName" value="${province.countryName}" id="countryName"></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">省份编号：</td>
                    <td><c:if test="${province.provinceCode != null}">
                            <input type="text" class="generic_input" disabled="disabled"
                                value="${province.provinceCode}" />
                            <input type="hidden" name="provinceCode" value="${province.provinceCode}" />
                        </c:if> <c:if test="${province.provinceCode == null}">
                            <input type="text" name="provinceCode" class="generic_input" />
                        </c:if></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">省份名称：</td>
                    <td><input type="text" name="provinceName" class="generic_input"
                        value="${province.provinceName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">英文名称：</td>
                    <td><input type="text" name="enName" class="generic_input" value="${province.enName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td>
                        <c:if test="${province.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if> 
                        <c:if test="${province.status != 'Y'}">
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