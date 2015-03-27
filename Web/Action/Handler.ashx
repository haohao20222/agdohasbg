<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : YoHandler
{

    public void LoginUser(HttpContext context)
    {
        context.Response.Write("{\"flag\":\"false\",\"msg\":\"未实现！\"}"); 
    }

}