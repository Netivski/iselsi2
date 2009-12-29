use master

GO

CREATE DATABASE sede 
ON  PRIMARY ( NAME = N'sede'    , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sede.mdf'    , SIZE = 3072KB , FILEGROWTH = 1024KB )
LOG ON      ( NAME = N'sede_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log\sede_log.ldf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'sede', @new_cmptlevel=90


GO 

use master

ALTER DATABASE sede ADD FILEGROUP sedeDataFileGroup
ALTER DATABASE sede ADD FILEGROUP sedeIndexFileGroup

ALTER DATABASE sede ADD FILE  ( 
                                         NAME       = sededata
                                        ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sededata.ndf'
                                        ,SIZE       = 5MB
                                        ,FILEGROWTH = 25MB 
                                  )  TO FILEGROUP [sedeDataFileGroup];  

ALTER DATABASE sede ADD FILE  (  
                                      NAME       = sedeindex
                                     ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sedeindex.ndf'
                                     ,SIZE       = 5MB
                                     ,FILEGROWTH = 25MB 
                                   )  TO FILEGROUP [sedeIndexFileGroup];  



GO


