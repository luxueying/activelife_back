<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="jquery-ui/themes/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="css/back.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="jquery-ui/ui/jquery-ui.js"></script>
<script type="text/javascript" src="js/activelife-submit.js"></script>
<script type="text/javascript" src="js/activelife-dialog.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        //给你挑按钮绑定事件
        $("#submitButton").click(function() {
            var imageId = $("#imageId").val();
            var imageType = $("#imageType").val();
            var status = $("input[name=status]:checked").val();

            var data = {
                "imageId" : imageId,
                "imageType" : imageType,
                "status" : status
            };

            activelife_submit.submit("editProductImage.do", data, null, afterSubmit);

            return false;
        });

        //异步提交的回调函数
        function afterSubmit(result, aEntry) {
            if (result.statusCode == "200") {
                var option = {
                    content : "更新成功！"
                };
                activelife_dialog.showMessageDialog(option);
            } else {
                var option = {
                    content : result.message
                };
                activelife_dialog.showMessageDialog(option);
            }
        }
    });
</script>
</head>
<body>
    <div class="header">
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品图片维护</span>
    </div>
    <div class="body">
        <form>
            <table align="center">
                <tr>
                    <td class="field_name">图片用途：</td>
                    <td><select name="imageType" class="generic_select" id="imageType">
                            <option value="">请选择</option>
                            <c:forEach items="${imageTypes}" var="imageType">
                                <c:if test="${productImage.imageType == imageType.key}">
                                    <option value="${imageType.key}" selected="selected">${imageType.value}</option>
                                </c:if>
                                <c:if test="${productImage.imageType != imageType.key}">
                                    <option value="${imageType.key}">${imageType.value}</option>
                                </c:if>
                            </c:forEach>
                    </select> <input type="hidden" name="imageId" value="${productImage.imageId}" id="imageId" /></td>
                    <td rowspan="3"><img width="350" height="350" src="<%=basePath%>${productImage.imageUrl}" style="margin-left: 100px;"></td>
                </tr>
                <tr>
                    <td class="field_name">有效状态：</td>
                    <td><c:if test="${productImage.status == 'Y'}">
                            <input type="radio" name="status" value="N" />无效
                            <input type="radio" name="status" value="Y" checked="checked" class="generic_radio" />有效
                        </c:if> <c:if test="${productImage.status != 'Y'}">
                            <input type="radio" name="status" value="N" checked="checked" />无效
                            <input type="radio" name="status" value="Y" class="generic_radio" />有效
                        </c:if></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="保存" id="submitButton" /></td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>

</body>
</html>