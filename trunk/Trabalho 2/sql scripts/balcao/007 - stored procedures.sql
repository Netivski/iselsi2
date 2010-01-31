use balcao

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
print 'Create Procedure u_sp_morada_add '
go
create proc dbo.u_sp_morada_add @linha1 TTxt100, @linha2 TTxt100, @codpostal1 smallint, @codpostal2 smallint, @localidade TTxt50, @principal TFlag
as 
  insert into morada( linha1, linha2, codpostal1, codpostal2 , localidade , principal  )
              values( @linha1, @linha2, @codpostal1, @codpostal2, @localidade, @principal )

  return @@identity


go
print 'Create Procedure u_sp_titular_add '
go
create proc dbo.u_sp_titular_add @nif TNif, @nome TNome,  @IdMorada TIdentificador, @dtNascimento TDt,  @estadoCivil TEstadoCivil, @rendimentoAnual TMontante, @nib TNib, @iFinanciavel TFlag
as
  insert into titular( nif, nome, IdMorada, dtNascimento, estadoCivil, rendimentoAnual, nib, iFinanciavel )
               values( @nif, @nome, @IdMorada, @dtNascimento, @estadoCivil, @rendimentoAnual, @nib, @iFinanciavel )

go
print 'Create Procedure u_sp_titularcontacto_add '
go
create proc dbo.u_sp_titularcontacto_add @nifTitular TNif, @IdTipoContacto TIdentificador, @contacto TTxt100, @iPreferencial TFlag
as
  insert into titularcontacto( nifTitular, IdTipoContacto, contacto, iPreferencial )
                       values( @nifTitular, @IdTipoContacto, @contacto, @iPreferencial )


go
print 'Create Procedure u_sp_titular_change '
go
create proc dbo.u_sp_titular_change @nif TNif, @nome TNome,  @IdMorada TIdentificador, @dtNascimento TDt,  @estadoCivil TEstadoCivil, @rendimentoAnual TMontante, @nib TNib, @iFinanciavel TFlag
as
  update titular
  set  nome            = @nome
      ,IdMorada        = @IdMorada
      ,dtNascimento    = @dtNascimento
      ,estadoCivil     = @estadoCivil
      ,rendimentoAnual = @rendimentoAnual
      ,nib             = @nib
      ,iFinanciavel    = @iFinanciavel 
where  nif = @nif

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
print 'Create Procedure u_sp_event_create '
go
create proc dbo.u_sp_event_create @idDossier TIdentificador, @codTipEvento varchar(10)
as
  declare @rowId TIdentificador
  insert into evento( IdDossier, codTipEvento   )
              values( @idDossier, @codTipEvento )

  set @rowId  = @@identity

  insert into EventoSaldo( IdEvento, saldo, mntAntesEvento, mntDepoisEvento )
                    select @rowId, saldo, montante, 0 
                    from saldo 
                    where idDossier = @idDossier

  return  @rowId

go
print 'Create Procedure u_sp_event_terminate '
go
create proc dbo.u_sp_event_terminate @idEvent TIdentificador
as
  update eventoSaldo 
  set mntDepoisEvento = ( select montante from saldo where saldo.idDossier = e.idDossier and saldo.saldo = es.saldo )
  from eventoSaldo es, evento e
  where es.idEvento = e.idEvento 
   and  e.idEvento  = @idEvent

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
   --Nota técnica - a adição do linked server não pode ser feita em contexto transaccional 
   if exists( select 1 from balcao where nome = @nome )
    begin
      RAISERROR('O balcão já existe no sistema.', 1, 2) WITH LOG
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


--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
--                                    Implementações Especificas
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

