<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using Maticsoft.Common;
using Maticsoft.Common.DEncrypt;
using Maticsoft.Model;
using Maticsoft.BLL;
using System.Text;
using System.Collections.Generic;

public class Handler : YoHandler
{
    //获取部门列表
    public void GetBMDataList(HttpContext context)
    {
        int total = Yo_OrganizeBLL.GetRecordCount("");

        StringBuilder sb = new StringBuilder();
        sb.Append("{\"total\":" + total + ",\"rows\":[");

        List<Yo_Organize> yOrganizeList = Yo_OrganizeBLL.GetModelList("");
        foreach (Yo_Organize oItem in yOrganizeList)
        {
            sb.Append("{\"id\":" + oItem.ID + ",\"name\":\"" + oItem.OrganizeName + "\",\"note\":\"" + oItem.Note + "\",\"_parentId\":" + oItem.FatherOrganize + "},");

        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append("]}");
        context.Response.Write(sb.ToString());
    }
    //新建部门
    public void AppendBM(HttpContext context)
    {
        int fid = 0;
        int.TryParse(context.Request["fid"], out fid);

        Yo_Organize oitem = new Yo_Organize();
        oitem.OrganizeName = "新建部门";
        oitem.Note = "";
        oitem.FatherOrganize = fid;


        int id = Yo_OrganizeBLL.Add(oitem);
        oitem = Yo_OrganizeBLL.GetModel(id);
        if (oitem != null)
        {
            context.Response.Write("{\"flag\":\"true\",\"msg\":\"新建部门成功\",\"item\":{\"id\":" + oitem.ID + ",\"name\":\"" + oitem.OrganizeName + "\",\"note\":\"" + oitem.Note + "\",\"fid\":" + oitem.FatherOrganize + "}}");
            return;
        }
        else
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"新建部门失败\"}");
            return;
        }
    }
}