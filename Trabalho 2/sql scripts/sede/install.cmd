FOR /f "tokens=*" %%G IN ('dir /b *.sql') DO (
  sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dmaster  -i"%%G")