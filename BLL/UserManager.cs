using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Maticsoft.Model;

namespace Maticsoft.BLL
{
    public static class UserManager
    {
        /// <summary>
        /// 获取权限ID列表
        /// </summary>
        public static string GetJurisdictionIDList(Yo_User user)
        {
            List<Yo_Role> rList = Yo_RoleBLL.GetModelList("ID in (" + GetRoleIDList(user) + ")");

            string result = "";

            if (rList.Count <= 0)
            {
                return result;
            }
            else
            {
                foreach (Yo_Role rItem in rList)
                {
                   result += "," + rItem.JurisdictionIDList.Trim(',');
                }
                return result.Trim(',');
            }

        }
        public static List<Yo_Jurisdiction> GetJurisdictionList(string jurisdictionIDList)
        {
            List<Yo_Jurisdiction> result = Yo_JurisdictionBLL.GetModelList("ID IN (" + jurisdictionIDList + ")");
            return result;
        }
        /// <summary>
        /// 获取角色ID列表
        /// </summary>
        public static string GetRoleIDList(Yo_User user)
        {
            if (user == null)
            {
                return "";
            }
            else
            {
                return user.RoleIDList.Trim(',');
            }
        }
    }
}
