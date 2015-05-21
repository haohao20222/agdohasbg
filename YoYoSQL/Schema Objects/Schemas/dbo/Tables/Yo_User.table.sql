CREATE TABLE [dbo].[Yo_User]
(
	ID int identity(1,1) primary key,
	UserName nvarchar(50) not NULL,
	UserPassword nvarchar(50) not NULL,
	IsLock bit not null,
	ReadName nvarchar(50) not NULL,
	Phone nvarchar(50) not NULL,
	CreatTime datetime not null,
	Creator nvarchar(50) not NULL,
	CreatorID int not null,
	LastLoginTime datetime not null,
	OrganizeID int not null,
	OrganizeName nvarchar(50) not NULL,
	RoleIDList nvarchar(200) not NULL,
)


--		private int _id;
--		private string _username;
--		private string _userpassword;
--		private bool _islock;
--		private string _readname;
--		private string _phone;
--		private DateTime _creattime;
--		private string _creator;
--		private int _creatorid;
--		private DateTime _lastlogintime;
--		private int _organizeid;
--		private string _organizename;
--		private string _roleidlist;