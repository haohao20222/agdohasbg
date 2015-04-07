using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Maticsoft.BLL;
using Maticsoft.Common;
using Maticsoft.Model;

/// <summary>
///YoHandler 的摘要说明
/// </summary>
public class YoHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public Yo_User MyUser;

    public bool IsReusable { get { return false; } }


    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        
        // 反射方法
        string cmd =context.Request["cmd"];
        if (!string.IsNullOrEmpty(cmd))
        {
            if (cmd != "LoginUser")
            {
                if (!string.IsNullOrEmpty(Tool.CookieGet("YoUserID")))
                {
                    MyUser = Yo_UserBLL.GetModel(Convert.ToInt32(Tool.CookieGet("YoUserID")));
                    if (MyUser.IsLock)
                    {
                        context.Response.Write("{\"flag\":\"false\",\"msg\":\"用户被锁定。\"}");
                        return;
                    }
                }
                else
                {
                    context.Response.Write("{\"flag\":\"false\",\"msg\":\"未登录\"}");
                    return;
                }
            }
            System.Reflection.MethodInfo Remethod = this.GetType().GetMethod(cmd);
            if (Remethod != null) { Remethod.Invoke(this, new object[] { context }); }
        }
        else
        {
            context.Response.Write("{\"flag\":\"false\",\"msg\":\"非法操作\"}");
        }
    }
    /// <summary>
    /// 转义json特殊字符
    /// </summary>
    /// <param name="s"></param>
    /// <returns></returns>
    protected static string StringToJson(string s)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.Length; i++)
        {
            char c = s[i];
            switch (c)
            {
                case '\"':
                    sb.Append("\\\"");
                    break;
                case '\\':
                    sb.Append("\\\\");
                    break;
                case '/':
                    sb.Append("\\/");
                    break;
                case '\b':
                    sb.Append("\\b");
                    break;
                case '\f':
                    sb.Append("\\f");
                    break;
                case '\n':
                    sb.Append("\\n");
                    break;
                case '\r':
                    sb.Append("\\r");
                    break;
                case '\t':
                    sb.Append("\\t");
                    break;
                default:
                    sb.Append(c); break;
            }
        }
        return sb.ToString();
    }
}