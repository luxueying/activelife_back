var activelife_callback = function() {
    // 共用的回调函数
};

/**
 * 更新状态后的回调 状态为Y/N
 * 
 * @param result
 *            上一步返回结果
 * @param aEntry
 *            更改对象入口
 */
activelife_callback.afterUpdateYNStatus = function(result, aEntry) {
    if (result.statusCode == "200") {
        var spanEntry = aEntry.parent().parent().find("span.status");
        if (result.attribute.status == "Y") {
            spanEntry.removeClass("status_red");
            spanEntry.addClass("status_green");
            spanEntry.text("有效");

            aEntry.attr("status", "Y");
            aEntry.text("设为无效");
        } else {
            spanEntry.removeClass("status_green");
            spanEntry.addClass("status_red");
            spanEntry.text("无效");

            aEntry.attr("status", "N");
            aEntry.text("设为有效");
        }
    } else {
        var option = {
            content : result.message
        };
        activelife_dialog.showMessageDialog(option);
    }
};