<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YG_Manager.aspx.cs" Inherits="SystemSet_YG_Manager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    
    .edituser{}
    .edituser ul{}
    .edituser ul li{ list-style:none; height:25px;}
    .edituser ul li span{ display:block ; float:left; width:65px;height:20px; line-height:20px; font:12px; text-align:right;}
    .edituser ul li .textbox{ float:left; width:200px;height:20px; line-height:20px; font:12px;}
    </style>
</head>
<body>
<div class="ui-page">
	<table id="dg" class="easyui-datagrid" title="员工账号" style="width:100%;height:100%"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				method: 'get',
				onDblClickCell: onDblClickCell,
                url:'Action/Handler.ashx?cmd=GetYGDataList'
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80,hidden:'ture'">ID</th>
				<th data-options="field:'username',width:100,halign:'center'">用户名</th>
				<th data-options="field:'readname',width:100,halign:'center'">真实姓名</th>
                <th data-options="field:'phone',width:100,halign:'center'">联系电话</th>
                <th data-options="field:'organize',width:200,halign:'center'">所在部门</th>
                <th data-options="field:'role',width:200,halign:'center'">角色</th>
                <th data-options="field:'lasttime',width:110,halign:'center'">最后登录时间</th>
                <th data-options="field:'creator',width:100,halign:'center'">创建人</th>
                <th data-options="field:'creattime',width:110,halign:'center'">创建时间</th>
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
	        window.location = "YG_Manager.aspx";
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
	            var array_of_checked_values = $("#jstxt").combobox("getValues");
	            var jsIdList = "";
                for(item in array_of_checked_values) {
                    jsIdList += item.id+",";
                }
	            yocom.ajax({
	                url: "Action/Handler.ashx?cmd=AddYG",
	                data: {
	                    "username": $("#usernametxt").val(),
	                    "readname": $("#readnametxt").val(),
	                    "phone": $("#phonetxt").val(),
	                    "bm": $("#bmtxt").combotree("tree").tree('getSelected').id,
	                    "js": jsIdList
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

	    //增加账号
	    function append() {
	        $("#isaddorupdate").val("add");

	        $("#bmtxt").combotree({
	            url: "Action/Handler.ashx?cmd=GetBMTree",
	            method: "get",
	            width: 200,
	            onLoadSuccess: function () {
	                $('#bmtxt').combotree('setValue', 1);
	            }
	        });

	        $('#jstxt').combobox({
	            valueField: 'id',
	            textField: 'text',
	            editable: false,
	            url: "Action/Handler.ashx?cmd=GetJSList",
	            method: 'get',
	            multiple: true,
	            panelHeight: 'auto',
	            width: 200,
	            onLoadSuccess: function () {
	               // $('#jstxt').combobox('setValue', 1);
	            }
	        });

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

    <div id="w" class="easyui-window" title="员工账号信息" data-options="iconCls:'icon-search',closed:true,resizable:false,minimizable:false,maximizable:false" style="width:380px;height:230px;padding:5px;">
		    <div class="easyui-layout" data-options="fit:true">
			    <div data-options="region:'center'">
                <input id="isaddorupdate" style=" display:none;" />
                    <div class="edituser">
                        <ul>
                            <li><span>用户名：</span><input class="textbox" id="usernametxt" type="text" name="name" /></li>
                            <li><span>真实姓名：</span><input class="textbox" id="readnametxt" type="text" name="name"  /></li>
                            <li><span>联系电话：</span><input class="textbox" id="phonetxt" type="text" name="name"  /></li>
                            <li><span>所在部门：</span><input id="bmtxt" name="name" /></li>
                            <li><span>角色：</span><input id="jstxt" class="easyui-combobox" name="js" ></li>
                        </ul>
                        
                    
                    </div>
                </div>
			    <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="updateName()" style="width:80px">确认</a>
				    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close')" style="width:80px">关闭</a>
			    </div>
	        </div>
        </div>

</body>
</html>