<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Basic Combo - jQuery EasyUI Demo</title>
	    <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.1/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.4.1/themes/icon.css" />
    
    <script type="text/javascript" src="../jquery-easyui-1.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="../jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
</head>
<body>
	<h2>Load Dynamic ComboBox Data</h2>
	<p>Drop down the panel and select multiple items.</p>
	<div style="margin:20px 0"></div>
    
	<input class="easyui-combobox" 
			name="language"
			data-options="
					url:'combobox_data1.json',
					method:'get',
					valueField:'id',
					textField:'text',
					multiple:true,
					panelHeight:'auto'
			">

</body>
</html>