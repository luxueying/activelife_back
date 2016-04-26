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

<title>企业信息管理系统_用户登录</title>
<style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background-color: #016aa9;
    overflow: hidden;
}

.STYLE1 {
    color: #000000;
    font-size: 12px;
}

.login_input {
    width: 120px;
    height: 22px;
    background-color: #292929;
    border: solid 1px #7dbad7;
    font-size: 12px;
    color: #6cd0ff;
}

.login_button {
    width: 50px;
    height: 20px;
    cursor: pointer;
}

#validateCodeImg {
    width: 50px;
    height: 22px;
    cursor: pointer;
}
-->
</style>
</head>
<script src="js/jquery-1.8.3.js"></script>
<script>
    $(document).ready(function() {
        $("#validateCodeImg").click(function() {
            $("#validateCodeImg").attr("src", "validateCode.do?_=" + (new Date).getTime());
            return;
        });
    });
</script>

<body>
    <form action="login.do" method="post">
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table width="962" border="0" align="center" cellpadding="0" cellspacing="0"
                        style="position: relative">
                        <tr>
                            <td height="235" background="images/login_03.gif">&nbsp;</td>
                        </tr>
                        <tr>
                            <td height="53">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="394" height="53" background="images/login_05.gif">&nbsp;</td>
                                        <td width="206" background="images/login_06.gif">
                                            <table border="0" cellspacing="0" cellpadding="0"
                                                style="position: absolute; top: 44%; left: 38%;">
                                                <tr>
                                                    <td width="16%" height="25">
                                                        <div align="right">
                                                            <span class="STYLE1">用户名：</span>
                                                        </div>
                                                    </td>
                                                    <td width="57%" height="25">
                                                        <div align="center">
                                                            <input type="text" name="userName" class="login_input">
                                                        </div>
                                                    </td>
                                                    <td width="27%" height="25">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td height="25">
                                                        <div align="right">
                                                            <span class="STYLE1">密码：</span>
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="center">
                                                            <input type="password" name="password" class="login_input">
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="left"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="25">
                                                        <div align="right">
                                                            <span class="STYLE1">验证码：</span>
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="center">
                                                            <input type="text" name="validateCode" class="login_input">
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="left">
                                                            <img src="validateCode.do" id="validateCodeImg" alt="验证码">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="25">
                                                        <div align="right"></div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="center">
                                                             <input class="login_button" type="image" src="images/dl.gif">
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="left"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="25">
                                                        <div align="right"></div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="center" class="STYLE1" style="color: #FF0000;">
                                                             ${clientMessage.message}
                                                        </div>
                                                    </td>
                                                    <td height="25">
                                                        <div align="left"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="362" background="images/login_07.gif">&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="213" background="images/login_08.gif">&nbsp;</td>
                        </tr>
                    </table>


                </td>
            </tr>
        </table>
    </form>
</body>
</html>