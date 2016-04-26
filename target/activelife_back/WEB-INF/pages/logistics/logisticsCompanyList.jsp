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
            var companyId = entry.attr("companyId");
            var data = {
                "status" : status,
                "companyId" : companyId
            };

            var option = {
                content : "确认修改吗？",
                buttons : {
                    "确定" : function() {
                        activelife_submit.submit("editLogisticsCompanyStatus.do", data, entry, activelife_callback.afterUpdateYNStatus);
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
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">物流管理&nbsp;&gt;&gt;&nbsp;物流公司信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listLogisticsCompany.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">公司名称：</td>
                        <td><input type="text" name="companyName" class="generic_input" /></td>
                        <td class="field_name">公司负责人：</td>
                        <td><input type="text" name="principal" class="generic_input" /></td>
                    </tr>
                    <tr>
                        <td class="field_name">有效状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <option value="Y">有效</option>
                                <option value="N">无效</option>
                        </select></td>
                        <td></td>
                        <td><input type="submit" value="查询" /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listLogisticsCompany.do" method="post">
                <table class="list_table" cellspacing="1" cellpadding="0">
                    <thead>
                        <tr>
                            <th>公司名称</th>
                            <th>公司电话</th>
                            <th>公司负责人</th>
                            <th>负责人电话</th>
                            <th>负责人手机</th>
                            <th>有效状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${logisticsCompanyList}" var="logisticsCompany">
                            <tr>
                                <td class="align_left">${logisticsCompany.companyName}</td>
                                <td class="align_left">${logisticsCompany.companyPhone}</td>
                                <td class="align_left">${logisticsCompany.principal}</td>
                                <td class="align_left">${logisticsCompany.telephone}</td>
                                <td class="align_left">${logisticsCompany.cellphone}</td>
                                <td class="align_center"><c:if test="${logisticsCompany.status == 'Y'}">
                                        <span class="status status_green">有效</span>
                                    </c:if> <c:if test="${logisticsCompany.status == 'N'}">
                                        <span class="status status_red">无效</span>
                                    </c:if></td>
                                <td class="align_center"><c:if test="${logisticsCompany.status == 'Y'}">
                                        <a href="javascript:void(0)" class="href status" status="${logisticsCompany.status}" companyId="${logisticsCompany.companyId}">设为无效</a>
                                    </c:if> <c:if test="${logisticsCompany.status == 'N'}">
                                        <a href="javascript:void(0)" class="href status" status="${logisticsCompany.status}" companyId="${logisticsCompany.companyId}">设为有效</a>
                                    </c:if> <a href="showLogisticsCompanyEditor.do?companyId=${logisticsCompany.companyId}" class="href">编辑</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7" style="position: relative;"><jsp:include page="../base/pagenation.jsp"></jsp:include></td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</body>
</html>