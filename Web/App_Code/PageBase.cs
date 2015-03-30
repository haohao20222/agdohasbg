using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Maticsoft.Model;
using System.Text;
using Maticsoft.Common;
using Maticsoft.BLL;

/// <summary>
///BasePage 的摘要说明
/// </summary>
public class BasePage : System.Web.UI.Page
{
    /// <summary>
    /// 登陆用户
    /// </summary>
    public Yo_User MyUser;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        if (!string.IsNullOrEmpty(Tool.CookieGet("YoUserID")))
        {
            MyUser = Yo_UserBLL.GetModel( Convert.ToInt32(Tool.CookieGet("YoUserID")));
            if (MyUser.IsLock)
            {
                Response.Redirect("~/LogOut.aspx");
            }
        }
        else
        {
            if (Request.Url.ToString().ToLower().Contains("logout.aspx"))
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                Response.Redirect("/Login.aspx?url=" + Request.Url.ToString());
            }
        }
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
    }
}