print 'Create Procedure u_sp_titular_registar - Procedimento referente à implementação da alínea 2.a  do Trabalho'
go
create proc dbo.u_sp_titular_registar 
                                        -- Dados gerais do Titular
                                       @nif             TNif
                                      ,@nome            TNome                                     
                                      ,@dtNascimento    TDt
                                      ,@estadoCivil     TEstadoCivil
                                      ,@rendimentoAnual TMontante
                                      ,@nib             TNib
                                      -- Dados gerais da Morada 
                                      ,@linha1          TTxt100
                                      ,@linha2          TTxt100
                                      ,@codpostal1      smallint
                                      ,@codpostal2      smallint
                                      ,@localidade      TTxt50      
                                      -- Dados Gerais de Contactos
                                      ,@IdTipoContacto1 TIdentificador
                                      ,@contacto1       TTxt100
                                      ,@iPreferencial1  TFlag
                                      ,@IdTipoContacto2 TIdentificador
                                      ,@contacto2       TTxt100
                                      ,@iPreferencial2  TFlag                                  
as
  declare @IdMorada TIdentificador

   begin try
      begin transaction 
        exec @IdMorada = dbo.u_sp_morada_add @linha1, @linha2, @codpostal1, @codpostal2, @localidade, 1 
        if exists( select 1 from titular where nif = @nif  )
         exec dbo.u_sp_titular_change          @nif, @nome,  @IdMorada, @dtNascimento,  @estadoCivil, @rendimentoAnual, @nib, 1  
        else
          exec dbo.u_sp_titular_add            @nif, @nome,  @IdMorada, @dtNascimento,  @estadoCivil, @rendimentoAnual, @nib, 1 
        
        if( @IdTipoContacto1 > 0 )
          exec dbo.u_sp_titularcontacto_add    @nif , @IdTipoContacto1, @contacto1, @iPreferencial1

        if( @IdTipoContacto2 > 0 )
          exec dbo.u_sp_titularcontacto_add    @nif , @IdTipoContacto2, @contacto2, @iPreferencial2
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

go  

print 'Create Procedure u_sp_dossier_registar - Procedimento referente à implementação da alínea 2.b do Trabalho'
go
create proc dbo.u_sp_dossier_registar 
                                             @nifTitular    TNif
                                            ,@nifAvalista   TNif
                                            ,@moedaNome     char(3)
                                            ,@IdProduto     TIdentificador
                                            ,@montante      TMontante
