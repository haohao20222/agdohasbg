using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Yo_Role:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Yo_Role
	{
		public Yo_Role()
		{}
		#region Model
		private int _id;
		private string _rolename;
		private string _jurisdictionidlist;
		private string _note;
		/// <summary>
		/// 
		/// </summary>
		public int ID
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 角色名
		/// </summary>
		public string RoleName
		{
			set{ _rolename=value;}
			get{return _rolename;}
		}
		/// <summary>
		/// 权限ID列表
		/// </summary>
		public string JurisdictionIDList
		{
			set{ _jurisdictionidlist=value;}
			get{return _jurisdictionidlist;}
		}
		/// <summary>
		/// 角色说明
		/// </summary>
		public string Note
		{
			set{ _note=value;}
			get{return _note;}
		}
		#endregion Model

	}
}

