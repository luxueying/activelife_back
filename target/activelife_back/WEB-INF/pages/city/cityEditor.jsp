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
        $("#provinceCode").change(function() {
            var name = $("#provinceCode option:selected").text();
            $("#provinceName").val(name);
        });

    });
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">地域管理&nbsp;&gt;&gt;&nbsp;城市信息维护</span>
    </div>
    <div>
        <form action="editCity.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">所属省份：</td>
                    <td><select name="provinceCode" class="generic_select" id="provinceCode">
                            <option>请选择</option>
                            <c:forEach items="${provinceList}" var="province">
                                <c:if test="${city.provinceCode == province.provinceCode}">
                                    <option value="${province.provinceCode}" selected="selected">${province.provinceName}</option>
                                </c:if>
                                <c:if test="${city.provinceCode != province.provinceCode}">
                                    <option value="${province.provinceCode}">${province.provinceName}</option>
                                </c:if>
                            </c:forEach>
                    </select> <input type="hidden" name="provinceName" value="${city.provinceName}" id="provinceName"></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">城市编号：</td>
                    <td>
                        <c:if test="${city.cityCode != null}">
                            <input type="text" class="generic_input" disabled="disabled" value="${city.cityCode}" />
                            <input type="hidden" name="cityCode" value="${city.cityCode}" />
                        </c:if> 
                        <c:if test="${city.cityCode == null}">
                            <input type="text" name="cityCode" class="generic_input" />
                        </c:if>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">城市名称：</td>
                    <td><input type="text" name="cityName" class="generic_input" value="${city.cityName}"/></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">英文名称：</td>
                    <td><input type="text" name="enName" class="generic_input" value="${city.enName}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td>
                        <c:if test="${city.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if> 
                        <c:if test="${city.status != 'Y'}">
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