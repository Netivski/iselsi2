use sede

go


print 'Create Procedure u_sp_lkMoeda_add'
go
create proc dbo.u_sp_lkMoeda_add @nome char(3), @nomeLongo TTxt50, @valorReferencia decimal(10, 5)
as
  insert into lkMoeda( nome ,nomeLongo ,valorReferencia ) values( @nome, @nomeLongo, @valorReferencia  )


print 'Create Procedure u_sp_produto_add'
go
create proc dbo.u_sp_produto_add @nome TTxt50, @prazo smallint, @periodicidade TPeriodicidade, @taeg TTaxa, @tipoProduto TTipoProduto
as
  insert into produto( nome, prazo, periodicidade, taeg, tipoProduto ) 
               values( @nome, @prazo, @periodicidade, @taeg, @tipoProduto)

  return @@identity


go


print 'Create Procedure u_sp_produtotaeg_add'
go
create proc dbo.u_sp_produtotaeg_add @idProduto TIdentificador, @limiteInferior decimal(6, 3), @limiteSuperior decimal(6, 3), @taeg TTaxa
as 
  insert into produtotaeg( idProduto, limiteInferior, limiteSuperior, taeg )
                   values( @idProduto, @limiteInferior, @limiteSuperior, @taeg )

  return @@identity


go

print 'Create Procedure u_sp_lkmarca_add'
go
create proc dbo.u_sp_lkmarca_add @nome TTxt50
as
  insert into lkmarca( nome ) values( @nome )
  return @@identity


go
print 'Create Procedure u_sp_lktipocontacto_add'
go
create proc dbo.u_sp_lktipocontacto_add @nome TTxt50, @descricao TTxt100
as 
  insert into lktipocontacto( nome, descricao )
                      values( @nome, @descricao )

  return @@identity

go


go
print 'Create Procedure u_sp_throwError '
go

create proc dbo.u_sp_throwError 
as
  declare @errorMessage varchar(max)
  declare @errorSeverity int
  declare @errorState    int

  set @errorMessage  = ERROR_MESSAGE()
  set @errorSeverity = ERROR_SEVERITY()
  set @errorState    = ERROR_STATE()

     RAISERROR(@errorMessage, @errorSeverity, @errorState) WITH LOG 


go

print 'Create Procedure u_sp_balcao_drop_link'
go

create proc dbo.u_sp_balcao_drop_link @nome sysname
as
  exec master.dbo.sp_dropserver @server=@nome, @droplogins='droplogins'

go

print 'Create Procedure u_sp_balcao_add_link '
go

create proc dbo.u_sp_balcao_add_link @nome sysname, @servername sysname, @dbname sysname, @remoteusername sysname, @remoteuserpwd sysname
as
  exec master.dbo.sp_addlinkedserver @server=@nome, @srvproduct='data link', @provider='sqloledb', @datasrc=@servername, @catalog=@dbname
  -- Link Options
  exec master.dbo.sp_serveroption @server=@nome, @optname='collation compatible', @optvalue='false'
  exec master.dbo.sp_serveroption @server=@nome, @optname='data access'         , @optvalue='true'
  exec master.dbo.sp_serveroption @server=@nome, @optname='rpc'                 , @optvalue='false'
  exec master.dbo.sp_serveroption @server=@nome, @optname='rpc out'             , @optvalue='false'
  exec master.dbo.sp_serveroption @server=@nome, @optname='connect timeout'     , @optvalue='0'
  exec master.dbo.sp_serveroption @server=@nome, @optname='collation name'      , @optvalue=null
  exec master.dbo.sp_serveroption @server=@nome, @optname='query timeout'       , @optvalue='0'  
  exec master.dbo.sp_serveroption @server=@nome, @optname='use remote collation', @optvalue='true'
  exec master.dbo.sp_addlinkedsrvlogin @rmtsrvname = @nome, @locallogin = null , @useself = 'false', @rmtuser = @remoteusername, @rmtpassword = @remoteuserpwd

go

print 'Create Procedure u_sp_balcao_create '
go
create proc dbo.u_sp_balcao_create @nome sysname, @servername sysname, @dbname sysname, @remoteusername sysname, @remoteuserpwd sysname
as
   --Nota t�cnica - a adi��o do linked server n�o pode ser feita em contexto transaccional 
   if exists( select 1 from balcao where nome = @nome )
    begin
      RAISERROR('O balc�o j� existe no sistema.', 1, 2) WITH LOG
      return
    end

   begin try
        insert into balcao( Nome, ServerName, DbName, RemoteUserName, RemoteUserPwd )  values( @Nome, @ServerName, @dbname, @RemoteUserName, @RemoteUserPwd )              
   end try
   begin catch     
     exec u_sp_throwError
     return
   end catch

   begin try
     exec u_sp_balcao_add_link @Nome, @ServerName, @dbname, @RemoteUserName, @RemoteUserPwd     
   end try
   begin catch
     delete balcao where nome = @Nome
     exec u_sp_throwError      
   end catch


  
go

print 'Create Procedure u_sp_balcao_delete '
go
create proc dbo.u_sp_balcao_delete @nome sysname
as
   begin try
        delete balcao where nome = @Nome
        exec u_sp_balcao_drop_link @nome
   end try
   begin catch     
     exec u_sp_throwError     
   end catch
  
go

