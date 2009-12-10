use master

GO

CREATE DATABASE si2 
ON  PRIMARY ( NAME = N'si2'    , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\si2.mdf'    , SIZE = 3072KB , FILEGROWTH = 1024KB )
LOG ON      ( NAME = N'si2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log\si2_log.ldf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'si2', @new_cmptlevel=90


GO 

use master

ALTER DATABASE si2 ADD FILEGROUP si2DataFileGroup
ALTER DATABASE si2 ADD FILEGROUP si2IndexFileGroup

ALTER DATABASE si2 ADD FILE  ( 
                                         NAME       = si2data
                                        ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\si2data.ndf'
                                        ,SIZE       = 5MB
                                        ,FILEGROWTH = 25MB 
                                  )  TO FILEGROUP [si2DataFileGroup];  

ALTER DATABASE si2 ADD FILE  (  
                                      NAME       = si2index
                                     ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\si2index.ndf'
                                     ,SIZE       = 5MB
                                     ,FILEGROWTH = 25MB 
                                   )  TO FILEGROUP [si2IndexFileGroup];  



GO


