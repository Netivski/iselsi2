USE [master]
GO
CREATE LOGIN [si2] WITH PASSWORD=N'si2.', DEFAULT_DATABASE=[si2], DEFAULT_LANGUAGE=[PortuguÍs], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [si2]
GO
CREATE USER [si2] FOR LOGIN [si2]
GO
