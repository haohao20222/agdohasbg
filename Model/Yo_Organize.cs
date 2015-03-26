using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Yo_Organize:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Yo_Organize
	{
		public Yo_Organize()
		{}
		#region Model
		private int _id;
		private int _fatherorganize;
		private string _organizename;
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
		/// 上级组织ID
		/// </summary>
		public int FatherOrganize
		{
			set{ _fatherorganize=value;}
			get{return _fatherorganize;}
		}
		/// <summary>
		/// 组织名称
		/// </summary>
		public string OrganizeName
		{
			set{ _organizename=value;}
			get{return _organizename;}
		}
		/// <summary>
		/// 组织说明
		/// </summary>
		public string Note
		{
			set{ _note=value;}
			get{return _note;}
		}
		#endregion Model

	}
}

