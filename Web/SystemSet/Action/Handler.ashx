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
    //获取部门树结果
    public void GetBMTree(HttpContext context)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("[");
       
        sb.Append(GetChildrenBM(0));

        sb.Append("]");
        context.Response.Write(sb.ToString());
    }
    //获取子部门
    private string GetChildrenBM(int fid)
    {
        List<Yo_Organize> yOrganizeList = Yo_OrganizeBLL.GetModelList("FatherOrganize = " + fid);
        StringBuilder sb = new StringBuilder();
        
        if (yOrganizeList.Count > 0)
        {
            int i = 0;
            foreach (Yo_Organize oItem in yOrganizeList)
            {
                if (Yo_OrganizeBLL.GetModelList("FatherOrganize = " + oItem.ID).Count <= 0)
                {
                    if (i != 0)
                    {
                        sb.Append(",");
                    }
                    sb.Append("{");
                    sb.Append("\"id\":" + oItem.ID + ",");
                    sb.Append("\"text\":\"" + oItem.OrganizeName + "\"");
                    sb.Append("}");
                }
                else
                {
                    if (i != 0)
                    {
                        sb.Append(",");
                    }
                    sb.Append("{"); 
                    sb.Append("\"id\":" + oItem.ID + ",");
                    sb.Append("\"text\":\"" + oItem.OrganizeName + "\"");
                    sb.Append(",\"children\":[");
                    sb.Append(GetChildrenBM(oItem.ID));
                    sb.Append("]");
                    sb.Append("}");
                }
                i++;
            }
            return sb.ToString();
        }
        else
        {
            return "";
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
        if (oItem == null)
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
    /* 
     * 权限控制节点编码
     * *****全部***********************************个人*********
     * 客户信息 22,23~,24~                   22,33~,34~
     * 订单信息 18,19~,20~,21~               18,29~,30~,31~
     * 订单统计 12,13,14~                    12,13,26~
     * 历史客户 12,15,16~                    12,15,27~
     * 历史订单 12,15,17~                    12,15,28~
     * *********************************************************
     * 部门设置 1,4,11~
     * 员工账号 1,4,5~,6~
     * 角色权限 1,8,9~
     * 公告信息 1,10~
     */

    //获取角色权限列表
    public void GetJSDataList(HttpContext context)
    {
        int total = Yo_RoleBLL.GetRecordCount("");

        StringBuilder sb = new StringBuilder();
        sb.Append("{\"total\":" + total + ",\"rows\":[");

        List<Yo_Role> roleList = Yo_RoleBLL.GetModelList("");
        foreach (Yo_Role rItem in roleList)
        {
            sb.Append("{\"id\":" + rItem.ID + ",\"name\":\"" + rItem.RoleName + "\",\"note\":\"" + rItem.Note + "\",");

            string jIDList = "," + rItem.JurisdictionIDList + ",";

            sb.Append("\"khself\":\"" + (jIDList.Contains(",33,") && jIDList.Contains(",34,") ? "√" : "×") + "\",");
            sb.Append("\"khall\":\"" + (jIDList.Contains(",23,") && jIDList.Contains(",24,") ? "√" : "×") + "\",");
            sb.Append("\"orderself\":\"" + (jIDList.Contains(",29,") && jIDList.Contains(",30,") && jIDList.Contains(",31,") ? "√" : "×") + "\",");
            sb.Append("\"orderall\":\"" + (jIDList.Contains(",19,") && jIDList.Contains(",20,") && jIDList.Contains(",21,") ? "√" : "×") + "\",");
            sb.Append("\"tallyself\":\"" + (jIDList.Contains(",26,") ? "√" : "×") + "\",");
            sb.Append("\"tallyall\":\"" + (jIDList.Contains(",14,") ? "√" : "×") + "\",");
            sb.Append("\"hiskhself\":\"" + (jIDList.Contains(",27,") ? "√" : "×") + "\",");
            sb.Append("\"hiskhall\":\"" + (jIDList.Contains(",16,") ? "√" : "×") + "\",");
            sb.Append("\"hisorderself\":\"" + (jIDList.Contains(",28,") ? "√" : "×") + "\",");
            sb.Append("\"hisorderall\":\"" + (jIDList.Contains(",17,") ? "√" : "×") + "\",");
            sb.Append("\"bmset\":\"" + (jIDList.Contains(",11,") ? "√" : "×") + "\",");
            sb.Append("\"employee\":\"" + (jIDList.Contains(",5,") && jIDList.Contains(",6,") ? "√" : "×") + "\",");
            sb.Append("\"role\":\"" + (jIDList.Contains(",9,") ? "√" : "×") + "\",");
            sb.Append("\"notice\":\"" + (jIDList.Contains(",10,") ? "√" : "×") + "\"},");

        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append("]}");
        context.Response.Write(sb.ToString());
    }

    //修改权限值
    public void EditJS(HttpContext context)
    {
        int itemid = 0;
        int.TryParse(context.Request["itemid"], out itemid);
        string field = context.Request["field"];
        string value = context.Request["value"];

        Yo_Role rItem = Yo_RoleBLL.GetModel(itemid);
        if (rItem == null)
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"找不到记录。请刷新页面\"}");
            return;
        }
        List<int> jidList = new List<int>();
        switch (field)
        {
            case "khself": jidList.Add(33); jidList.Add(34); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "khall": jidList.Add(23); jidList.Add(24); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "orderself": jidList.Add(29); jidList.Add(30); jidList.Add(31); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "orderall": jidList.Add(19); jidList.Add(20); jidList.Add(21); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "tallyself": jidList.Add(26); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "tallyall": jidList.Add(14); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "hiskhself": jidList.Add(27); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "hiskhall": jidList.Add(16); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "hisorderself": jidList.Add(28); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "hisorderall": jidList.Add(17); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "bmset": jidList.Add(11); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "employee": jidList.Add(5); jidList.Add(6); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "role": jidList.Add(9); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "notice": jidList.Add(10); context.Response.Write(UpdateJSRole(jidList, value, rItem)); return;
            case "name":
                {
                    rItem.RoleName = value;
                    if (Yo_RoleBLL.Update(rItem))
                    {
                        context.Response.Write("{\"flag\":\"true\",\"msg\":\"修改成功\"}");
                    }
                    else
                    {
                        context.Response.Write("{\"flag\":\"false\",\"msg\":\"数据处理失败\"}");
                    }
                    break;
                }
        }
    }

    private string UpdateJSRole(List<int> jlist, string value, Yo_Role rItem)
    {
        if (value == "√")
        {
            string jtemp = "," + rItem.JurisdictionIDList + ",";
            foreach (int j in jlist)
            {
                jtemp = jtemp.Replace("," + j.ToString() + ",", ",");
            }
            rItem.JurisdictionIDList = jtemp.Trim(',');
            if (Yo_RoleBLL.Update(rItem))
            {
                return "{\"flag\":\"true\",\"msg\":\"修改成功\"}";
            }
            else
            {
                return "{\"flag\":\"false\",\"msg\":\"数据处理失败\"}";
            }
        }
        else
        {
            string jtemp = rItem.JurisdictionIDList;
            foreach (int j in jlist)
            {
                jtemp += "," + j;
            }
            rItem.JurisdictionIDList = jtemp.Trim(',');
            if (Yo_RoleBLL.Update(rItem))
            {
                return "{\"flag\":\"true\",\"msg\":\"修改成功\"}";
            }
            else
            {
                return "{\"flag\":\"false\",\"msg\":\"数据处理失败\"}";
            }
        }
    }
    //增加角色
    public void AddJS(HttpContext context)
    {
        string value = context.Request["value"];
        Yo_Role rItem = new Yo_Role();
        rItem.RoleName = value;
        rItem.Note = "";
        rItem.JurisdictionIDList = "";
        int id = Yo_RoleBLL.Add(rItem);
        if (Yo_RoleBLL.GetModel(id) != null)
        {
            context.Response.Write("{\"flag\":\"true\",\"msg\":\"添加成功\"}");
        }
        else
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"数据处理失败\"}");
        }
    }

    //移除角色RemoveJS 
    public void RemoveJS(HttpContext context)
    {
        int itemid = 0;
        int.TryParse(context.Request["itemid"], out itemid);

        if (Yo_RoleBLL.Delete(itemid))
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
    
    //获取角色下拉数据  
    public void GetJSList(HttpContext context)
    {
        List<Yo_Role> rList = Yo_RoleBLL.GetModelList("");
        StringBuilder sb = new StringBuilder();
        sb.Append("[");
        int i = 0;
        foreach (Yo_Role rItem in rList)
        {
            if (i != 0)
            {
                sb.Append(",");
            }
            sb.Append("{");
            
            i++;
            sb.Append("[");
  //          [{
//    "id":1,
//    "text":"Java",
//    "desc":"Write once, run anywhere"
//},{
//    "id":2,
//    "text":"C#",
//    "desc":"One of the programming languages designed for the Common Language Infrastructure"
//},{
//    "id":3,
//    "text":"Ruby",
//    "selected":true,
//    "desc":"A dynamic, reflective, general-purpose object-oriented programming language"
//},{
//    "id":4,
//    "text":"Perl",
//    "desc":"A high-level, general-purpose, interpreted, dynamic programming language"
//},{
//    "id":5,
//    "text":"Basic",
//    "desc":"A family of general-purpose, high-level programming languages"
//}]
        }
    }
    
    #endregion

    #region 员工



    #endregion

}