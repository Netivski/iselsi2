FOR /f "tokens=*" %%G IN ('dir /b *.sql') DO (
  sqlcmd.exe -E -S"DST01W30" -dmaster  -i"%%G")