as
  declare @prazo                      smallint           
  declare @periodicidade              TPeriodicidade       
  declare @taeg                       TTaxa 
  declare @taegCalc                   TTaxa 
  declare @tipoProduto                TTipoProduto             
  declare @txEsforco                  decimal(8, 4)
  declare @mntKVincendo               TMontante
  declare @rendimentoAnual            TMontante
  declare @avalistaRendimentoAnual    TMontante
  declare @avalistaMntDividaSolidaria TMontante      
  declare @idDossier                  TIdentificador 

  -- 001 - Calculo do produto associado ao dossier
  select  @prazo          = prazo
		 ,@periodicidade  = periodicidade
         ,@taeg           = taeg
         ,@tipoProduto    = tipoProduto
  from produto 
  where  IdProduto = @IdProduto

  if @@rowcount = 0
    begin
      RAISERROR('Produto inexistente.', 1, 2) WITH LOG
      return 
    end 

  -- 002 - Calculo da taeg aplicável, com base na taxa de esforço do titular
  select @rendimentoAnual = rendimentoAnual from titular where nif = @nifTitular
  set    @mntKVincendo    = dbo.u_f_total_creditos(@nifTitular) + @montante
  set    @txEsforco       = dbo.u_f_taxa_esforco( @mntKVincendo, @nifTitular )

  select @taegCalc = taeg
  from ProdutoTaeg
  where idProduto  =  @IdProduto
    and @txEsforco between limiteInferior and limiteSuperior                          

  if @@rowcount > 0 -- Caso contrário, não há escalões de taeg definidos, aplica-se a taeg geral
    set @taeg = @taegCalc


  -- 003 - Validação da necessidade de avalista.
  if @mntKVincendo > @rendimentoAnual and @nifAvalista is null
    begin
      RAISERROR('Obrigatoriedade de avalista. Montante dos créditos superior ao rendimento anual.', 1, 2) WITH LOG
      return       
    end 

  -- 004 - Validação se o avalista tem mais de 5 cráditos.
  if ( select count(1) from vDossierActivo where nifTitular = @nifAvalista ) > 5
    begin
      RAISERROR('Regra de negócio. Um avalista não pode ter mais do que 5 créditos activos.', 1, 2) WITH LOG
      return       
    end 

  -- 005 - Validação se os montantes dos créditos em que é avalista não ultrapassa o dobro do rendimento anual.
  select @avalistaRendimentoAnual    = rendimentoAnual  from titular where nif = @nifAvalista
  select @avalistaMntDividaSolidaria = isnull( sum( s.montante ), 0 ) 
  from vDossierActivo d, saldo s
  where d.iddossier   = s.iddossier     
    and s.saldo       = 'MntKVincendo'
    and d.nifAvalista = @nifAvalista 

  if @avalistaMntDividaSolidaria > ( 2 * @avalistaRendimentoAnual )
    begin
      RAISERROR('Regra de negócio. O Montante dos créditos em que é avalista ultrapassa o dobro do rendimento anual.', 1, 2) WITH LOG
      return       
    end  

  -- 006 - Validação se o cliente é financiavel.
  if exists( select 1 from titular where nif = @nifTitular and iFinanciavel = 0)
    begin
      RAISERROR('Regra de negócio. o cliente não é financiavel.', 1, 2) WITH LOG
      return       
    end  

  -- 007 - Validação se o cliente está na black list.
  if exists( select 1 from blacklist where nif = @nifTitular)
    begin
      RAISERROR('Regra de negócio. o cliente não é financiavel (blacklist).', 1, 2) WITH LOG
      return       
    end  


  -- 008 - Validação de limites dos avalistas.
  if @mntKVincendo > @rendimentoAnual and exists( select 1 from AvalistaLimite where nifAvalista = @nifAvalista and ( mtnKVincendo + @montante ) > mtnMaximo )
    begin
      RAISERROR('Regra de negócio. o avalista passou o limite de crédito estabelecido..', 1, 2) WITH LOG
      return             
    end

  
  insert into dossier( nifTitular, nifAvalista, moedaNome, IdProduto, prazo, periodicidade, taeg, montante, tipoProduto )
               values( @nifTitular, @nifAvalista, @moedaNome, @IdProduto, @prazo, @periodicidade, @taeg,@montante, @tipoProduto )

 
  set @idDossier = @@identity

  insert into saldo( IdDossier, saldo, montante ) values( @idDossier, 'MntKVincendo'    , @montante)
  insert into saldo( IdDossier, saldo, montante ) values( @idDossier, 'MntKVencido'     , 0)
  insert into saldo( IdDossier, saldo, montante ) values( @idDossier, 'MntJrVencido'    , 0)
  insert into saldo( IdDossier, saldo, montante ) values( @idDossier, 'MntCobranca'     , 0)
  insert into saldo( IdDossier, saldo, montante ) values( @idDossier, 'MntIncumprimento', 0)


  -- Nota técnica - O contexto transaccional é gerido nos procedimentos u_sp_dossier_viatura_registar, u_sp_dossier_obras_registar 

  return @idDossier


go

print 'Create Procedure u_sp_dossier_viatura_registar - Procedimento referente à implementação da alínea 2.b do Trabalho'
go
create proc dbo.u_sp_dossier_viatura_registar 
                                               @nifTitular  TNif
                                              ,@nifAvalista TNif
                                              ,@moedaNome   char(3)
                                              ,@IdProduto   TIdentificador
                                              ,@montante    TMontante
                                              ,@idMarca     TIdentificador
                                              ,@modelo      TTxt50
                                              ,@matricula   varchar(6)   	
as
  declare @idDossier TIdentificador
   begin try
      begin transaction 
        exec @idDossier = dbo.u_sp_dossier_registar  @nifTitular, @nifAvalista ,@moedaNome ,@IdProduto, @montante
        insert into CreditoViatura( IdDossier, nifAvalista, idMarca ,modelo, matricula )
                            values( @idDossier, @nifAvalista, @idMarca, @modelo,  @matricula )
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

   return  @idDossier


