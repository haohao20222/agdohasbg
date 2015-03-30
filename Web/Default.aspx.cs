using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.BLL;
using Maticsoft.Common;
using Maticsoft.Model;

public partial class _Default : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Yo_Jurisdiction> jList = UserManager.GetJurisdictionList(Tool.CookieGet("YoJurisdictionList"));
        foreach (Yo_Jurisdiction jItem in jList)
        {
            SetContorlVisite(jItem.ActionName);
        }
    }

    private void SetContorlVisite(string jName)
    {
        switch (jName)
        {
            case "客户信息": Div1.Visible = true; break;
            case "客户信息_客户列表": Div1_li1.Visible = true; break;
            case "客户信息_新增客户": Div1_li2.Visible = true; break;

            case "订单信息": Div2.Visible = true; break;
            case "订单信息_客户订单": Div2_li1.Visible = true; break;
            case "订单信息_订单列表": Div2_li2.Visible = true; break;
            case "订单信息_新增订单": Div2_li3.Visible = true; break;

            case "综合信息": Div3.Visible = true; break;
            case "综合信息_统计信息": Div3_li1.Visible = true; break;
            case "综合信息_统计信息_订单统计": Div3_li1_1.Visible = true; break;
            case "综合信息_历史信息": Div3_li2.Visible = true; break;
            case "综合信息_历史信息_历史客户": Div3_li2_1.Visible = true; break;
            case "综合信息_历史信息_历史订单": Div3_li2_2.Visible = true; break;

            case "系统管理": Div4.Visible = true; break;
            case "系统管理_组织结构": Div4_li1.Visible = true; break;
            case "系统管理_组织结构_部门设置": Div4_li1_1.Visible = true; break;
            case "系统管理_组织结构_员工账号": Div4_li1_2.Visible = true; break;
            case "系统管理_组织结构_添加账号": Div4_li1_3.Visible = true; break;
            case "系统管理_权限设置": Div4_li2.Visible = true; break;
            case "系统管理_权限设置_角色权限": Div4_li2_1.Visible = true; break;
            case "系统管理_公告信息": Div4_li3.Visible = true; break;
        }
    }
}