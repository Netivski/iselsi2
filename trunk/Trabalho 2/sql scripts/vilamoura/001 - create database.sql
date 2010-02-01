use master

GO

CREATE DATABASE vilamoura 
ON  PRIMARY ( NAME = N'vilamoura'    , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\vilamoura.mdf'    , SIZE = 3072KB , FILEGROWTH = 1024KB )
LOG ON      ( NAME = N'vilamoura_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Log\vilamoura_log.ldf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'vilamoura', @new_cmptlevel=90


GO 

use master

ALTER DATABASE vilamoura ADD FILEGROUP DataFileGroup
ALTER DATABASE vilamoura ADD FILEGROUP IndexFileGroup

ALTER DATABASE vilamoura ADD FILE  ( 
                                         NAME       = vilamouradata
                                        ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\vilamouradata.ndf'
                                        ,SIZE       = 5MB
                                        ,FILEGROWTH = 25MB 
                                  )  TO FILEGROUP [DataFileGroup];  

ALTER DATABASE vilamoura ADD FILE  (  
                                      NAME       = vilamouraindex
                                     ,FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\vilamouraindex.ndf'
                                     ,SIZE       = 5MB
                                     ,FILEGROWTH = 25MB 
                                   )  TO FILEGROUP [IndexFileGroup];  



GO


