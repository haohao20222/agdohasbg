CREATE TABLE [dbo].[Yo_Organize]
(
	ID int identity(1,1) primary key,
	FatherOrganize int not NULL,
	OrganizeName nvarchar(50) not NULL,
	Note nvarchar(50) not NULL,
)
