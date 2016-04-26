<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误</title>
</head>
<body>
    <table align="center">
        <tr>
            <td align="right"><h2>异常代码：</h2></td>
            <td align="left"><h2>${clientMessage.statusCode}</h2></td>
        </tr>
        <tr>
            <td align="right"><h2>异常消息：</h2></td>
            <td align="left"><h2>${clientMessage.message}</h2></td>
        </tr>
    </table>
</body>
</html>