FOR /f "tokens=*" %%G IN ('dir /b *.sql') DO (
  sqlcmd.exe -E -S"localhost" -dmaster  -i"%%G")


@pause