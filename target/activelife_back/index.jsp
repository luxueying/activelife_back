<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="js/jquery-1.8.3.js"></script>
<script>
$(document).ready(function(){
	
});

function changeValidateCode(){
	$("#validateCodeImg").attr("src","validateCode.do?_=" + (new Date).getTime());
	return ;
}
</script>
<body>
    <form action="goRegister.do" method="post">
        <input type="submit" value="注册">
    </form>

    <form action="login.do" method="post">
        <table>
            <tr>
                <td><label>用户名：</label></td>
                <td><input type="text" name="userName" /></td>
            </tr>
            <tr>
                <td><label>密码：</label></td>
                <td><input type="password" name="password" /></td>
            </tr>
            <tr>
            <td><label>验证码：</label></td>
            <td>
                <input type="text" id="validateCode" name="validateCode" tabIndex="3">
                <img src="validateCode.do" width="98" id="validateCodeImg" height="38" alt="验证码" onclick="changeValidateCode()" style="cursor: pointer;">
                <a href="javascript:changeValidateCode()" target="_self">换一个</a>
            </td>
            </tr>
            <tr>
                <td><input type="reset" value="重置" /></td>
                <td><input type="submit" name="登陆" /></td>
            </tr>
            <tr>
                <td>${clientMessage.message}</td>
            </tr>
        </table>
    </form>
</body>
</html>
