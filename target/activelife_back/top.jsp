<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}
.STYLE1 {
    font-size: 12px;
    color: #FFFFFF;
}
.STYLE2 {font-size: 9px}
.STYLE3 {
    color: #033d61;
    font-size: 12px;
}
-->
</style></head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" bgcolor="#4a6785"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          <a class="text-logo navprepend" style="font-family: 黑体;"> 
			<img class="logo" src="/static/ui/image/logo.png">
			内部管理系统
		</a>
            <td width="700" height="24" bgcolor="#4a6785">&nbsp;</td>
            <td width="77%" height="25" valign="bottom">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                  <td width="50"><div align="center">${systemUser.userName}</div></td>
                    <td width="50" height="19"><div align="center"><img src="images/main_12.gif" width="49" height="19"></div></td>
                    <td width="50"><div align="center"><img src="images/main_14.gif" width="48" height="19"></div></td>
                    <td width="50"><div align="center"><img src="images/main_16.gif" width="48" height="19"></div></td>
                    <td width="50"><div align="center"><img src="images/main_18.gif" width="48" height="19"></div></td>
                    <td width="50"><div align="center"><img src="images/main_20.gif" width="48" height="19"></div></td>
                    <td width="26"><div align="center"><img src="images/main_21.gif" width="26" height="19"></div></td>
                    <td width="100"><div align="center"><img src="images/main_22.gif" width="98" height="19"></div></td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
             </td>
          </tr>
        </table></td>
      </tr>
      <tr>
      
      </tr>
     
    </table></td>
  </tr>
</table>
</body>
</html>

