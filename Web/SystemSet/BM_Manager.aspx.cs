using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;

public partial class SystemSet_BM_Manager : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        string yoJIDList = "," + Tool.CookieGet("YoJurisdictionList") + ",";
        if (!yoJIDList.Contains(",11,"))
            Response.Redirect("~/ErrorPage.aspx");
    }
}