use master

GO

CREATE DATABASE balcao 
ON  PRIMARY ( NAME = N'balcao'    , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\balcao.mdf'    , SIZE = 3072KB , FILEGROWTH = 1024KB )
LOG ON      ( NAME = N'balcao_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log\balcao_log.ldf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'balcao', @new_cmptlevel=90


GO 

use master

ALTER DATABASE balcao ADD FILEGROUP balcaoDataFileGroup
ALTER DATABASE balcao ADD FILEGROUP balcaoIndexFileGroup

ALTER DATABASE balcao ADD FILE  ( 
                                         NAME       = balcaodata
                                        ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\balcaodata.ndf'
                                        ,SIZE       = 5MB
                                        ,FILEGROWTH = 25MB 
                                  )  TO FILEGROUP [balcaoDataFileGroup];  

ALTER DATABASE balcao ADD FILE  (  
                                      NAME       = balcaoindex
                                     ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\balcaoindex.ndf'
                                     ,SIZE       = 5MB
                                     ,FILEGROWTH = 25MB 
                                   )  TO FILEGROUP [balcaoIndexFileGroup];  



GO


