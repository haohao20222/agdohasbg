<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>广州市增城冠达五金厂</title>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/themes/icon.css" />
    <%--<link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/demo/demo.css">--%>
    <script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
     <style type="text/css">
        /*使tab内容页占满全屏（调整easy ui生成的的内容的样式）*/
        .tabs-container {position:relative;}
        .tabs-header{position:absolute;left:0px;top:0px;height: 30px;}
        .tabs-panels{position:absolute!important;top:30px!important;height:auto!important; position:relative; top:0px; height:100%;bottom:0px;width:100%;overflow: auto;}
        
        .easyui-tree a{ color:#232323; text-decoration:none;}
        .easyui-tree a:hover{color:#0000FF;text-decoration:underline;}
    </style>
    <script type="text/javascript">
        function addPagePanel(title, url) {
            if ($('#tt').tabs('exists', title)) {
                $('#tt').tabs('select', title);
            } else {
                var content = '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>';
                $('#tt').tabs('add', {
                    title: title,
                    content: content,
                    closable: true
                });
            }
        }
        $(function () {
            showMsg()
            window.setInterval(showMsg,900000);
        })
        function showMsg() {
            $.messager.show({
                title: 'My Title',
                msg: 'Message will be closed after 5 seconds.',
                timeout: 0,
                showType: 'slide'
            });
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height: 60px; background: #C4EFEB;
        padding: 10px; text-align:right;">
        广州市增城冠达五金厂订单业务系统<a id="lnkexit" href="Logout.aspx">退出</a></div>
    <div data-options="region:'west',split:true,title:'功能导航'" style="width: 250px;">
        <div class="easyui-accordion" style="width: 100%; height: 100%;">

            <div title="客户信息" data-options="iconCls:'icon-ok'" id="Div1" visible="false" runat="server">
                <ul class="easyui-tree">
                    <li id="Div1_li1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('客户列表','information/InformationManager.aspx?itype=36')">
                        客户列表</a></li>
                    <li id="Div1_li2" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('新增客户','information/InformationManager.aspx?itype=28')">
                        新增客户</a></li>
                </ul>
            </div>

            <div title="订单信息" data-options="iconCls:'icon-ok',selected:true" style="overflow: auto;" id="Div2" visible="false" runat="server">
                <ul class="easyui-tree">
                    <li id="Div2_li1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('客户订单','shop/ProductManager.aspx')">
                        客户订单</a></li>
                    <li id="Div2_li2" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('订单列表','shop/AddProduct.aspx')">
                        订单列表</a></li>
                    <li id="Div2_li3" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('新增订单','shop/AddProduct.aspx')">
                        新增订单</a></li>
                </ul>
            </div>

            <div title="综合信息" data-options="iconCls:'icon-ok'" style="overflow: auto;" id="Div3" visible="false" runat="server">
                <ul class="easyui-tree">
                    <li id="Div3_li1" visible="false" runat="server"><span>统计信息</span>
                        <ul>
                            <li id="Div3_li1_1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('订单统计','shop/ProductManager.aspx')">
                                订单统计</a></li>
                        </ul>
                    </li>
                    <li id="Div3_li2" visible="false" runat="server"><span>历史信息</span>
                        <ul>
                            <li id="Div3_li2_1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('历史客户','shop/ProductManager.aspx')">
                                历史客户</a></li>
                            <li id="Div3_li2_2" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('历史订单','shop/ProductManager.aspx')">
                                历史订单</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            
            
            <div title="系统管理" data-options="iconCls:'icon-ok'" id="Div4" visible="false" runat="server">
                <ul class="easyui-tree">
                    <li id="Div4_li1" runat="server"><span>组织结构</span>
                        <ul>
                            <li id="Div4_li1_1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('部门设置','SystemSet/BM_Manager.aspx')">
                                部门设置</a></li>
                            <li id="Div4_li1_2" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('员工账号','shop/ProductManager.aspx')">
                                员工账号</a></li>
                            <li id="Div4_li1_3" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('添加账号','shop/AddProduct.aspx')">
                                添加账号</a></li>
                        </ul>
                    </li>
                    <li id="Div4_li2" visible="false" runat="server"><span>权限设置</span>
                        <ul>
                            <li id="Div4_li2_1" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('角色','Notice/NoticeManager.aspx')">
                                角色权限</a></li>
                        </ul>
                     </li>
                     <li id="Div4_li3" visible="false" runat="server"><a href="javascript:;" onclick="addPagePanel('公告信息','Notice/NoticeManager.aspx')">
                                公告信息</a>
                     </li>
                </ul>
            </div>
        </div>
    </div>
    <div data-options="region:'south',border:false" style="height: 50px; background: #CBFCEF;
        padding: 10px; text-align:center; line-height:30px;">
        广州市增城冠达五金厂订单业务系统</div>
    <div data-options="region:'center',title:'我的工作台'">
        <div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width: 100%;
            height: 100%">
            <div title="主页" style="padding:10px;">
			    <iframe scrolling="yes" frameborder="0"  src="Index.aspx" style="width:100%;height:100%;"></iframe>
		    </div>
        </div>
    </div>
</body>
</html>
