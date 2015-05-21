CREATE TABLE [dbo].[Yo_Role]
(
	ID int identity(1,1) primary key,
	RoleName nvarchar(50) not NULL,
	JurisdictionIDList nvarchar(200) not NULL,
	Note nvarchar(200) not NULL,
)
