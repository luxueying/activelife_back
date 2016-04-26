<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	color: #333333;
}

.STYLE3 {
	font-size: 12px;
	color: #333333;
}

a {
	color: #333333;
	TEXT-DECORATION: none
}
-->
</style>
<style type="text/css">
.menu_title SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #333333;
	POSITION: relative;
	TOP: 2px
}

.menu_title2 SPAN {
	FONT-WEIGHT: bold;
	LEFT: 3px;
	COLOR: #333333;
	POSITION: relative;
	TOP: 2px
}

a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

a:active {
	text-decoration: none;
}
</style>
<script>
	var he = document.body.clientHeight - 105
	document.write("<div id=tt style=height:"+he+";overflow:hidden>")
</script>
<script>
	function showsubmenu(sid) {
		whichEl = eval("submenu" + sid);
		imgmenu = eval("imgmenu" + sid);
		if (whichEl.style.display == "none") {
			eval("submenu" + sid + ".style.display=\"\";");
			imgmenu.background = "images/main_47.gif";
		} else {
			eval("submenu" + sid + ".style.display=\"none\";");
			imgmenu.background = "images/main_48.gif";
		}
	}
</script>
</head>
<table width="165" height="100%" border="0" cellpadding="0" cellspacing="0">
   
 <tr>
        <td valign="top">

            <table width="151" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23" id="imgmenu1" class="menu_title" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(1)" onMouseOut="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">系统管理</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td id="submenu1" style="DISPLAY: none">
                                    <div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="16%" height="25"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td width="84%" height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="ShowmeAction.do" target="I2">个人信息</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="toModifyPass.do" target="I2">修改密码</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                       
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>

                                    </div>
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>

    <tr>
        <td valign="top">

            <table width="151" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23" id="imgmenu2" class="menu_title" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(2)" onMouseOut="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                             <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">用户中心</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td id="submenu2" style="DISPLAY: none">
                                    <div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="../customer/customerList2.jsp" target="I2">查看用户列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCustomerEditor.do" target="I2">添加新用户</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>

                                    </div>
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>


                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23"  id="imgmenu3" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(3)" onmouseout="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                              <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">产品管理</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td id="submenu3" style="DISPLAY: none"><div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="16%" height="25"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td width="84%" height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showProductList.do" target="I2">查询产品列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showProductEditor.do" target="I2">添加产品</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showProductImageList.do" target="I2">查询图片列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>


                                    </div></td>
                            </tr>
                        </table>

                    </td>
                </tr>


                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23"  id="imgmenu4" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(4)" onmouseout="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                             <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">地域管理</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td id="submenu4" style="DISPLAY: none"><div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="16%" height="25"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td width="84%" height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCountryList.do" target="I2">查询国家列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCountryEditor.do" target="I2">添加国家</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showProvinceList.do" target="I2">查询省份列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showProvinceEditor.do" target="I2">添加省份</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCityList.do" target="I2">查询城市列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCityEditor.do" target="I2">添加城市</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCountyList.do" target="I2">查询县列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showCountyEditor.do" target="I2">添加县</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>

                                    </div></td>
                            </tr>
                        </table>

                    </td>
                </tr>

                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23"  id="imgmenu5" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(5)" onmouseout="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                             <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">查询订单列表</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            
                            <tr>
                                <td id="submenu5" style="DISPLAY: none"><div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="16%" height="25"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td width="84%" height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showOrderList.do" target="I2">查询订单列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="ShowfileAction.do" target="I2">下载文件</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showLogisticsList.do" target="I2">查看订单的物流列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>

                                    </div></td>
                            </tr>
                        </table>

                    </td>
                </tr>
                <tr>
                    <td>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="23" id="imgmenu6" class="menu_title" onmouseover="this.className='menu_title2';" onclick="showsubmenu(6)" onmouseout="this.className='menu_title';" style="cursor: hand">

                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="18%"><img src="images/left.gif" width="10" height="10" /></td>
                                            <td width="82%" class="STYLE1">物流管理</td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td  id="submenu6" style="DISPLAY: none"><div class="sec_menu">

                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>

                                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="16%" height="25"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td width="84%" height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showLogisticsCompanyList.do" target="I2">查询物流公司列表</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td height="23"><div align="center">
                                                                    <img src="images/left.gif" width="10" height="10" />
                                                                </div></td>
                                                            <td height="23">

                                                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td height="20" style="cursor: hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; " onmouseout="this.style.borderStyle='none'"><span class="STYLE3"><a href="showLogisticsCompanyEditor.do" target="I2">添加物流公司</a></span></td>
                                                                    </tr>
                                                                </table>

                                                            </td>
                                                        </tr>
                                                        
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="5"><img src="images/main_52.gif" width="151" height="5" /></td>
                                            </tr>
                                        </table>

                                    </div></td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>

        </td>
    </tr>
  
</table>
</html>