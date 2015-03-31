<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BM_Manager.aspx.cs" Inherits="SystemSet_BM_Manager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.1/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.1/themes/icon.css" />
    
    <script type="text/javascript" src="../jquery-easyui-1.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="../jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../JS/yocom.js"></script>
    <style type="text/css">
     html,body{ height:100%; width:100%; margin:0px; padding:0px;}
    .ui-page{position:absolute!important;top:5px!important;height:auto!important; position:relative; top:0px; height:100%;bottom:5px;width:100%;overflow: auto;}
    .ui-page{position:absolute!important;left:5px!important;width:auto!important; position:relative; left:0px; width:100%;right:5px;height:100%;overflow: auto;}
    </style>
</head>
<body style="position:relative;">

    <div class="ui-page">
	<table id="tg" class="easyui-treegrid" title="部门管理" style="width:100%;height:100%"
			data-options="
				rownumbers: true,
				animate: true,
				fitColumns: true,
				url: 'Action/Handler.ashx?cmd=GetBMDataList',
				method: 'get',
				idField: 'id',
				treeField: 'name',
				showFooter: true,

                pagination:true,
                pageSize:20,
                toolbar:'#tb'
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80,hidden:'true'">ID</th>
				<th data-options="field:'name',width:200,align:'right',editor:'text'">部门名称</th>
				<th data-options="field:'note',width:300,editor:'text'">说明</th>
			</tr>
		</thead>
	</table>
    <div id="tb" style="padding:2px 5px;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="edit()">修改</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="save()">保存</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cancel()">取消</a>
	    </div>
	<script type="text/javascript">
	    $(function () {
	        var pager = $('#tg').datagrid().datagrid('getPager'); // get the pager of datagrid
	        pager.pagination({
	            onBeforeRefresh: function () { $('#tg').datagrid('reload'); }, //刷新
	            onSelectPage: function () {
	                $(this).pagination('loading');
	                $('#tg').datagrid('reload');
	                $(this).pagination('loaded');
	            },
	            buttons: [
                    {
                        iconCls: 'icon-add',
                        handler: function () {
                            edit();
                        }
                    }, {
                        iconCls: 'icon-edit',
                        handler: function () {
                            editNotice();
                        }
                    }, {
                        iconCls: 'icon-cancel',
                        handler: function () {
                            deleteNotice();
                        }
                    }]
	        });
	    })

	    function formatProgress(value) {
	        if (value) {
	            var s = '<div style="width:100%;border:1px solid #ccc">' +
		    			'<div style="width:' + value + '%;background:#cc0000;color:#fff">' + value + '%' + '</div>'
	            '</div>';
	            return s;
	        } else {
	            return '';
	        }
	    }
	    var editingId;
	    function edit() {
	        if (editingId != undefined) {
	            $('#tg').treegrid('select', editingId);
	            return;
	        }
	        var row = $('#tg').treegrid('getSelected');
	        if (row) {
	            editingId = row.id
	            $('#tg').treegrid('beginEdit', editingId);
	        }
	    }
	    function save() {
	        if (editingId != undefined) {
	            var t = $('#tg');
	            t.treegrid('endEdit', editingId);
	            editingId = undefined;
	            var persons = 0;
	            var rows = t.treegrid('getChildren');
	            for (var i = 0; i < rows.length; i++) {
	                var p = parseInt(rows[i].persons);
	                if (!isNaN(p)) {
	                    persons += p;
	                }
	            }
	            var frow = t.treegrid('getFooterRows')[0];
	            frow.persons = persons;
	            t.treegrid('reloadFooter');
	        }
	    }
	    function cancel() {
	        if (editingId != undefined) {
	            $('#tg').treegrid('cancelEdit', editingId);
	            editingId = undefined;
	        }
	    }
	</script>
    </div>
</body>
</html>
