using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
namespace Maticsoft.Common
{
 public class FileOperBase
    {
     /// <summary>
     /// ·��ת����ת��������·����
     /// </summary>
     /// <param name="path"></param>
     /// <returns></returns>
     public static string WebPathTran(string path)
     {
         try
         {
             return HttpContext.Current.Server.MapPath(path);
         }
         catch
         {
             return path;
         }     
     
     }

    }
}
