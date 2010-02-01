
sqlcmd.exe -E -S"DST01W30" -dmaster  -i"001 - create database.sql"
sqlcmd.exe -E -S"DST01W30" -dmaster  -i"009 - Create User.sql"

FOR /f "tokens=*" %%G IN ('dir /b ..\balcao\*.sql') DO (
  sqlcmd.exe -E -S"DST01W30" -dvilamoura  -i"..\balcao\%%G")


sqlcmd.exe -E -S"DST01W30" -dvilamoura  -i"010 - grantuser.sql"