go  

print 'Create Procedure u_sp_dossier_obras_registar - Procedimento referente à implementação da alínea 2.b do Trabalho'
go
create proc dbo.u_sp_dossier_obras_registar 
                                               @nifTitular       TNif
                                              ,@nifAvalista      TNif
                                              ,@moedaNome        char(3)
                                              ,@IdProduto        TIdentificador
                                              ,@montante         TMontante
                                              ,@IdMorada         TIdentificador
                                              ,@valorPatrimonial TMontante
as 
  declare @idDossier TIdentificador
   begin try
      begin transaction 
        exec @idDossier = dbo.u_sp_dossier_registar  @nifTitular, @nifAvalista ,@moedaNome ,@IdProduto, @montante
        insert into CreditoObra( IdDossier, IdMorada, valorPatrimonial)
                        values( @idDossier, @IdMorada, @valorPatrimonial )
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

   return  @idDossier
  
           
go               
print 'Create Procedure u_sp_dossier_obras_registar_parte2 - Procedimento referente à implementação da alínea 2.a do Trabalho, segunda parte'
go
create proc dbo.u_sp_dossier_obras_registar_parte2
                                               @nifTitular       TNif
                                              ,@nifAvalista      TNif
                                              ,@moedaNome        char(3)
                                              ,@IdProduto        TIdentificador
                                              ,@montante         TMontante
                                              ,@linha1           TTxt100
                                              ,@linha2           TTxt100
                                              ,@codpostal1       smallint
                                              ,@codpostal2       smallint
                                              ,@localidade       TTxt50
                                              ,@valorPatrimonial TMontante
as 
  declare @idDossier TIdentificador
  declare @idMorada TIdentificador
   begin try
      begin transaction 
        exec @idMorada  = dbo.u_sp_morada_add @linha1, @linha2, @codpostal1, @codpostal2, @localidade, 0
        exec @idDossier = dbo.u_sp_dossier_registar  @nifTitular, @nifAvalista ,@moedaNome ,@IdProduto, @montante
        insert into CreditoObra( IdDossier, IdMorada, valorPatrimonial)
                        values( @idDossier, @IdMorada, @valorPatrimonial )
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

   return  @idDossier
  
           
go               
                     
print 'Create Procedure u_sp_calc_rendas - Procedimento referente à implementação da alínea 2.c do Trabalho'
go
-- Formula de Calculo dos juros simples
create proc dbo.u_sp_cal_rendas @IdDossier TIdentificador  
as
  declare @mntJuro          TMontante
  declare @mntK             TMontante
  declare @MntKVincendo     TMontante   
  declare @MntKVencido      TMontante     
  declare @MntJrVencido     TMontante    
  declare @MntCobranca      TMontante    
  declare @MntIncumprimento TMontante
  declare @idEvent          TIdentificador


   begin try
      begin transaction 

      exec @idEvent = u_sp_event_create @idDossier, 'CALC_RENDA'

	  select  @mntJuro           = MntKVincendo * taeg * 1 / 12 
			 ,@mntK              = montante / prazo
			 ,@MntKVincendo      = MntKVincendo
			 ,@MntKVencido       = MntKVencido
			 ,@MntJrVencido      = MntJrVencido
			 ,@MntCobranca       = MntCobranca
			 ,@MntIncumprimento  = MntIncumprimento
	  from vDossierSaldo d
	  where d.IdDossier          = @IdDossier


	  update saldo 
	  set montante = @MntKVincendo - @mntK
	  where IdDossier = @IdDossier and saldo = 'MntKVincendo'    	  

	  update saldo 
	  set   montante = @MntJrVencido + @mntJuro
	  where IdDossier = @IdDossier and saldo = 'MntJrVencido'    
	  
	  update saldo 
	  set   montante = @MntCobranca + @mntJuro + @mntK
	  where IdDossier = @IdDossier and saldo = 'MntCobranca'     


      exec u_sp_event_terminate @idEvent
	  
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

