<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="jquery-ui/themes/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="jquery-ui/ui/jquery-ui.js"></script>
<script type="text/javascript" src="js/activelife-submit.js"></script>
<script type="text/javascript" src="js/activelife-dialog.js"></script>
<script type="text/javascript" src="js/activelife-callback.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("a.status").click(function() {
            var entry = $(this);
            var status = entry.attr("status");
            if (status == "Y") {
                status = "N";
            } else {
                status = "Y";
            }
            var cityCode = entry.attr("cityCode");
            var data = {
                "status" : status,
                "cityCode" : cityCode
            };

            var option = {
                content : "确认修改吗？",
                buttons : {
                    "确定" : function() {
                        activelife_submit.submit("editCityStatus.do", data, entry, activelife_callback.afterUpdateYNStatus);
                        $(this).dialog("close");
                    }
                }
            };
            activelife_dialog.showConfirmDialog(option);
        });
    });
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">地域管理&nbsp;&gt;&gt;&nbsp;城市信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listCity.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">城市编号：</td>
                        <td><input type="text" name="cityCode" class="generic_input" /></td>
                        <td class="field_name">城市名称：</td>
                        <td><input type="text" name="cityName" class="generic_input" /></td>
                        <td class="field_name">英文名称：</td>
                        <td><input type="text" name="enName" class="generic_input" /></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field_name">有效状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <option value="Y">有效</option>
                                <option value="N">无效</option>
                        </select></td>
                        <td class="field_name">省份编号：</td>
                        <td><input type="text" name="provinceCode" class="generic_input" /></td>
                        <td class="field_name">省份名称：</td>
                        <td><input type="text" name="provinceName" class="generic_input" /></td>
                        <td><input type="submit" value="查询" /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listCity.do" method="post">
                <table class="list_table" cellspacing="1" cellpadding="0" >
                    <thead>
                        <tr>
                            <th>城市编号</th>
                            <th>城市名称</th>
                            <th>英文名称</th>
                            <th>省份编号</th>
                            <th>省份名称</th>
                            <th>有效状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cityList}" var="city">
                            <tr>
                                <td class="align_left">${city.cityCode}</td>
                                <td class="align_left">${city.cityName}</td>
                                <td class="align_left">${city.enName}</td>
                                <td class="align_left">${city.provinceCode}</td>
                                <td class="align_left">${city.provinceName}</td>
                                <td class="align_center">
                                    <c:if test="${city.status == 'Y'}">
                                        <span class="status status_green">有效</span>
                                    </c:if>
                                    <c:if test="${city.status == 'N'}">
                                        <span class="status status_red">无效</span>
                                    </c:if>
                                </td>
                                <td class="align_center">
                                    <c:if test="${city.status == 'Y'}">
                                        <a href="javascript:void(0)" class="href status" status="${city.status}" cityCode="${city.cityCode}">设为无效</a>
                                    </c:if>
                                    <c:if test="${city.status == 'N'}">
                                        <a href="javascript:void(0)" class="href status" status="${city.status}" cityCode="${city.cityCode}">设为有效</a>
                                    </c:if>
                                    
                                    <a href="showCityEditor.do?cityCode=${city.cityCode}" class="href">编辑</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7" style="position: relative;">
                                <jsp:include page="../base/pagenation.jsp"></jsp:include>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</body>
</html>