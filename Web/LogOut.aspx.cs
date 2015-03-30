using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;

public partial class LogOut : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Tool.CookieRemove("YoUserID");
        Tool.CookieRemove("YoUserName");
        Tool.CookieRemove("YoRoleList");
        Tool.CookieRemove("YoJurisdictionList");
        Response.Redirect("Login.aspx");
    }
}