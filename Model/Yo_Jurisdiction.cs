using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Yo_Jurisdiction:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Yo_Jurisdiction
	{
		public Yo_Jurisdiction()
		{}
		#region Model
		private int _id;
		private string _jurisdictionname;
		private string _note;
		private string _actionname;
		private bool _islock;
		/// <summary>
		/// 
		/// </summary>
		public int ID
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 权限名称
		/// </summary>
		public string JurisdictionName
		{
			set{ _jurisdictionname=value;}
			get{return _jurisdictionname;}
		}
		/// <summary>
		/// 权限说明
		/// </summary>
		public string Note
		{
			set{ _note=value;}
			get{return _note;}
		}
		/// <summary>
		/// 操作名称
		/// </summary>
		public string ActionName
		{
			set{ _actionname=value;}
			get{return _actionname;}
		}
		/// <summary>
		/// 是否锁定，锁定后改权限无法使用
		/// </summary>
		public bool IsLock
		{
			set{ _islock=value;}
			get{return _islock;}
		}
		#endregion Model

	}
}

