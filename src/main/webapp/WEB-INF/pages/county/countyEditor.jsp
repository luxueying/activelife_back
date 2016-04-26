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
        $("#cityCode").change(function() {
            var name = $("#cityCode option:selected").text();
            $("#cityName").val(name);
        });

    });
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">地域管理&nbsp;&gt;&gt;&nbsp;县信息维护</span>
    </div>
    <div>
        <form action="editCounty.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">所属城市：</td>
                    <td><select name="cityCode" class="generic_select" id="cityCode">
                            <option>请选择</option>
                            <c:forEach items="${cityList}" var="city">
                                <c:if test="${county.cityCode == city.cityCode}">
                                    <option value="${city.cityCode}" selected="selected">${city.cityName}</option>
                                </c:if>
                                <c:if test="${county.cityCode != city.cityCode}">
                                    <option value="${city.cityCode}">${city.cityName}</option>
                                </c:if>
                            </c:forEach>
                    </select> <input type="hidden" name="cityName" value="${county.cityName}" id="cityName"></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">县编号：</td>
                    <td>
                        <c:if test="${county.countyCode != null}">
                            <input type="text" class="generic_input" disabled="disabled" value="${county.countyCode}" />
                            <input type="hidden" name="countyCode" value="${county.countyCode}" />
                        </c:if> 
                        <c:if test="${county.countyCode == null}">
                            <input type="text" name="countyCode" class="generic_input" />
                        </c:if>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">县名称：</td>
                    <td><input type="text" name="countyName" class="generic_input" value="${county.countyName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">英文名称：</td>
                    <td><input type="text" name="enName" class="generic_input" value="${county.enName}"/></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td>
                        <c:if test="${county.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if> 
                        <c:if test="${county.status != 'Y'}">
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