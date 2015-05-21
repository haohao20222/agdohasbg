CREATE TABLE [dbo].[Yo_Jurisdiction]
(
	ID int identity(1,1) primary key,
	JurisdictionName nvarchar(50) not NULL,
	Note nvarchar(50) not NULL,
	ActionName nvarchar(50) not NULL,
	IsLock bit not null
)