go

print 'Create Procedure u_sp_prestacao_pagamento - Procedimento referente à implementação da alínea 2.c do Trabalho'
go
create proc dbo.u_sp_u_sp_prestacao_pagamento @IdDossier TIdentificador, @mntPrestacao TMontante
as
  declare @MntKVincendo     TMontante   
  declare @MntKVencido      TMontante     
  declare @MntJrVencido     TMontante    
  declare @MntCobranca      TMontante    
  declare @MntIncumprimento TMontante
  declare @mntPagamento     TMontante
  declare @idEvent          TIdentificador


   begin try
      begin transaction 

      set @mntPagamento = @mntPrestacao 

      exec @idEvent = u_sp_event_create @idDossier, 'PAG_PRESTA'

	  select  @MntKVincendo      = MntKVincendo
			 ,@MntKVencido       = MntKVencido
			 ,@MntJrVencido      = MntJrVencido
			 ,@MntCobranca       = MntCobranca
			 ,@MntIncumprimento  = MntIncumprimento
	  from vDossierSaldo d
	  where d.IdDossier          = @IdDossier


      -- 001 - Verificação se existe incumprimento
      if @MntIncumprimento > 0
        begin
          if @mntPagamento >= @MntIncumprimento 
            begin
              set @mntPagamento      = @mntPagamento - @MntIncumprimento 
              set @MntIncumprimento  = 0  
            end
          else
            begin
              set @MntIncumprimento  = @MntIncumprimento -  @mntPagamento 
              set @mntPagamento      = 0
            end 
          
          update saldo 
	      set   montante = @MntIncumprimento
	      where IdDossier = @IdDossier and saldo = 'MntIncumprimento'
        end


      -- 002 - Verificação se ainda existe @mntPagamento para pagamento da prestação
      if @mntPagamento > 0
        begin
          if @mntPagamento >= @MntCobranca 
            begin
              set @mntPagamento  = @mntPagamento - @MntCobranca
              set @MntCobranca   = 0  
            end
          else
            begin
              set @MntCobranca  = @MntCobranca -  @mntPagamento 
              set @mntPagamento = 0              
            end 
          
          update saldo 
	      set   montante = @MntCobranca
	      where IdDossier = @IdDossier and saldo = 'MntCobranca'    
      
        end
  
      -- 003 - Verificação se ainda existe @mntPagamento para amortização
      if @mntPagamento > 0
        begin
          set @MntKVincendo  = @MntKVincendo - @mntPagamento

          update saldo 
	      set   montante = @MntKVincendo
	      where IdDossier = @IdDossier and saldo = 'MntKVincendo'          
        end


      -- 004 - Actualização do capital vencido

	  update saldo 
	  set montante = @MntKVencido + @mntPrestacao
	  where IdDossier = @IdDossier and saldo = 'MntKVencido'     
	  
      exec u_sp_event_terminate @idEvent
	  
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch

go

print 'Create Procedure u_sp_titular_editar - Procedimento referente à implementação da alínea 2.e  do Trabalho'
go
create proc dbo.u_sp_titular_editar
                                        -- Dados gerais do Titular
                                       @nif             TNif
                                      ,@nome            TNome                                     
                                      ,@dtNascimento    TDt
                                      ,@estadoCivil     TEstadoCivil
                                      ,@rendimentoAnual TMontante
                                      ,@nib             TNib
                                      ,@iFinanciavel    TFlag
                                      -- Dados gerais da Morada 
                                      ,@linha1          TTxt100
                                      ,@linha2          TTxt100
                                      ,@codpostal1      smallint
                                      ,@codpostal2      smallint
                                      ,@localidade      TTxt50      
                                      -- Dados Gerais de Contactos
                                      ,@IdTipoContacto1 TIdentificador
                                      ,@contacto1       TTxt100
                                      ,@iPreferencial1  TFlag
                                      ,@IdTipoContacto2 TIdentificador
                                      ,@contacto2       TTxt100
                                      ,@iPreferencial2  TFlag                                  
