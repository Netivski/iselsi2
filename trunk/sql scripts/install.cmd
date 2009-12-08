sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dmaster  -i"001 - create database.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"002 - user types.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"003 - tables.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"004 - views.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"005 - functions.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"006 - index.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"007 - stored procedures.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"008 - data.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"009 - Create User.sql"
sqlcmd.exe -E -S"SNT_WKS02\SQLEXPRESS" -dsi2     -i"010 - grantuser.sql"


@pause