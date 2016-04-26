<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>太生活后台管理_用户登录</title>
 <link rel="stylesheet" href="css/style.css">
<script src="js/jquery-1.8.3.js"></script>
<script src="js/vilidate.js"></script>
<script>
    $(document).ready(function() {
        $("#validateCodeImg").click(function() {
            $("#validateCodeImg").attr("src", "validateCode.do?_=" + (new Date).getTime());
            return;
        });
    });
   
    window.onload=function(){
    	var o=document.getElementById("userName");
    	o.setAttribute("valueCache",o.value);
    	o.onblur=function(){o.valueCache=o.value;o.value=o.tips}
    	o.onfocus=function(){o.value=o.valueCache;}
    	o.onblur();
    	}
    
</script>

</head>
<body>

  <section class="container">
    <div class="login">
      <h1>用户登录</h1>
      <form action="login.do" method="post" name="login">
        <p>用户名：<input type="text" name="userName" id="userName" value="" tips="请输入您的姓名"/></p>
        <p>密 &码：<input type="password" name="password" id="password"></p>
        <p>验证码：<input type="text" name="validateCode" id="validateCode" class="login_input"/><img src="validateCode.do" id="validateCodeImg" alt="验证码"></p>                                              
        <p class="remember_me">
          <label>
            <input type="checkbox" name="remember_me" id="remember_me">
            记住密码
          </label>
        </p>
        <p class="submit"><input type="submit" name="commit" value="登录" onclick="javascript:checkMe()"></p>
      </form>
    </div>

    <div class="login-help">
      <p>忘记密码? <a href="index.html">点击修改</a>.</p>
      ${clientMessage.message}
    </div>
  </section>

</body>
</html>
