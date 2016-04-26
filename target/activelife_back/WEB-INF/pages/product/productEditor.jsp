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
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<script type="text/javascript" src="js/activelife-submit.js"></script>
<script type="text/javascript" src="js/activelife-dialog.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#tabs").tabs();

        //修改国家
        $("#countryCode").change(function() {
            var countryCode = $(this).val();
            $.ajax({
                url : "getProvinceList.do",
                type : "post",
                dataType : "JSON",
                data : {
                    "countryCode" : countryCode
                },
                success : function(result) {
                    var provinceEntry = $("#provinceCode");
                    provinceEntry.empty();
                    provinceEntry.append("<option>请选择</option>");
                    for (index in result) {
                        var data = result[index];
                        provinceEntry.append("<option value='"+ data.provinceCode +"'>" + data.provinceName + "</option>");
                    }
                }
            });
        });

        //修改省份
        $("#provinceCode").change(function() {
            var provinceCode = $(this).val();
            $.ajax({
                url : "getCityList.do",
                type : "post",
                dataType : "JSON",
                data : {
                    "provinceCode" : provinceCode
                },
                success : function(result) {
                    var cityEntry = $("#cityCode");
                    cityEntry.empty();
                    cityEntry.append("<option>请选择</option>");
                    for (index in result) {
                        var data = result[index];
                        cityEntry.append("<option value='"+ data.cityCode +"'>" + data.cityName + "</option>");
                    }
                }
            });
        });

        //修改城市
        $("#cityCode").change(function() {
            var cityCode = $(this).val();
            $.ajax({
                url : "getCountyList.do",
                type : "post",
                dataType : "JSON",
                data : {
                    "cityCode" : cityCode
                },
                success : function(result) {
                    var countyEntry = $("#countyCode");
                    countyEntry.empty();
                    countyEntry.append("<option>请选择</option>");
                    for (index in result) {
                        var data = result[index];
                        countyEntry.append("<option value='"+ data.countyCode +"'>" + data.countyName + "</option>");
                    }
                }
            });
        });

        function finishUpload(result) {
            if (result.statusCode == '200') {
                var url = result.attribute.url;
                var img = $("#img");
                var baseUrl = $("#basePath").val();
                img.attr("src", baseUrl + url);
                var deleteImage = $("#deleteImage");
                deleteImage.show();
                deleteImage.attr("imageId", result.attribute.imageId);
            } else {
                var option = {
                    content : result.message
                };
                activelife_dialog.showMessageDialog(option);
            }
        }

        $("#fileUpload").click(function() {
            var imageType = $("#imageType").val();
            var productId = $("#productId").val();
            var url = "uploadProductImage.do?imageType=" + imageType + "&&productId=" + productId;
            var fileId = "imageFile";
            activelife_submit.submitFile(url, fileId, finishUpload);
            
            return false;
        });

        $("#imageFile").change(function() {
            var file = this;
            var fileName = file.files[0].name;
            var position = fileName.lastIndexOf(".");
            var imageTypes = new Array();
            imageTypes.push("jpg");
            imageTypes.push("gif");
            imageTypes.push("jpeg");
            imageTypes.push("png");
            if (position != -1) {
                var suffix = fileName.substring(position + 1, fileName.length).toLowerCase();
                if ($.inArray(suffix, imageTypes) == -1) {
                    var option = {
                        content : "只支持[jpg], [gif], [jpeg], [png]格式的图片文件！"
                    };
                    activelife_dialog.showMessageDialog(option);
                }
            } else {
                var option = {
                    content : "只支持图片文件！"
                };
                activelife_dialog.showMessageDialog(option);
            }
        });

        $("#deleteImage").click(function() {
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

        function afterDeleteImage(result, aEntry) {
            if (result.statusCode == "200") {
                aEntry.hide();
                $("#img").attr("src", "");
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
        <span class="crumb_icon"></span> <span class="crumb_left">你当前的位置：</span> <span class="crumb_right">产品管理&nbsp;&gt;&gt;&nbsp;产品编辑</span>
        <button style="right: 0;"><a href="showProductList.do">返回到产品列表</a></button>	
        
    </div>
    <div class="body">
        <div id="tabs">
            <ul>
                <li><a href="#tabs-1">产品基本信息</a></li>
                <li><a href="#tabs-2">产品地域</a></li>
                <li><a href="#tabs-3">产品图片</a></li>
            </ul>
            <div id="tabs-1">
                <form action="editProduct.do" method="post">
                    <table align="center">
                        <tr>
                            <td class="field_name">产品编号：</td>
                            <td><input type="text" name="productCode" class="generic_input" value="${product.productCode}" /> <input type="hidden" name="productId" value="${product.productId}" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">产品名称：</td>
                            <td><input type="text" name="productName" class="generic_input" value="${product.productName}" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">产品价格：</td>
                            <td><input type="text" name="price" class="generic_input" value="${product.price}" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">产品库存：</td>
                            <td><input type="text" name="stock" class="generic_input" value="${product.stock}" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="保存" /></td>
                            <td></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div id="tabs-2">
                <form action="editProductLocation.do" method="post">
                    <table align="center">
                        <tr>
                            <td class="field_name">所属国家：</td>
                            <td><select name="countryCode" class="generic_select" id="countryCode">
                                    <option>请选择</option>
                                    <c:forEach items="${countryList}" var="country">
                                        <c:if test="${product.countryCode == country.countryCode}">
                                            <option value="${country.countryCode}" selected="selected">${country.countryName}</option>
                                        </c:if>
                                        <c:if test="${product.countryCode != country.countryCode}">
                                            <option value="${country.countryCode}">${country.countryName}</option>
                                        </c:if>
                                    </c:forEach>
                            </select> <input type="hidden" name="productId" value="${product.productId}" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">所属省份：</td>
                            <td><select name="provinceCode" class="generic_select" id="provinceCode">
                                    <option>请选择</option>
                                    <c:forEach items="${provinceList}" var="province">
                                        <c:if test="${product.provinceCode == province.provinceCode}">
                                            <option value="${province.provinceCode}" selected="selected">${province.provinceName}</option>
                                        </c:if>
                                        <c:if test="${product.provinceCode != province.provinceCode}">
                                            <option value="${province.provinceCode}">${province.provinceName}</option>
                                        </c:if>
                                    </c:forEach>
                            </select></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">所属市：</td>
                            <td><select name="cityCode" class="generic_select" id="cityCode">
                                    <option>请选择</option>
                                    <c:forEach items="${cityList}" var="city">
                                        <c:if test="${product.cityCode == city.cityCode}">
                                            <option value="${city.cityCode}" selected="selected">${city.cityName}</option>
                                        </c:if>
                                        <c:if test="${product.cityCode != city.cityCode}">
                                            <option value="${city.cityCode}">${city.cityName}</option>
                                        </c:if>
                                    </c:forEach>
                            </select></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">所属县：</td>
                            <td><select name="countyCode" class="generic_select" id="countyCode">
                                    <option>请选择</option>
                                    <c:forEach items="${countyList}" var="county">
                                        <c:if test="${product.countyCode == county.countyCode}">
                                            <option value="${county.countyCode}" selected="selected">${county.countyName}</option>
                                        </c:if>
                                        <c:if test="${product.countyCode != county.countyCode}">
                                            <option value="${county.countyCode}">${county.countyName}</option>
                                        </c:if>
                                    </c:forEach>
                            </select></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="field_name">地址：</td>
                            <td><input type="text" name="address" class="long_input" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="保存" /></td>
                            <td></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div id="tabs-3">
                <form>
                    <table>
                        <tr>
                            <td class="field_name">图片用途：</td>
                            <td><select name="imageType" class="generic_select" id="imageType">
                                    <option>请选择</option>
                                    <c:forEach items="${imageTypes}" var="imageType">
                                        <option value="${imageType.key}">${imageType.value}</option>
                                    </c:forEach>
                            </select> <input type="hidden" name="productId" value="${product.productId}" id="productId" /></td>
                            <td rowspan="3" id="imageContainer"><img width="250" height="250" id="img"> <a href="javascript:void(0)" class="href" id="deleteImage" style="display: none;">删除</a></td>
                        </tr>
                        <tr>
                            <td class="field_name">图片路径：</td>
                            <td><input type="file" name="image" id="imageFile" /></td>
                            <td><input type="hidden" value="<%=basePath%>" id="basePath" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="上传" id="fileUpload" /></td>
                            <td></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>

</body>
</html>