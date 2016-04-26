<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/images/favicon.ico"/>" rel="SHORTCUT ICON" />

<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>
<%String version = "20131115";%>

<%
Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
Cookie[] cookies = request.getCookies();
if (null != cookies) {
	for (Cookie cookie : cookies) {
		cookieMap.put(cookie.getName(), cookie);
	}
}
String easyuiTheme = "bootstrap";//指定如果用户未选择样式，那么初始化一个默认样式
if (cookieMap.containsKey("easyuiTheme")) {
	Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
	easyuiTheme = cookie.getValue();
}
%>

<style type="text/css">
	body{
        FONT: 9pt 微软雅黑;
    }
    TD {
		FONT: 12px 微软雅黑
	}
</style>

<script type="text/javascript">
var sy = sy || {};
sy.contextPath = '<%=contextPath%>';
sy.basePath = '<%=basePath%>';
sy.version = '<%=version%>';
sy.pixel_0 = '<%=contextPath%>/style/images/pixel_0.gif';//0像素的背景，一般用于占位
</script>

<%-- 引入my97日期时间控件 --%>
<script type="text/javascript" src="<%=contextPath%>/jslib/My97DatePicker4.8Beta3/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<%-- 引入jQuery --%>
<%
String User_Agent = request.getHeader("User-Agent");
if (StringUtils.indexOfIgnoreCase(User_Agent, "MSIE") > -1 && (StringUtils.indexOfIgnoreCase(User_Agent, "MSIE 6") > -1 || StringUtils.indexOfIgnoreCase(User_Agent, "MSIE 7") > -1 || StringUtils.indexOfIgnoreCase(User_Agent, "MSIE 8") > -1)) {
	out.println("<script src='" + contextPath + "/jslib/jquery-1.9.1.js' type='text/javascript' charset='utf-8'></script>");
} else {
	out.println("<script src='" + contextPath + "/jslib/jquery-2.0.3.js' type='text/javascript' charset='utf-8'></script>");
}
%>
<%-- 引入jquery扩展 --%>
<script src="<%=contextPath%>/jslib/syExtJquery.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<%-- 引入Highcharts --%>
<script src="<%=contextPath%>/jslib/Highcharts-3.0.6/js/highcharts.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=contextPath%>/jslib/Highcharts-3.0.6/js/modules/exporting.js" type="text/javascript" charset="utf-8"></script>
<%-- 引入Highcharts扩展 --%>
<script src="<%=contextPath%>/jslib/syExtHighcharts.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<%-- 引入ajaxfileupload --%>
<script type="text/javascript" src="<%=contextPath%>/jslib/ajaxfileupload.js" charset="utf-8"></script>

<%-- 引入EasyUI --%>
<link id="easyuiTheme" rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.3.4/themes/<%=easyuiTheme%>/easyui.css" type="text/css">
<!-- <link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-1.3.4/themes/icon.css" type="text/css"> -->
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-1.3.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<%-- 引入EasyUI Portal插件 --%>
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-easyui-portal/portal.css" type="text/css">
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-easyui-portal/jquery.portal.js" charset="utf-8"></script>
<%-- 引入easyui扩展 --%>
<script src="<%=contextPath%>/jslib/syExtEasyUI.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<%-- 引入扩展图标 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/syExtIcon.css?version=<%=version%>" type="text/css">

<%-- 引入自定义样式 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/syExtCss.css?version=<%=version%>" type="text/css">

<%-- 引入javascript扩展 --%>
<script src="<%=contextPath%>/jslib/syExtJavascript.js?version=<%=version%>" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
function selectMonth() {  
    WdatePicker({ dateFmt: 'yyyyMM', isShowToday: false, isShowClear: false });  
}

function getCurrentMonth(){
	var date = new Date();
	var m = date.getMonth()+1;
    return date.getFullYear() +""+ (m < 10 ? '0' + m : m);
}
</script>

<%-- 引入autocomplete插件 --%>
<link rel="stylesheet" href="<%=contextPath%>/jslib/jquery-autocomplete/jquery.autocomplete.css" type="text/css">
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-autocomplete/jquery.autocomplete.min.js" charset="utf-8"></script>

<%-- 引入datagrid-detailview插件 --%>
<script type="text/javascript" src="<%=contextPath%>/jslib/datagrid-detailview.js" charset="utf-8"></script>

<%-- 引入hashmap插件 --%>
<script type="text/javascript" src="<%=contextPath%>/jslib/hashmap.js" charset="utf-8"></script>


