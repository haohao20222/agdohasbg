/*
后期部署脚本模板							
--------------------------------------------------------------------------------------
 此文件包含将附加到生成脚本中的 SQL 语句。		
 使用 SQLCMD 语法将文件包含到后期部署脚本中。			
 示例:      :r .\myfile.sql								
 使用 SQLCMD 语法引用后期部署脚本中的变量。		
 示例:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
--权限
insert into [Yo_Jurisdiction]
values (N'客户信息_客户列表',N'客户信息_客户列表',N'客户信息_客户列表',0)

insert into [Yo_Jurisdiction]
values (N'客户信息_新增客户',N'客户信息_新增客户',N'客户信息_新增客户',0)

insert into [Yo_Jurisdiction]
values (N'订单信息_客户订单',N'订单信息_客户订单',N'订单信息_客户订单',0)

insert into [Yo_Jurisdiction]
values (N'订单信息_订单列表',N'订单信息_订单列表',N'订单信息_订单列表',0)

insert into [Yo_Jurisdiction]
values (N'订单信息_新增订单',N'订单信息_新增订单',N'订单信息_新增订单',0)

insert into [Yo_Jurisdiction]
values (N'综合信息_统计信息_订单统计',N'综合信息_统计信息_订单统计',N'综合信息_统计信息_订单统计',0)

insert into [Yo_Jurisdiction]
values (N'综合信息_历史信息_历史客户',N'综合信息_历史信息_历史客户',N'综合信息_历史信息_历史客户',0)

insert into [Yo_Jurisdiction]
values (N'综合信息_历史信息_历史订单',N'综合信息_历史信息_历史订单',N'综合信息_历史信息_历史订单',0)

insert into [Yo_Jurisdiction]
values (N'系统管理_组织结构_部门设置',N'系统管理_组织结构_部门设置',N'系统管理_组织结构_部门设置',0)

insert into [Yo_Jurisdiction]
values (N'系统管理_组织结构_员工账号',N'系统管理_组织结构_员工账号',N'系统管理_组织结构_员工账号',0)

insert into [Yo_Jurisdiction]
values (N'系统管理_组织结构_添加账号',N'系统管理_组织结构_添加账号',N'系统管理_组织结构_添加账号',0)

insert into [Yo_Jurisdiction]
values (N'系统管理_权限设置_角色权限',N'系统管理_权限设置_角色权限',N'系统管理_权限设置_角色权限',0)

insert into [Yo_Jurisdiction]
values (N'系统管理_公告信息',N'系统管理_公告信息',N'系统管理_公告信息',0)

--组织
insert into [Yo_Organize]
values (0,N'广州市增城冠达五金厂',N'总公司')

--用户
insert into Yo_User
values ('admin','e10adc3949ba59abbe56e057f20f883e',0,'admin','',GETDATE(),'',0,GETDATE(),0,'','1')

--角色权限
insert into [Yo_Role]
values (N'系统管理员','1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20',N'系统管理员')
