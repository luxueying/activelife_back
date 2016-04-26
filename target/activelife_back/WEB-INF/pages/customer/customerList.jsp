<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<script type="text/javascript" src="js/jquery.js"></script> 
 <script type="text/javascript" src="easyui/jquery.min.js"></script>
 <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
 <script type="text/javascript" src="js/date.js"></script>

<script type="text/javascript">
/* function serach() {
    var createTime=$('#createTimeId').datebox('getValue');  //注意.datebox('getValue')是EasyUI固定的写法。
    document.write(createTime);
} */
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listCustomer.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">用户编号：</td>
                        <td><input type="text" name="customerId" class="generic_input" /></td>
                        <td class="field_name">用户名称：</td>
                        <td><input type="text" name="customerName" class="generic_input" /></td>
                         <td class="field_name">添加时间：</td>
                        <td><input class="easyui-datebox" name="createTime" id="createTimeId" type="text"
data-options="formatter:myformatter,parser:myparser"></input></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field_name">用户地址：</td>
                        <td><input type="text" name="address" class="generic_input" /></td>
                        <td class="field_name">用户状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <c:forEach items="${customerStatus}" var="status">
                                    <option value="${status.key}">${status.value}</option>
                                </c:forEach>
                        </select></td>
                        <td><input type="submit" value="查询" iconCls="ext-icon-search"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listCustomer.do" method="post">
                <table class="list_table" cellspacing="1" cellpadding="0">
                    <thead>
                        <tr>
                            <th>用户ID</th>
                            <th>用户名</th>
                            <th>用户昵称</th>
                            <th>用户状态</th>
                            <th>手机</th>
                            <th>电子邮箱</th>
                            <th>创建时间</th>
                            <th></th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${customerList}" var="customer">
                            <tr>
                                <td class="align_left">${customer.customerId}</td>
                                <td class="align_left">${customer.realName}</td>
                                <td class="align_left">${customer.nickName}</td>
                                <td class="align_center">
                                    <c:forEach items="${customerStatus}" var="status">
                                        <c:if test="${customer.status == 'C' && customer.status == status.key}">
                                            <span class="status status_green">${status.value}</span>
                                        </c:if>
                                        <c:if test="${customer.status == 'D' && customer.status == status.key}">
                                            <span class="status status_red">${status.value}</span>
                                        </c:if>
                                        <c:if test="${customer.status == 'F' && customer.status == status.key}">
                                            <span class="status">${status.value}</span>
                                        </c:if>
                                    </c:forEach></td>
                                <td class="align_left">${customer.phoneNumber}</td>
                                <td class="align_left">${customer.email}</td>
                                <td class="align_left">${customer.createTime}</td>
                                <td class="align_left"></td>
                                <td class="align_center"><a href="showCustomerDetail.do?customerId=${customer.customerId}" class="href">查看</a> <a href="showCustomerAudit.do?customerId=${customer.customerId}" class="href">审核</a> <a href="showCustomerEditor.do?customerId=${customer.customerId}" class="href">编辑</a> <a href="deleteCustomer.do?customerId=${customer.customerId}" class="href">删除</a></td>
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