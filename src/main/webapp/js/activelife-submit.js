var activelife_submit = function() {
    // 自定义异步提交方法
};
/**
 * 提交普通数据方法
 * 
 * @param url
 *            请求URL
 * @param data
 *            请求参数
 * @param entry
 *            点击对象（入口）
 * @param callback
 *            回调函数
 */
activelife_submit.submit = function(url, data, entry, callback) {
    $.ajax({
        url : url,
        type : "post",
        dataType : "JSON",
        data : data,
        success : function(result) {
            callback(result, entry);
        }
    });
};
/**
 * 异步文件上传
 * 
 * @param url
 *            请求URL
 * @param data
 *            请求参数
 * @param fileId
 *            文件域ID
 * @param callback
 *            回调函数
 */
activelife_submit.submitFile = function(url, fileId, callback) {
    $.ajaxFileUpload({
        url : url,
        type : "post",
        secureuri : false,
        fileElementId : fileId,
        dataType : "json",// 必须小写
        data : {},
        success : function(data, status) {
            callback(data);
        },
        error : function(data, status, e) {
            alert(e);
        }
    });
};