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
				onDblClickCell: onDblClickCell,
                url:'Action/Handler.ashx?cmd=GetJSDataList'
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80,hidden:'ture'">ID</th>
				<th data-options="field:'name',width:100,align:'center',styler: function(value,row,index){if(value=='新角色') return 'color:red';}">角色名称</th>
				<th data-options="field:'khself',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">客户信息（个人）</th>
				<th data-options="field:'khall',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">客户信息（所有）</th>
				<th data-options="field:'orderself',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">订单信息（个人）</th>
				<th data-options="field:'orderall',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">订单信息（所有）</th>
                <th data-options="field:'tallyself',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">订单统计（个人）</th>
                <th data-options="field:'tallyall',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">订单统计（所有）</th>
                <th data-options="field:'hiskhself',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">历史客户（个人）</th>
                <th data-options="field:'hiskhall',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">历史客户（所有）</th>
                <th data-options="field:'hisorderself',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">历史订单（个人）</th>
                <th data-options="field:'hisorderall',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">历史订单（所有）</th>
                <th data-options="field:'bmset',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">部门设置</th>
                <th data-options="field:'employee',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">员工账号</th>
                <th data-options="field:'role',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">角色权限</th>
                <th data-options="field:'notice',width:100,align:'center',styler: function(value,row,index){if(value=='√') return 'color:red; background-color:Yellow';}">公告信息</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">增加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">移除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="thisReload()">刷新</a>
	</div>
	
	<script type="text/javascript">
	    $(function () {
	        $('#dg').datagrid({
	            onLoadError: function (arguments) {
	                $.messager.alert("错误", "数据加载失败！");
	            }
	        });
	    })
	    //刷新
	    function thisReload() {
	        window.location = "JS_Manager.aspx";
	    }

	    function onDblClickCell(rowIndex, field, value) {
	        if (field == "name") {
	            $("#isaddorupdate").val("update");
	            $("#title").val(value);
	            $('#w').window('open');
	        }
	        else {
	            yocom.ajax({
	                url: "Action/Handler.ashx?cmd=EditJS",
	                data: {
	                    "itemid": $('#dg').datagrid('getSelected').id,
	                    "field": field,
	                    "value": value
	                },
	                success: function (data) {
	                    if (data.flag == "true") {
	                        $('#dg').datagrid('reload');
	                    } else {
	                        $.messager.alert('失败', data.msg);
	                    }
	                }
	            });
	        }
	    }

        //修改权限名称
	    function updateName() {
	        if ($("#isaddorupdate").val() == "update") {
	            yocom.ajax({
	                url: "Action/Handler.ashx?cmd=EditJS",
	                data: {
	                    "itemid": $('#dg').datagrid('getSelected').id,
	                    "field": "name",
	                    "value": $("#title").val()
	                },
	                success: function (data) {
	                    if (data.flag == "true") {
	                        $('#w').window('close');
	                        $('#dg').datagrid('reload');
	                    } else {
	                        $.messager.alert('失败', data.msg);
	                    }
	                }
	            });
	        }
	        else {
	            yocom.ajax({
	                url: "Action/Handler.ashx?cmd=AddJS",
	                data: {
	                    "value": $("#title").val()
	                },
	                success: function (data) {
	                    if (data.flag == "true") {
	                        $('#w').window('close');

	                        $('#dg').datagrid('reload');
	                    } else {
	                        $.messager.alert('失败', data.msg);
	                    }
	                }
	            });
            }
        }

        //增加角色
        function append() {
            $("#isaddorupdate").val("add");
            $("#title").val("新角色");
            $('#w').window('open');
	    }
        //移除角色
	    function removeit() {
	        var node = $('#dg').datagrid('getSelected');
	        if (node == null) {
	            $.messager.alert('提示', "请选择要删除的角色");
	            return;
	        }
	        yocom.confirm({
	            msg: "将移除所选角色？",
	            success: function () {
	                yocom.ajax({
	                    url: "Action/Handler.ashx?cmd=RemoveJS",
	                    data: { "itemid": node.id },
	                    success: function (data) {
	                        if (data.flag == "true") {
	                            $.messager.alert('成功', data.msg);
	                            $('#dg').datagrid('reload');
	                        } else {
	                            $.messager.alert('失败', data.msg);
	                        }
	                    }
	                });
	            }
	        });
	    }
	</script>
    </div>

    <div id="w" class="easyui-window" title="权限名称修改" data-options="iconCls:'icon-search',closed:true,resizable:false,minimizable:false,maximizable:false" style="width:350px;height:160px;padding:5px;">
		    <div class="easyui-layout" data-options="fit:true">
			    <div data-options="region:'center'">
                <input id="isaddorupdate" style=" display:none;" />
                    <div style="height:30px; line-height:30px; font:16px; margin:25px 25px">角色名：<input class="textbox" id="title" type="text" name="name" style=" width:200px;height:30px; line-height:30px; font:16px;" /></div>
                </div>
			    <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="updateName()" style="width:80px">确认</a>
				    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close')" style="width:80px">关闭</a>
			    </div>
	        </div>
        </div>

</body>
</html>