<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
function showLogisticsDetail(){
	if(document.getElementById("div1").style.display=='none')
    {
	document.getElementById("div1").style.display="";
    }
    else
    {
document.getElementById("div1").style.display="none";
    }
	var logisticsCode=$("#logisticsCode").val();
	var companyId=$("#companyId").val();
	
	$.ajax({
			 type: 'POST',
			 url:"showLogisticsDetail.do?",
			 data: {"logisticsCode":logisticsCode,"companyId":companyId},
			 dataType: "json" ,
			 success: function(data){
				 data=JSON.parse(data);
				 wuliu=data.data;
				 for(var i=0;i<wuliu.length;i++){
					 $('#time'+i).html(wuliu[i].time);
					 $('#content'+i).html(wuliu[i].content);
					 
					 }	 
				 
			 },
			 error : function (XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest + "_" +textStatus);
				}
			 
			 });
	}





</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">物流信息查询&nbsp;&gt;&gt;&nbsp;物流信息追踪</span>
    </div>
    <div class="body">
        <form action="editLogisticsCompany.do" method="post">
            <table align="center">
                <tr>
                    <td class="field_name">运单编号：</td>
                    <td><input id="logisticsCode" type="text" name="logisticsCode" class="generic_input" value="${logistics.logisticsCode}" /> </td>
                    <td></td>
                </tr>   
                <tr>
                    <td class="field_name">物流公司：</td>
                    <td><input type="text" name="companyName" class="generic_input" value="${logistics.companyName}" /><input id="companyId" type="hidden" name="logistics" value="${logistics.companyId}" /></td>
                    <td></td>
                </tr>
               <tr> 
               <td align="right"><input type="button" value="查询" onClick="showLogisticsDetail()" /></td>
               </tr>   
            </table>
           
           
           <div id="div1"  style="display:none">
<table align="center"  cellpadding="0" cellspacing="0" class="ajaxtable">
<thead>
<tr>
<th>时间：</th>
<th>目的地：</th>

</tr>
</thead>
 <c:forEach var="i" begin="0" end="10">
<tr>
<td><span id="time${i}"></span></td>
<td><span id="content${i}"></span></td>

</tr>
</c:forEach>
</table>
<a href="../../web/backlog/allBlaclogAction?backlogTypes=xnjc_" style="float:right;padding-right:10px;padding-top:5px;" id="url1"><img src="../../images/dbmore.gif" /></a>
</div>
        </form>
    </div>
</body>
</html>