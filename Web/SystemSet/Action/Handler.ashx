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
    #region 部门处理
   
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

        if (Yo_OrganizeBLL.GetModel(fid) == null)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"请选择上级部门\"}");
            return;
        }

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
    //移除部门RemoveBM
    public void RemoveBM(HttpContext context)
    {
        int itemid = 0;
        int.TryParse(context.Request["itemid"], out itemid);

        if (itemid == 1)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"删除失败，不能删除总公司\"}");
            return;
        }

        string idList = GetChildrenBMid(itemid);

        if (Yo_OrganizeBLL.DeleteList(idList))
        {
            context.Response.Write("{\"flag\":\"true\",\"msg\":\"删除成功\"}");
            return;
        }
        else
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"删除失败\"}");
            return;
        }
    }
    //获取子部门ID
    private string GetChildrenBMid(int fid)
    {
        List<Yo_Organize> yOrganizeList = Yo_OrganizeBLL.GetModelList("FatherOrganize = " + fid);
        string cList = "";
        if (yOrganizeList.Count > 0)
        {
            foreach (Yo_Organize oItem in yOrganizeList)
            {
                cList += "," + GetChildrenBMid(oItem.ID);
            }
            return fid + "," + cList.Trim(',');
        }
        else
        {
            return fid.ToString();
        }
    }
    //编辑部门
    public void EditBM(HttpContext context)
    {
        int itemid = 0;
        int.TryParse(context.Request["itemid"], out itemid);
        string itemName = context.Request["itemname"];
        string itemNote = context.Request["itemnote"];
        Yo_Organize oItem = Yo_OrganizeBLL.GetModel(itemid);
        if(oItem==null)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"找不到记录。请刷新页面\"}");
            return;
        }
        oItem.OrganizeName = itemName;
        oItem.Note = itemNote;

        if (Yo_OrganizeBLL.Update(oItem))
        {
            context.Response.Write("{\"flag\":\"true\",\"msg\":\"修改成功\"}");
            return;
        }
        else
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"修改失败\"}");
            return;
        }
    }

    #endregion
    
    #region 角色权限处理

    //获取角色权限列表
    public void GetJSDataList(HttpContext context)
    {
        int total = Yo_RoleBLL.GetRecordCount("");

        StringBuilder sb = new StringBuilder();
        sb.Append("{\"total\":" + total + ",\"rows\":[");

        List<Yo_Role> roleList = Yo_RoleBLL.GetModelList("");
        foreach (Yo_Role rItem in roleList)
        {
            sb.Append("{\"id\":" + rItem.ID + ",\"name\":\"" + rItem.RoleName + "\",\"note\":\"" + rItem.Note + "\",\"jlist\":\"" + rItem.JurisdictionIDList + "\"},");

        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append("]}");
        context.Response.Write(sb.ToString());
    }
    
    #endregion
    
    
}