var activelife_dialog = function() {
    //自定义对话框
};

/**
 * 展示确认对话框
 * 
 * @param option
 *            可选参数
 */
activelife_dialog.showConfirmDialog = function(option) {
    var dialog = $("#dialog-confirm");
    if (dialog.size() == 0) {
        var node = $("<div id='dialog-confirm'><p id='confirm-content'></p></div>");
        $("body").append(node);
    }
    $("#confirm-content").text(option.content);
    var defautOption = {
        title : "确认对话框",
        resizable : false,
        height : "auto",
        modal : true,
        buttons : {
            "确定" : function() {
                $(this).dialog("close");
            },
            "取消" : function() {
                $(this).dialog("close");
            }
        }
    };

    option = $.extend(true, defautOption, option);
    $("#dialog-confirm").dialog(option);
};

/**
 * 展示消息对话框
 * 
 * @param option
 *            可选参数
 */
activelife_dialog.showMessageDialog = function(option) {
    var dialog = $("#dialog-message");
    if (dialog.size() == 0) {
        var node = $("<div id='dialog-message'><p id='message-content'></p></div>");
        $("body").append(node);
    }
    $("#message-content").text(option.content);
    var defautOption = {
        title : "消息对话框",
        resizable : false,
        height : "auto",
        modal : true,
        buttons : {
            "关闭" : function() {
                $(this).dialog("close");
            }
        }
    };

    option = $.extend(true, defautOption, option);
    $("#dialog-message").dialog(option);
};
