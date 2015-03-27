var yocom = {
    ajax: function (jsonData) {
        if (jsonData.dataType == undefined || jsonData.dataType == '') {
            jsonData.dataType = "json";
        }
        $.ajax({
            type: "POST",
            dataType: jsonData.dataType,
            url: jsonData.url,
            data: jsonData.data,
            beforeSend: function () {
                $("<div class=\"datagrid-mask\" id=\"n-datagrid-mask\"></div>").css({
                    display: "block", width: "100%", height: $(window).height(), zIndex: 99998
                }).appendTo("body");
                $("<div class=\"datagrid-mask-msg\" id=\"n-datagrid-mask-msg\"></div>").html("Processing, please wait ...").appendTo("body").css({
                    display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2, zIndex: 99999
                });
            },
            complete: function () {
                $("#n-datagrid-mask").remove();
                $("#n-datagrid-mask-msg").remove();
            },
            success: function (data) {
                jsonData.success(data);
            },
            error: function (data, textStatus, errorThrown) {
                $.messager.alert('错误', errorThrown);
            }
        });
    },
    getParams: function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    },
    confirm: function (jsonData) {
        var s = document.getElementById("confirmdlg");
        var ss = $("#confirmdlg");
        if (ss.length < 1 || s == null) {
            $("<div id=\"confirmdlg\" style='padding:10px;min-width:240px;max-width:900px;'></div>").appendTo("body");
        }
        $('#confirmdlg').html(jsonData.msg);
        $('#confirmdlg').dialog({
            title: '确认',
            closed: false,
            cache: false,
            modal: true,
            iconCls: 'icon-help',
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    jsonData.success();
                    $('#confirmdlg').dialog('close');
                }
            }, {
                text: '取消',
                iconCls: 'icon-undo',
                handler: function () {
                    $('#confirmdlg').dialog('close');
                }
            }]
        });
    },
    alert: function (title, msg) {
        if (arguments.length>=2)
            $.messager.alert(title, msg);
        else
            $.messager.alert("提示", title);
    }

}