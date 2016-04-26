<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="5;url=${clientMessage.href}">
<title>成功</title>
</head>
<body>
    <table align="center">
        <tr>
            <td align="center"><h1>${clientMessage.message}</h1></td>
        </tr>
        <tr>
            <td>页面5秒钟之后跳转到【${clientMessage.target}】，如果没有跳转，请点击此链接<a href="${clientMessage.href}">【${clientMessage.target}】</a></td>
        </tr>
    </table>
</body>
</html>