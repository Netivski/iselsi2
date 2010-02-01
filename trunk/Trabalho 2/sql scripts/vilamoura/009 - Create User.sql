USE [master]
GO
CREATE LOGIN [vilamoura] WITH PASSWORD=N'vilamoura.', DEFAULT_DATABASE=[vilamoura], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [vilamoura]
GO
CREATE USER [vilamoura] FOR LOGIN [vilamoura]
GO
