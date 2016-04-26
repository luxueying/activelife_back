<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript"
	src="<c:url value="/easyui/jquery.jdirk.js"/>"></script>
<link
	href="<c:url value="/easyui/jeasyui-extensions/jeasyui.extensions.css"/>"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/easyui/jeasyui-extensions/jeasyui.extensions.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/easyui/jeasyui-extensions/jeasyui.extensions.menu.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/easyui/datagrid-detailview.js"/>"></script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listProduct.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">产品编号：</td>
                        <td><input type="text" name="productCode" class="generic_input" /></td>
                        <td class="field_name">产品名称：</td>
                        <td><input type="text" name="productName" class="generic_input" /></td>
                        <td class="field_name">添加时间：</td>
                        <td><input id="createtimeid" name="createtime"
							class="easyui-datebox" type="text"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field_name">产品地址：</td>
                        <td><input type="text" name="address" class="generic_input" /></td>
                        <td class="field_name">审核状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <c:forEach items="${productStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                        <td><input type="submit" value="查询" /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listProduct.do" method="post">
                <table class="list_table" cellspacing="1" cellpadding="0">
                    <thead>
                        <tr>
                            <th>产品编号</th>
                            <th>产品名称</th>
                            <th>审核状态</th>
                            <th>添加时间</th>
                            <th>删除时间</th>
                            <th>产品地址</th>
                            <th>创建人</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="product">
                            <tr>
                                <td class="align_left">${product.productCode}</td>
                                <td class="align_left">${product.productName}</td>
                                <td class="align_center">
                                    <c:forEach items="${productStatus}" var="status">
                                        <c:if test="${product.status == 'AUDITED_APPROVED' && product.status == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${product.status == 'AUDITED_REJECTED' && product.status == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${product.status == 'UNAUDITED' && product.status == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                    </c:forEach></td>
                                <td class="align_left">${product.createTime}</td>
                                <td class="align_left">${product.deleteTime}</td>
                                <td class="align_left">${product.address}</td>
                                <td class="align_left">${product.createBy}</td>
                                <td class="align_center"><a href="showProductDetail.do?productId=${product.productId}" class="href">查看</a> <a href="showProductAudit.do?productId=${product.productId}" class="href">审核</a> <a href="showProductEditor.do?productId=${product.productId}" class="href">编辑</a> <a href="javascript:void(0)" class="href" productId="${product.productId}">删除</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="8" style="position: relative;"><jsp:include page="../base/pagenation.jsp"></jsp:include></td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</body>
</html>