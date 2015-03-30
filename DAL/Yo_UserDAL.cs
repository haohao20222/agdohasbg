using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Maticsoft.DAL
{
	/// <summary>
	/// 数据访问类:Yo_User
	/// </summary>
	public partial class Yo_UserDAL
	{
		public Yo_UserDAL()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("ID", "Yo_User"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int ID)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Yo_User");
			strSql.Append(" where ID=@ID");
			SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)
			};
			parameters[0].Value = ID;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Maticsoft.Model.Yo_User model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Yo_User(");
			strSql.Append("UserName,UserPassword,IsLock,ReadName,Phone,CreatTime,Creator,CreatorID,LastLoginTime,OrganizeID,OrganizeName,RoleIDList)");
			strSql.Append(" values (");
			strSql.Append("@UserName,@UserPassword,@IsLock,@ReadName,@Phone,@CreatTime,@Creator,@CreatorID,@LastLoginTime,@OrganizeID,@OrganizeName,@RoleIDList)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@UserName", SqlDbType.NVarChar,50),
					new SqlParameter("@UserPassword", SqlDbType.NVarChar,50),
					new SqlParameter("@IsLock", SqlDbType.Bit,1),
					new SqlParameter("@ReadName", SqlDbType.NVarChar,50),
					new SqlParameter("@Phone", SqlDbType.NVarChar,50),
					new SqlParameter("@CreatTime", SqlDbType.DateTime),
					new SqlParameter("@Creator", SqlDbType.NVarChar,50),
					new SqlParameter("@CreatorID", SqlDbType.Int,4),
					new SqlParameter("@LastLoginTime", SqlDbType.DateTime),
					new SqlParameter("@OrganizeID", SqlDbType.Int,4),
					new SqlParameter("@OrganizeName", SqlDbType.NVarChar,50),
					new SqlParameter("@RoleIDList", SqlDbType.NVarChar,500)};
			parameters[0].Value = model.UserName;
			parameters[1].Value = model.UserPassword;
			parameters[2].Value = model.IsLock;
			parameters[3].Value = model.ReadName;
			parameters[4].Value = model.Phone;
			parameters[5].Value = model.CreatTime;
			parameters[6].Value = model.Creator;
			parameters[7].Value = model.CreatorID;
			parameters[8].Value = model.LastLoginTime;
			parameters[9].Value = model.OrganizeID;
			parameters[10].Value = model.OrganizeName;
			parameters[11].Value = model.RoleIDList;

			object obj = DbHelperSQL.GetSingle(strSql.ToString(),parameters);
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Maticsoft.Model.Yo_User model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Yo_User set ");
			strSql.Append("UserName=@UserName,");
			strSql.Append("UserPassword=@UserPassword,");
			strSql.Append("IsLock=@IsLock,");
			strSql.Append("ReadName=@ReadName,");
			strSql.Append("Phone=@Phone,");
			strSql.Append("CreatTime=@CreatTime,");
			strSql.Append("Creator=@Creator,");
			strSql.Append("CreatorID=@CreatorID,");
			strSql.Append("LastLoginTime=@LastLoginTime,");
			strSql.Append("OrganizeID=@OrganizeID,");
			strSql.Append("OrganizeName=@OrganizeName,");
			strSql.Append("RoleIDList=@RoleIDList");
			strSql.Append(" where ID=@ID");
			SqlParameter[] parameters = {
					new SqlParameter("@UserName", SqlDbType.NVarChar,50),
					new SqlParameter("@UserPassword", SqlDbType.NVarChar,50),
					new SqlParameter("@IsLock", SqlDbType.Bit,1),
					new SqlParameter("@ReadName", SqlDbType.NVarChar,50),
					new SqlParameter("@Phone", SqlDbType.NVarChar,50),
					new SqlParameter("@CreatTime", SqlDbType.DateTime),
					new SqlParameter("@Creator", SqlDbType.NVarChar,50),
					new SqlParameter("@CreatorID", SqlDbType.Int,4),
					new SqlParameter("@LastLoginTime", SqlDbType.DateTime),
					new SqlParameter("@OrganizeID", SqlDbType.Int,4),
					new SqlParameter("@OrganizeName", SqlDbType.NVarChar,50),
					new SqlParameter("@RoleIDList", SqlDbType.NVarChar,500),
					new SqlParameter("@ID", SqlDbType.Int,4)};
			parameters[0].Value = model.UserName;
			parameters[1].Value = model.UserPassword;
			parameters[2].Value = model.IsLock;
			parameters[3].Value = model.ReadName;
			parameters[4].Value = model.Phone;
			parameters[5].Value = model.CreatTime;
			parameters[6].Value = model.Creator;
			parameters[7].Value = model.CreatorID;
			parameters[8].Value = model.LastLoginTime;
			parameters[9].Value = model.OrganizeID;
			parameters[10].Value = model.OrganizeName;
			parameters[11].Value = model.RoleIDList;
			parameters[12].Value = model.ID;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int ID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Yo_User ");
			strSql.Append(" where ID=@ID");
			SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)
			};
			parameters[0].Value = ID;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/// <summary>
		/// 批量删除数据
		/// </summary>
		public bool DeleteList(string IDlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Yo_User ");
			strSql.Append(" where ID in ("+IDlist + ")  ");
			int rows=DbHelperSQL.ExecuteSql(strSql.ToString());
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Maticsoft.Model.Yo_User GetModel(int ID)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 ID,UserName,UserPassword,IsLock,ReadName,Phone,CreatTime,Creator,CreatorID,LastLoginTime,OrganizeID,OrganizeName,RoleIDList from Yo_User ");
			strSql.Append(" where ID=@ID");
			SqlParameter[] parameters = {
					new SqlParameter("@ID", SqlDbType.Int,4)
			};
			parameters[0].Value = ID;

			Maticsoft.Model.Yo_User model=new Maticsoft.Model.Yo_User();
			DataSet ds=DbHelperSQL.Query(strSql.ToString(),parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				return DataRowToModel(ds.Tables[0].Rows[0]);
			}
			else
			{
				return null;
			}
		}
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Maticsoft.Model.Yo_User GetModel(string UserName)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 ID,UserName,UserPassword,IsLock,ReadName,Phone,CreatTime,Creator,CreatorID,LastLoginTime,OrganizeID,OrganizeName,RoleIDList from Yo_User ");
            strSql.Append(" where UserName=@UserName");
            SqlParameter[] parameters = {
					new SqlParameter("@UserName", SqlDbType.NVarChar,50)
			};
            parameters[0].Value = UserName;

            Maticsoft.Model.Yo_User model = new Maticsoft.Model.Yo_User();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return DataRowToModel(ds.Tables[0].Rows[0]);
            }
            else
            {
                return null;
            }
        }


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Maticsoft.Model.Yo_User DataRowToModel(DataRow row)
		{
			Maticsoft.Model.Yo_User model=new Maticsoft.Model.Yo_User();
			if (row != null)
			{
				if(row["ID"]!=null && row["ID"].ToString()!="")
				{
					model.ID=int.Parse(row["ID"].ToString());
				}
				if(row["UserName"]!=null)
				{
					model.UserName=row["UserName"].ToString();
				}
				if(row["UserPassword"]!=null)
				{
					model.UserPassword=row["UserPassword"].ToString();
				}
				if(row["IsLock"]!=null && row["IsLock"].ToString()!="")
				{
					if((row["IsLock"].ToString()=="1")||(row["IsLock"].ToString().ToLower()=="true"))
					{
						model.IsLock=true;
					}
					else
					{
						model.IsLock=false;
					}
				}
				if(row["ReadName"]!=null)
				{
					model.ReadName=row["ReadName"].ToString();
				}
				if(row["Phone"]!=null)
				{
					model.Phone=row["Phone"].ToString();
				}
				if(row["CreatTime"]!=null && row["CreatTime"].ToString()!="")
				{
					model.CreatTime=DateTime.Parse(row["CreatTime"].ToString());
				}
				if(row["Creator"]!=null)
				{
					model.Creator=row["Creator"].ToString();
				}
				if(row["CreatorID"]!=null && row["CreatorID"].ToString()!="")
				{
					model.CreatorID=int.Parse(row["CreatorID"].ToString());
				}
				if(row["LastLoginTime"]!=null && row["LastLoginTime"].ToString()!="")
				{
					model.LastLoginTime=DateTime.Parse(row["LastLoginTime"].ToString());
				}
				if(row["OrganizeID"]!=null && row["OrganizeID"].ToString()!="")
				{
					model.OrganizeID=int.Parse(row["OrganizeID"].ToString());
				}
				if(row["OrganizeName"]!=null)
				{
					model.OrganizeName=row["OrganizeName"].ToString();
				}
				if(row["RoleIDList"]!=null)
				{
					model.RoleIDList=row["RoleIDList"].ToString();
				}
			}
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select ID,UserName,UserPassword,IsLock,ReadName,Phone,CreatTime,Creator,CreatorID,LastLoginTime,OrganizeID,OrganizeName,RoleIDList ");
			strSql.Append(" FROM Yo_User ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获得前几行数据
		/// </summary>
		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select ");
			if(Top>0)
			{
				strSql.Append(" top "+Top.ToString());
			}
			strSql.Append(" ID,UserName,UserPassword,IsLock,ReadName,Phone,CreatTime,Creator,CreatorID,LastLoginTime,OrganizeID,OrganizeName,RoleIDList ");
			strSql.Append(" FROM Yo_User ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			strSql.Append(" order by " + filedOrder);
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获取记录总数
		/// </summary>
		public int GetRecordCount(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) FROM Yo_User ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			object obj = DbHelperSQL.GetSingle(strSql.ToString());
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("SELECT * FROM ( ");
			strSql.Append(" SELECT ROW_NUMBER() OVER (");
			if (!string.IsNullOrEmpty(orderby.Trim()))
			{
				strSql.Append("order by T." + orderby );
			}
			else
			{
				strSql.Append("order by T.ID desc");
			}
			strSql.Append(")AS Row, T.*  from Yo_User T ");
			if (!string.IsNullOrEmpty(strWhere.Trim()))
			{
				strSql.Append(" WHERE " + strWhere);
			}
			strSql.Append(" ) TT");
			strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
			return DbHelperSQL.Query(strSql.ToString());
		}

		/*
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		{
			SqlParameter[] parameters = {
					new SqlParameter("@tblName", SqlDbType.VarChar, 255),
					new SqlParameter("@fldName", SqlDbType.VarChar, 255),
					new SqlParameter("@PageSize", SqlDbType.Int),
					new SqlParameter("@PageIndex", SqlDbType.Int),
					new SqlParameter("@IsReCount", SqlDbType.Bit),
					new SqlParameter("@OrderType", SqlDbType.Bit),
					new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "Yo_User";
			parameters[1].Value = "ID";
			parameters[2].Value = PageSize;
			parameters[3].Value = PageIndex;
			parameters[4].Value = 0;
			parameters[5].Value = 0;
			parameters[6].Value = strWhere;	
			return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
		}*/

		#endregion  BasicMethod
		#region  ExtensionMethod

		#endregion  ExtensionMethod
	}
}

