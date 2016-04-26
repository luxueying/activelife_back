<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
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
<script type="text/javascript" src="js/activelife-callback.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var basePath = $("#basePath").val();
        //tooltip事件
        $(document).tooltip({
            items : ".image_tooltip",
            content : function() {
                var element = $(this);
                var src = basePath + element.text();

                return "<img width='200' height='200' src='" + src + "'>";
            }
        });

        //给修改状态链接绑定事件
        $("a.status").click(function() {
            var entry = $(this);
            var status = entry.attr("status");
            if (status == "Y") {
                status = "N";
            } else {
                status = "Y";
            }
            var imageId = entry.attr("imageId");
            var data = {
                "status" : status,
                "imageId" : imageId
            };

            var option = {
                content : "确认修改吗？",
                buttons : {
                    "确定" : function() {
                        activelife_submit.submit("editProductImageStatus.do", data, entry, activelife_callback.afterUpdateYNStatus);
                        $(this).dialog("close");
                    }
                }
            };
            activelife_dialog.showConfirmDialog(option);
        });

        //给删除链接绑定事件
        $("a.delete").click(function() {
            var entry = $(this);
            var imageId = entry.attr("imageId");
            var data = {
                "imageId" : imageId
            };

            var option = {
                content : "确认删除吗？",
                buttons : {
                    "确定" : function() {
                        activelife_submit.submit("deleteProductImage.do", data, entry, afterDeleteImage);
                        $(this).dialog("close");
                    }
                }
            };
            activelife_dialog.showConfirmDialog(option);
        });

        //删除图片后的回调函数
        function afterDeleteImage(result, aEntry) {
            if (result.statusCode == "200") {
                $("#searchButton").click();
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
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品图片管理&nbsp;&gt;&gt;&nbsp;产品图片信息列表</span>
    </div>
    <div class="body">
        <div class="search_header">
            <form action="listProductImage.do" method="post">
                <table align="left">
                    <tr>
                        <td class="field_name">图片类型：</td>
                        <td><select name="imageType" class="generic_select">
                                <option value="">请选择</option>
                                <c:forEach items="${imageTypes}" var="imageType">
                                    <option value="${imageType.key}">${imageType.value}</option>
                                </c:forEach>
                        </select> <input type="hidden" value="<%=basePath%>" id="basePath" /></td>
                        <td class="field_name">有效状态：</td>
                        <td><select name="status" class="generic_select">
                                <option value="">请选择</option>
                                <option value="Y">有效</option>
                                <option value="N">无效</option>
                        </select></td>
                        <td><input type="submit" value="查询" id="searchButton" /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div>
            <form action="listProductImage.do" method="post">
                <table class="list_table" cellspacing="1" cellpadding="0">
                    <thead>
                        <tr>
                            <th>产品名称</th>
                            <th>图片类型</th>
                            <th>图片路径</th>
                            <th>有效状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productImageVoList}" var="productImageVo">
                            <tr>
                                <td class="align_left">${productImageVo.productName}</td>
                                <td class="align_left"><c:forEach items="${imageTypes}" var="imageType">
                                        <c:if test="${productImageVo.imageType == imageType.key}">
                                ${imageType.value}
                                </c:if>
                                    </c:forEach></td>
                                <td class="align_left image_tooltip">${productImageVo.imageUrl}</td>
                                <td class="align_center"><c:if test="${productImageVo.status == 'Y'}">
                                        <span class="status status_green">有效</span>
                                    </c:if> <c:if test="${productImageVo.status == 'N'}">
                                        <span class="status status_red">无效</span>
                                    </c:if></td>
                                <td class="align_center"><c:if test="${productImageVo.status == 'Y'}">
                                        <a href="javascript:void(0)" class="href status" status="${productImageVo.status}" imageId="${productImageVo.imageId}">设为无效</a>
                                    </c:if> <c:if test="${productImageVo.status == 'N'}">
                                        <a href="javascript:void(0)" class="href status" status="${productImageVo.status}" imageId="${productImageVo.imageId}">设为有效</a>
                                    </c:if> <a href="showProductImageEditor.do?imageId=${productImageVo.imageId}" class="href">编辑</a> <a href="javascript:void(0)" class="href delete" imageId="${productImageVo.imageId}">删除</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="5" style="position: relative;"><jsp:include page="../base/pagenation.jsp"></jsp:include></td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</body>
</html>