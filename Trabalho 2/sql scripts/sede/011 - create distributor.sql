use master
go
exec master..sp_adddistributor    @distributor=SNT_WKS02, @password = ''
go
exec master..sp_adddistributiondb @database='sede_distribution', @data_folder='C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data', @log_folder='C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data', @log_file_size = 2, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
go
use [sede_distribution] 
if (not exists (select * from sysobjects where name = 'UIProperties' and type = 'U ')) 
	create table UIProperties(id int) 
if (exists (select * from ::fn_listextendedproperty('SnapshotFolder', 'user', 'dbo', 'table', 'UIProperties', null, null))) 
	EXEC sp_updateextendedproperty N'SnapshotFolder', N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\ReplData', 'user', dbo, 'table', 'UIProperties' 
else 
	EXEC sp_addextendedproperty N'SnapshotFolder', 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\ReplData', 'user', dbo, 'table', 'UIProperties'
