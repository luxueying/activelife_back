<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title> Hello MiniUI!</title>
    <!--jQuery js-->
    <script src="js/jquery.js" type="text/javascript"></script>
    <!--MiniUI-->
    <link href="miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />        
    <script src="miniui/miniui.js" type="text/javascript"></script>
</head>
<body>
  <div id="datagrid1" class="mini-datagrid" style="width:1000px;height:380px;" 
    url="listCustomer.do?" idField="id"
    allowResize="true" pageSize="20" 
    allowCellEdit="true" allowCellSelect="true" multiSelect="true"
>
    <div property="columns">
        <div type="checkcolumn"></div>            
        <div field="customerId" width="120" headerAlign="center" allowSort="true">用户ID
            <input property="editor" class="mini-textbox" style="width:100%;"/>
        </div>                
        <div field="realName" width="100" renderer="onGenderRenderer" align="center" headerAlign="center" allowSort="true">用户名
            <input property="editor" class="mini-textbox" style="width:100%;"/>
        </div>
        <div field="nickName" width="100" allowSort="true" >用户昵称
            <input property="editor" class="mini-spinner" minValue="0" maxValue="200" value="25" style="width:100%;"/>
        </div>
        <div field="status" width="100" allowSort="true" dateFormat="yyyy-MM-dd">用户状态
            <input property="editor" class="mini-combobox" style="width:100%;" data="status"/>
        </div>    
        <div field="phoneNumber" width="120" headerAlign="center" allowSort="true">手机
            <input property="editor" class="mini-textarea" style="width:100%;" minHeight="80"/>
        </div>   
         <div field="email" width="120" headerAlign="center" allowSort="true">电子邮箱
            <input property="editor" class="mini-textarea" style="width:100%;" minHeight="80"/>
        </div>                                 
        <div field="createTime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">创建时间</div>
    </div>
</div> 

<script type="text/javascript">

mini.parse();
var grid = mini.get("datagrid1");
grid.load();
grid.sortBy("customerId", "desc"); 
mini.alert(columns);

function search() {
  /*  var key = document.getElementById("key").value;
    grid.load({ key: key });   
    grid.load();
    grid.sortBy("customerId", "desc"); */
	
    
}
function addRow() {
    var newRow = { name: "New Row" };
    grid.addRow(newRow, 0);
}
function removeRow() {
    var rows = grid.getSelecteds();
    if (rows.length > 0) {
        grid.removeRows(rows, true);
    }
}
function saveData() {
    var data = grid.getChanges();
    var json = mini.encode(data);
    grid.loading("保存中，请稍后......");        
    $.ajax({
        url: "../data/AjaxService.aspx?method=SaveChangedEmployees",
        data: { data: json },
        type: "post",
        success: function (text) {
            grid.reload();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    });
}




</script>
</body>
</html>