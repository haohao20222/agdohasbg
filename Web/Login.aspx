<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/yocss.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .login-page{ }
        .login-form{width:350px; height:200px; position:absolute; top:50%; left:50%; margin-top:-200px; margin-left:-175px;}
        .login-title{ font-size:20px; line-height:80px; text-align:center;}
        .login-form ul li{ list-style:none; }
        .login-lable{ display:block;text-align:right; width:100px; height:25px; float:left;font-size:16px; line-height:25px;margin-top:10px;}
        .login-txt{float:left; height:25px; width:190px;font-size:16px; line-height:25px;margin-top:10px;border:1px solid #CCC}
        .login-submit{float:left;margin-top:10px;font-size:16px; line-height:20px; border:1px solid #CCC; margin-left:112px; height:30px; width:80px; ;background-color:#E0ECFF;}
    </style>
    <script type="text/javascript">
        function checkInput() {
            if (document.all.UserNameTxt.value == "") {
                alert("请输入用户名")
                document.all.UserNameTxt.focus();
                return false
            }
            if (document.all.PasswordTxt.value == "") {
                alert("请输入密码");
                document.all.PasswordTxt.focus();
                return false
            }
            if (document.all.CCode.value == "") {
                alert("请输入验证码");
                document.all.CCode.focus();
                return false
            }
            return true
        }
        //重新生成验证码
        function ChangeMap(obj) {
            var obj = window.document.getElementById("codeimg");
            obj.src = "verifyimage.aspx?code=" + Math.random();
            window.document.getElementById("CCode").value = "";
        }
    </script>
</head>
<body onload="ChangeMap()">
    <form id="form1" runat="server" onsubmit="return checkInput()">
    <div class="login-page">
        <div class="login-form">
            <p class="login-title">广州市增城冠达五金厂订单业务系统</p>
            <ul>
                <li><span class="login-lable">用户：</span><input id="UserNameTxt" class="login-txt" type="text" /></li>
                <li><span class="login-lable">密码：</span><input id="PasswordTxt" class="login-txt" type="password" /></li>
                <li><span class="login-lable">密码：</span>
                    <input class="reg" maxlength="5" size="5" style="width: 60px; height: 20px; font-size: 16px;
                                        line-height: 22px; font-weight: bold;" name="CCode" id="CCode" />
                    <img id="codeimg" onclick="ChangeMap()" alt="看不清，点击更换图片。" /></li>
                <li><span class="login-lable"></span><input id="Submit1" class="login-submit" type="submit" value="登 陆" /></li>
            </ul>
        </div>
    </div>
    </form>
</body>
</html>
