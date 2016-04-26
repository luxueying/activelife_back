<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">

<script type="text/javascript">
/* function check_ag(){
    var password = $("#password").val();
    var agpassword = $("#agpassword").val();
    if(pass == qrpass){
        alert("SUCCESS");
    }else{
        alert("FAIL");
    }
} */
function pw() {
    var pw1 = document.getElementById("password").value;
    var pw2 = document.getElementById("agpassword").value;
    
    if(pw1 == pw2) {
        document.getElementById("tishi").innerHTML="<font color='green'>两次密码相同</font>";
        document.getElementById("submit").disabled = false;
    }
    else {
        document.getElementById("tishi").innerHTML="<font color='red'>两次密码不相同</font>";
      document.getElementById("submit").disabled = true;
    }
}
</script>


</head>
<body>
 <div class="header" style="left: 0;top: 0;width: 100%;">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">系统管理&nbsp;&gt;&gt;&nbsp;修改密码</span>
    </div>
 <form  action="modifyPass.do" method="post">
			<table style="padding-top: 40px;" align="center">
				<tr>
					<td>用户名：</td>
					<td><input type="text" name="userName" disabled="disabled" readonly="readonly" value="${sessionScope.systemUser.userName}">
					<input type="hidden" name="userId" class="generic_input"  value="${sessionScope.systemUser.userId}" /> </td>
				</tr>
				<tr><td>新密码</td>
					<td><input type="password" name="password" id="password"></td>
				</tr>
				<tr><td>确认密码</td>
					<td><input type="password" name="agpassword" id="agpassword" onkeyup="pw()">
						<span id="tishi"></span>
					</td>
				</tr>
				<tr>
				<td><input type="submit" id="submit" value="提交"/></td>
				<td><input type="reset" value="重置"/></td>
				</tr>
			</table>
		</form>
</body>
</html>