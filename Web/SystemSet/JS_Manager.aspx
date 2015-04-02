<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JS_Manager.aspx.cs" Inherits="SystemSet_JS_Manager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
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
<body>
<div class="ui-page">
	<table id="dg" class="easyui-datagrid" title="角色管理" style="width:100%;height:100%"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				method: 'get',
				onDblClickRow: onDblClickRow,
                url:'Action/Handler.ashx?cmd=GetJSDataList'
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80,hidden:'ture'">ID</th>
				<th data-options="field:'name',width:100,editor:'textbox',align:'center',halign:'center'">角色名称</th>
				<th data-options="field:'note',width:80,editor:'textbox',halign:'center'">List Price</th>
				<th data-options="field:'note',width:80,editor:'textbox',halign:'center'">Unit Cost</th>
				<th data-options="field:'note',width:250,editor:'textbox',halign:'center'">Attribute</th>
				<th data-options="field:'jlist',width:60,editor:'textbox',halign:'center'">Status</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">增加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">移除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="thisReload()">刷新</a>
	</div>
	
	<script type="text/javascript">
	    $(function () {
	        $('#dg').datagrid({
	            onBeforeEdit: function () {
	            },
	            onAfterEdit: function (row, changes) {
	                yocom.ajax({
	                    url: "Action/Handler.ashx?cmd=EditBM",
	                    data: {
	                        "itemid": row.id,
	                        "itemname": row.name,
	                        "itemnote": row.note
	                    },
	                    success: function (data) {
	                        if (data.flag == "true") {
	                           
	                        } else {
	                            $.messager.alert('失败', data.msg);
	                        }
	                    }
	                });
	            },
	            onCancelEdit: function (row) {

	            },
	            onLoadError: function (arguments) {
	                $.messager.alert("错误", "数据加载失败！");
	            }
	        });
	    })
	    //刷新
	    function thisReload() {
	        window.location = "JS_Manager.aspx";
	    }

	    var editIndex = undefined;
	    function endEditing() {
	        if (editIndex == undefined) { return true }
	        if ($('#dg').datagrid('validateRow', editIndex)) {
	            var ed = $('#dg').datagrid('getEditor', { index: editIndex });
	            $('#dg').datagrid('endEdit', editIndex);
	            editIndex = undefined;
	            return true;
	        } else {
	            return false;
	        }
	    }
	    function onDblClickRow(index) {
	        if (editIndex != index) {
	            if (endEditing()) {
	                $('#dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
	                editIndex = index;
	            } else {
	                $('#dg').datagrid('selectRow', editIndex);
	            }
	        }
	    }
	    function append() {
	        if (endEditing()) {
	            $('#dg').datagrid('appendRow', { status: 'P' });
	            editIndex = $('#dg').datagrid('getRows').length - 1;
	            $('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
	        }
	    }
	    function removeit() {
	        if (editIndex == undefined) { return }
	        $('#dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
	        editIndex = undefined;
	    }
	    function accept() {
	        if (endEditing()) {
	            $('#dg').datagrid('acceptChanges');
	        }
	    }
	    function reject() {
	        $('#dg').datagrid('rejectChanges');
	        editIndex = undefined;
	    }
	    function getChanges() {
	        var rows = $('#dg').datagrid('getChanges');
	        alert(rows.length + ' rows are changed!');
	    }
	</script>
    </div>
</body>
</html>