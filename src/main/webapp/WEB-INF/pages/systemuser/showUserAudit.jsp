<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
</head>
<body style="overflow: hidden;">
	 <div class="header" style="left: 0;top: 0;width: 100%;">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">系统管理&nbsp;&gt;&gt;&nbsp;个人信息</span>
    </div>
		<form  action="AuditUser.do" method="post">
			<table style="padding-top: 40px;" align="center">
				<tr>
					<td>用户名：*</td>
					<td><input disabled="disabled" type="text" value="${sessionScope.systemUser.userName}" name="userName"></td>
				</tr>
				<tr>
					<td>性别：*</td>
					<td><input type="text" disabled="disabled" value="${sessionScope.systemUser.gender}" name="gender"> </td>
				</tr>
				<tr><td>邮箱：</td>
					<td><input type="text"  name="email" value="${sessionScope.systemUser.email}"></td>
				</tr>
				<tr><td>手机：</td>
					<td><input type="text"  name="telephone" value="${sessionScope.systemUser.telephone}"></td>
				</tr>
				<tr><td>备用电话：</td>
					<td><input type="text"  name="cellphone" value="${sessionScope.systemUser.cellphone}"></td>
				</tr>
				<tr>
				<td><input type="submit" value="编辑"/></td>
				<td><input type="reset" value="重置"/></td>
				</tr>
			</table>
		</form>
		
		<!-- <iframe src="about:blank" frameborder="0" style="border: 0 none;position: fixed;left: 0;top: 0;width: 1253px;background: none repeat scroll 0 0 #F5F5F5;z-index: 998;height:60px"></iframe> -->
			
 
	
</body>
</html>