as
  declare @IdMorada    TIdentificador
  declare @newIdMorada TIdentificador

  select @IdMorada = IdMorada from titular where nif = @nif
  if @@rowcount = 0 -- O titular não existe a primitiva deverá ser registar
    begin
      exec dbo.u_sp_titular_registar
                                       -- Dados gerais do Titular
                                       @nif             
                                      ,@nome                                          
                                      ,@dtNascimento    
                                      ,@estadoCivil     
                                      ,@rendimentoAnual 
                                      ,@nib             
                                      -- Dados gerais da Morada 
                                      ,@linha1          
                                      ,@linha2          
                                      ,@codpostal1      
                                      ,@codpostal2      
                                      ,@localidade       
                                      -- Dados Gerais de Contactos
                                      ,@IdTipoContacto1 
                                      ,@contacto1       
                                      ,@iPreferencial1  
                                      ,@IdTipoContacto2 
                                      ,@contacto2       
                                      ,@iPreferencial2  
     return
    end

   begin try
      begin transaction 
        -- Estratégia - Apagar as relações ( morada e contacto ) e voltar a reconstruir
        delete titularcontacto  where nifTitular = @nif
			exec @newIdMorada = dbo.u_sp_morada_add @linha1, @linha2, @codpostal1, @codpostal2, @localidade, 1 
			exec dbo.u_sp_titular_change         @nif, @nome,  @newIdMorada, @dtNascimento,  @estadoCivil, @rendimentoAnual, @nib, @iFinanciavel 
			exec dbo.u_sp_titularcontacto_add    @nif , @IdTipoContacto1, @contacto1, @iPreferencial1
			exec dbo.u_sp_titularcontacto_add    @nif , @IdTipoContacto2, @contacto2, @iPreferencial2
        if not exists( select 1 from CreditoObra where idMorada =  @IdMorada )
          begin
            delete morada where IdMorada   = @IdMorada 
          end
      commit transaction
   end try
   begin catch
     rollback transaction
     exec u_sp_throwError
   end catch


go
print 'Create Procedure u_sp_titular_creditos - Procedimento referente à implementação da alínea 2.f  do Trabalho'
go
create proc dbo.u_sp_titular_creditos @nif TNif
as
  select * from vDossierSaldo where nifTitular = @nif


go
print 'Create Procedure u_sp_titular_apresentacao_tx_esforco - Procedimento referente à implementação da alínea 2.g  do Trabalho'
go
create proc dbo.u_sp_titular_apresentacao_tx_esforco @nif TNif
as
  declare @mntKVincendo    TMontante
  declare @rendimentoAnual TMontante
  
  select  @mntKVincendo    = dbo.u_f_total_creditos(@nif)
         ,@rendimentoAnual = rendimentoAnual
  from titular
  where nif = @nif

  select dbo.u_f_taxa_esforco( @mntKVincendo, @rendimentoAnual ) As TaxaEsforco


