<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using Maticsoft.Common;
using Maticsoft.Common.DEncrypt;
using Maticsoft.Model;
using Maticsoft.BLL;

public class Handler : YoHandler
{

    public void LoginUser(HttpContext context)
    {
        string userName = context.Request["UserNameTxt"];
        string password = context.Request["PasswordTxt"];
        string CCode = context.Request["CCode"];

        if (context.Session["CCode"] == null)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"验证码过期\"}");
            return;
        }
        if (CCode != context.Session["CCode"].ToString())
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"验证码错误\"}");
            return;
        }
        
        Yo_User user = Yo_UserBLL.GetModel(userName);
        if (user == null)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"用户或者密码错误\"}");
            return;
        }
        if (userName != user.UserName)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"用户或者密码错误\"}");
            return;
        }
        if (HashEncode.MD5(password) != user.UserPassword)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"用户或者密码错误\"}");
            return;
        }
        if (user.IsLock)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"账号被锁定，请联系管理员解锁\"}");
            return;
        }
        
        //登陆成功记录登陆用户Cookie信息 
        Tool.CookieWrite("YoUserID", user.ID.ToString());
        Tool.CookieWrite("YoUserName", user.UserName);
        Tool.CookieWrite("YoRoleList", UserManager.GetRoleIDList(user)); 
        Tool.CookieWrite("YoJurisdictionList", UserManager.GetJurisdictionIDList(user));
        
        context.Response.Write("{\"flag\":\"true\",\"msg\":\"登陆成功\"}");
    }

}