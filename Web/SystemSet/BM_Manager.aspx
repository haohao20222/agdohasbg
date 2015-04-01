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
<body style="position:relative;" onclick ="clickBlank()">

    <div class="ui-page">
	<table id="tg" class="easyui-treegrid" title="部门管理" style="width:100%;height:100%"
			data-options="
                iconCls: 'icon-edit',
				singleSelect: true,
				rownumbers: true,

				animate: true,
				
				url:'Action/Handler.ashx?cmd=GetBMDataList',
				method: 'get',

				idField: 'id',
				treeField: 'name',

                toolbar:'#tb',
                onDblClickRow: onDblClickRow
               
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80,hidden:'true'">ID</th>
				<th data-options="field:'name',width:200,editor:'textbox',halign:'center',styler: function(value,row,index){if(value=='新建部门') return 'color:red';}">部门名称</th>
				<th data-options="field:'note',width:500,align:'left',editor:'textbox',halign:'center'" >说明</th>
			</tr>
		</thead>
	</table>
    <div id="tb" style="padding:2px 5px;height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">增加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">移除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">查看修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="thisReload()">刷新</a>
	    </div>
	<script type="text/javascript">

	    $(function () {
	        $('#tg').treegrid({

	            onBeforeEdit: function () {
	                
	            },
	            onAfterEdit: function () {
	                
	            },
	            onLoadError: function (arguments) {
	                $.messager.alert("错误", "数据加载失败！");
                }
	        });
	    })

	    //刷新
	    function thisReload() {
	        yocom.confirm({
	            msg: "刷新此页面，如果你的操作尚未保存将会丢失？",
	            success: function () {
	                window.location = "BM_Manager.aspx";
	                //$('#tg').treegrid('reload');
	            }
	        });
	    }

	    var editIndex = undefined;
	    function endEditing() {
	        if (editIndex == undefined) { return true }
	        if ($('#tg').treegrid('validateRow', editIndex.id)) {
	            var ed = $('#tg').treegrid('getEditor', { index: editIndex.id });
	            $('#tg').treegrid('endEdit', editIndex.id);
	            editIndex = undefined;
	            return true;
	        } else {
	            return false;
	        }
	    }
        //单击修改
	    function onDblClickRow(index) {
	        if (editIndex != index) {
	            if (endEditing()) {
	                $('#tg').treegrid('selectRow', index.id).treegrid('beginEdit', index.id);
	                editIndex = index;
	            } else {
	                $('#tg').treegrid('selectRow', editIndex.id); 
	            }
	        }
	    }
	    //增加
	    function append() {
	        if (endEditing()) {
	            var node = $('#tg').treegrid('getSelected');
	            yocom.ajax({
	                url: "Action/Handler.ashx?cmd=AppendBM",
	                data: { "fid": node.id },
	                success: function (data) {
	                    if (data.flag == "true") {
	                        $('#tg').treegrid('append', {
	                            parent: data.item.FatherOrganize,
	                            data: [{
	                                id: data.item.id,
	                                name: data.item.name,
	                                note: data.item.note,
	                                _parentId: data.item.fid
	                            }]
	                        });
	                        $('#tg').treegrid('reload').ajaxSuccess(function () {
	                            $('#tg').treegrid('selectRow', data.item.id).treegrid('beginEdit', data.item.id);
	                            editIndex = $('#tg').treegrid('getSelected');
                            });
	                    } else {
	                        $.messager.alert('失败', data.msg);
	                    }
	                }
	            });
	        }
	    }
        //移除删除
	    function removeit() {
	        if (editIndex == undefined) { return }
	        yocom.ajax({
	            url: "Action/Handler.ashx?cmd=RemoveBM",
	            data: { "fid": node.id },
	            success: function (data) {
	                if (data.flag == "true") {
	                    $('#tg').treegrid('append', {
	                        parent: data.item.FatherOrganize,
	                        data: [{
	                            id: data.item.id,
	                            name: data.item.name,
	                            note: data.item.note,
	                            _parentId: data.item.fid
	                        }]
	                    });
	                    $('#tg').treegrid('reload').ajaxSuccess(function () {
	                        $('#tg').treegrid('selectRow', data.item.id).treegrid('beginEdit', data.item.id);
	                        editIndex = $('#tg').treegrid('getSelected');
	                    });
	                } else {
	                    $.messager.alert('失败', data.msg);
	                }
	            }
	        });
	    }
        //保存
	    function accept() {
	        $('#tg').treegrid('acceptChanges');
	    }
	    //撤销
	    function reject() {
	        $('#tg').treegrid('rejectChanges');
	        editIndex = undefined;
	    }
        //获取改变内容
	    function getChanges() {
	        var rows = $('#tg').treegrid('getChanges');
	        $.messager.alert("提示", rows.length + ' 行被修改!');
	    }

	    function clickBlank() {
	        if (editIndex != undefined) {
	            $('#tg').treegrid('endEdit', editIndex.id);
	            editIndex = undefined;
	        }
	    }
	</script>
    </div>
</body>
</html>
