using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;

public partial class Verifyimage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string vcode = new Random().Next(1000, 9999).ToString();
        Session["CCode"] = vcode;
        Tool.CreateImage(vcode);
    }
}