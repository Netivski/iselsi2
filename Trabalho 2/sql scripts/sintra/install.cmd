
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dmaster  -i"001 - create database.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dmaster  -i"009 - Create User.sql"

FOR /f "tokens=*" %%G IN ('dir /b ..\balcao\*.sql') DO (
  sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsintra  -i"..\balcao\%%G")


sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsintra  -i"010 - grantuser.sql"

