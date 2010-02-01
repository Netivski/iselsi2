use master

GO

CREATE DATABASE sintra 
ON  PRIMARY ( NAME = N'sintra'    , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sintra.mdf'    , SIZE = 3072KB , FILEGROWTH = 1024KB )
LOG ON      ( NAME = N'sintra_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log\sintra_log.ldf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'sintra', @new_cmptlevel=90


GO 

use master

ALTER DATABASE sintra ADD FILEGROUP DataFileGroup
ALTER DATABASE sintra ADD FILEGROUP IndexFileGroup

ALTER DATABASE sintra ADD FILE  ( 
                                         NAME       = sintradata
                                        ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sintradata.ndf'
                                        ,SIZE       = 5MB
                                        ,FILEGROWTH = 25MB 
                                  )  TO FILEGROUP [DataFileGroup];  

ALTER DATABASE sintra ADD FILE  (  
                                      NAME       = sintraindex
                                     ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\sintraindex.ndf'
                                     ,SIZE       = 5MB
                                     ,FILEGROWTH = 25MB 
                                   )  TO FILEGROUP [IndexFileGroup];  



GO