go
print 'Create Procedure u_sp_listar_clientes_incumprimento - Procedimento referente à implementação da alínea 2.h  do Trabalho'
go
create proc dbo.u_sp_listar_clientes_incumprimento 
as
  declare @lastNome         TNome
  declare @Nome             TNome
  declare @MntIncumprimento TMontante
  declare @descricao        Ttxt100
  declare @contacto         Ttxt50  
  declare @iPreferencial    TFlag 

  declare crs cursor for 
  select  t.Nome
         ,d.MntIncumprimento
         ,lktc.descricao
         ,tc.contacto                                                                                             
         ,tc.iPreferencial As Preferencial
  from vDossierSaldo d, titular t, titularcontacto tc, lktipocontacto lktc
  where d.nifTitular       = t.nif
    and t.nif              = tc.nifTitular
    and tc.IdTipoContacto  = lktc.IdTipoContacto 
    and d.MntIncumprimento > 0
  order by t.nome asc, tc.iPreferencial desc

	open crs
	fetch next from crs into @Nome, @MntIncumprimento, @descricao, @contacto, @iPreferencial
	  while @@fetch_status = 0
		begin
 
          if isnull( @lastNome, '' ) != @Nome
            begin
              print ''                
              print 'Nome: ' + @Nome
              print 'Montante Incumprimento: ' + convert(varchar(27), @MntIncumprimento)
            end  


          set @lastNome = '' -- Uso da variavel lastnome para implementar se o contacto corrente é preferencial
          if @iPreferencial = 1
            set @lastNome = '(*)'         
          print '                           ' + @descricao + ': ' +  @contacto + @lastNome

          set @lastNome = @nome
           
		  fetch next from crs into @Nome, @MntIncumprimento, @descricao, @contacto, @iPreferencial
		end
	close crs
	deallocate crs
   

go
print 'Create Procedure u_sp_cal_credito_mal_parado - Procedimento referente à implementação da alínea 2.i  do Trabalho'
go
create proc dbo.u_sp_cal_credito_mal_parado
as
   select sum( d.MntIncumprimento / m.valorReferencia ) as TotCreditoMalParado
   from  vDossierSaldo d, lkmoeda m
   where d.moedaNome = m.nome
     and d.MntIncumprimento > 0


go
print 'Create Procedure u_sp_cal_area_geografica_mais_creditos - Procedimento referente à implementação da alínea 2.j  do Trabalho'
go
create proc dbo.u_sp_cal_area_geografica_mais_creditos
as
   select top 1
          dbo.u_f_area_geografica( m.codpostal1 ), sum( d.montante / c.valorReferencia ) As Montante
   from vDossierSaldo d, titular t, morada m, lkmoeda c
   where d.nifTitular  = t.nif
     and t.idmorada    = m.idmorada
     and d.moedaNome = c.nome
     and d.situacao    = 'A'
   group by dbo.u_f_area_geografica( m.codpostal1 )
go

go
print 'Create Procedure u_sp_titular_financialvel - Procedimento referente à alteração de estado do indicador se o cliente é financiavel'
create proc dbo.u_sp_titular_financialvel @nif TNif, @iFinanciavel TFlag
as
  update titular
  set iFinanciavel = @iFinanciavel
  where nif = @nif

  return @@rowcount

go

print 'Create Procedure u_sp_titularcontacto_del '
go
create proc dbo.u_sp_titularcontacto_del @nifTitular TNif, @IdTipoContacto TIdentificador
as 
  delete titularcontacto
  where nifTitular     = @nifTitular
    and IdTipoContacto = @IdTipoContacto

  return @@rowcount


go

print 'Create Procedure u_sp_titularcontacto_update '
go
create proc dbo.u_sp_titularcontacto_update @nifTitular TNif, @IdTipoContacto TIdentificador, @contacto TTxt100, @iPreferencial TFlag
as 
  update titularcontacto
  set  contacto      = @contacto
      ,iPreferencial = @iPreferencial
  where nifTitular     = @nifTitular
    and IdTipoContacto = @IdTipoContacto

  return @@rowcount

go

print 'Create Procedure u_sp_morada_update'
go
create proc dbo.u_sp_morada_update @idMorada TIdentificador, @linha1 TTxt100, @linha2 TTxt100, @codpostal1 smallint, @codpostal2 smallint, @localidade TTxt50, @principal TFlag
as 
  update morada
  set  linha1     = @linha1
      ,linha2     = @linha2
      ,codpostal1 = @codpostal1
      ,codpostal2 = @codpostal2
      ,localidade = @localidade
      ,principal  = @principal
  where idMorada = @idMorada

  return @@rowcount

go

print 'Create Procedure u_sp_morada_del'
go
create proc dbo.u_sp_morada_del @idMorada TIdentificador
as 
  delete  morada
  where idMorada = @idMorada

  return @@rowcount
