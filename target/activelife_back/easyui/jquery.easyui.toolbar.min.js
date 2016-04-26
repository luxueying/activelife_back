$.extend($.fn.datagrid.methods,{
	addToolbarItem: function(jq, items){
		return jq.each(function(){
			var toolbar = $(this).parent().prev("div.datagrid-toolbar");
			for(var i = 0;i<items.length;i++){
				var item = items[i];
				if(item === "-"){
					toolbar.append('<div class="datagrid-btn-separator"></div>');
				}else{
					var btn=$("<a href=\"javascript:void(0)\"></a>");
					btn[0].onclick=eval(item.handler||function(){});
					btn.css("float","left").appendTo(toolbar).linkbutton($.extend({},item,{plain:true}));
				}
			}
			toolbar = null;
		});
	},
	removeToolbarItem: function(jq, param){
		return jq.each(function () {
			var dpanel = $(this).datagrid('getPanel');
			var toolbar = dpanel.children("div.datagrid-toolbar");
			var cbtn = null;
			if (typeof param == "number") {
				cbtn = toolbar.find("td").eq(param).find('span.l-btn-text');
			} else if (typeof param == "string") {
				cbtn = toolbar.find("span.l-btn-text:contains('" + param + "')");
			}
			if (cbtn && cbtn.length > 0) {
				cbtn.closest('td').remove();
				cbtn = null;
			}
		});
	},
	permissionToolbarItem: function(jq, params){
		return jq.each(function(){
			var dpanel = $(this).datagrid('getPanel');
			var toolbar = dpanel.children("div.datagrid-toolbar").find("a");
			var cbtn = null;
			var id = null;
			toolbar.each(function(){
				id = $(this).attr("id");
				if(params.indexOf(id) == -1){
					cbtn = $(this);
					if(cbtn){
						cbtn.closest('td').remove();
						cbtn= null;
					}
					text = null;
					return;
				}
			});
		});  
	}
});