declare @username varchar(50)
declare @dbname varchar(50)
declare @ObjectName sysname
declare @ObjectType varchar(15)

DECLARE crsusers CURSOR FOR 
  SELECT 'si2', 'si2'
  union 
  SELECT 'si2', 'si2'
OPEN crsusers
FETCH NEXT FROM crsusers INTO @username, @dbname
  WHILE @@FETCH_STATUS = 0
    BEGIN

     execute( 'use ' + @dbname  )

DECLARE crs CURSOR FOR 
  SELECT name 
         from sysobjects 
         where type = 'u'
OPEN crs
FETCH NEXT FROM crs INTO @ObjectName
  WHILE @@FETCH_STATUS = 0
    BEGIN 
      PRINT 'grant select on ' + @ObjectName + ' to ' + @username 
      EXECUTE( 'grant select on ' + @ObjectName + ' to  ' + @username  )
      FETCH NEXT FROM crs INTO @ObjectName
    END
CLOSE crs
DEALLOCATE crs


DECLARE crs CURSOR FOR 
  SELECT name 
         from sysobjects 
         where type = 'p'
OPEN crs
FETCH NEXT FROM crs INTO @ObjectName
  WHILE @@FETCH_STATUS = 0
    BEGIN
      PRINT 'grant execute on ' + @ObjectName + ' to ' + @username
      EXECUTE( 'grant execute on ' + @ObjectName + ' to '  + @username)
      FETCH NEXT FROM crs INTO @ObjectName
    END
CLOSE crs
DEALLOCATE crs


DECLARE crs CURSOR FOR 
  SELECT name 
         from sysobjects 
         where type = 'v'
OPEN crs
FETCH NEXT FROM crs INTO @ObjectName
  WHILE @@FETCH_STATUS = 0
    BEGIN
      PRINT 'grant select on ' + @ObjectName + ' to ' + @username 
      EXECUTE( 'grant select on ' + @ObjectName + ' to '  + @username)
      FETCH NEXT FROM crs INTO @ObjectName
    END
CLOSE crs
DEALLOCATE crs

DECLARE crs CURSOR FOR 
  SELECT name 
         from sysobjects 
         where type = 'fn'
OPEN crs
FETCH NEXT FROM crs INTO @ObjectName
  WHILE @@FETCH_STATUS = 0
    BEGIN
      PRINT 'grant execute on ' + @ObjectName + ' to ' + @username 
      EXECUTE( 'grant execute on ' + @ObjectName + ' to '  + @username)
      FETCH NEXT FROM crs INTO @ObjectName
    END
CLOSE crs
DEALLOCATE crs




      FETCH NEXT FROM crsusers INTO @username, @dbname
    END
CLOSE crsusers
DEALLOCATE crsusers





