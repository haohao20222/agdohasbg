using System;
namespace Maticsoft.Model
{
	/// <summary>
	/// Yo_User:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public partial class Yo_User
	{
		public Yo_User()
		{}
		#region Model
		private int _id;
		private string _username;
		private string _userpassword;
		private bool _islock;
		private string _readname;
		private string _phone;
		private DateTime _creattime;
		private string _creator;
		private int _creatorid;
		private DateTime _lastlogintime;
		private int _organizeid;
		private string _organizename;
		private string _roleidlist;
		/// <summary>
		/// 
		/// </summary>
		public int ID
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 用户名
		/// </summary>
		public string UserName
		{
			set{ _username=value;}
			get{return _username;}
		}
		/// <summary>
		/// 用户密码
		/// </summary>
		public string UserPassword
		{
			set{ _userpassword=value;}
			get{return _userpassword;}
		}
		/// <summary>
		/// 锁定（锁定后不能登录）
		/// </summary>
		public bool IsLock
		{
			set{ _islock=value;}
			get{return _islock;}
		}
		/// <summary>
		/// 真实姓名
		/// </summary>
		public string ReadName
		{
			set{ _readname=value;}
			get{return _readname;}
		}
		/// <summary>
		/// 联系方式
		/// </summary>
		public string Phone
		{
			set{ _phone=value;}
			get{return _phone;}
		}
		/// <summary>
		/// 创建时间
		/// </summary>
		public DateTime CreatTime
		{
			set{ _creattime=value;}
			get{return _creattime;}
		}
		/// <summary>
		/// 创建者
		/// </summary>
		public string Creator
		{
			set{ _creator=value;}
			get{return _creator;}
		}
		/// <summary>
		/// 创建者ID
		/// </summary>
		public int CreatorID
		{
			set{ _creatorid=value;}
			get{return _creatorid;}
		}
		/// <summary>
		/// 最后登录时间
		/// </summary>
		public DateTime LastLoginTime
		{
			set{ _lastlogintime=value;}
			get{return _lastlogintime;}
		}
		/// <summary>
		/// 所在组织ID
		/// </summary>
		public int OrganizeID
		{
			set{ _organizeid=value;}
			get{return _organizeid;}
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
		/// 角色ID列表
		/// </summary>
		public string RoleIDList
		{
			set{ _roleidlist=value;}
			get{return _roleidlist;}
		}
		#endregion Model

	}
}

