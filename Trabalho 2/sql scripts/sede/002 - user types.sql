--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
--                             Drop Statments
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

use sede

go
if exists(select 1 from systypes where name='TSaldo') execute sp_droptype TSaldo
go

--               TPeriodicidade User Type 
if exists(select 1 from systypes where name='TPeriodicidade') 
  begin
    execute sp_unbindrule TPeriodicidade
    execute sp_droptype   TPeriodicidade
  end

go
if exists (select 1 from sysobjects where id=object_id('R_Situacao') and type='R') drop rule  R_Periodicidade



go
--               Situacao User Type 
if exists(select 1 from systypes where name='TSituacao') 
  begin
    execute sp_unbindrule TSituacao
    execute sp_droptype   TSituacao
  end

go
if exists (select 1 from sysobjects where id=object_id('R_Situacao') and type='R') drop rule  R_Situacao

go
--               TipoProduto User Type 
if exists(select 1 from systypes where name='TTipoProduto') 
  begin
    execute sp_unbindrule TTipoProduto
    execute sp_droptype   TTipoProduto
  end

go
if exists (select 1 from sysobjects where id=object_id('R_TipoProduto') and type='R') drop rule  R_TipoProduto
go
if exists(select 1 from systypes where name='TTaxa') execute sp_droptype TTaxa
go
if exists(select 1 from systypes where name='TFlag') execute sp_droptype TFlag
go  
if exists(select 1 from systypes where name='TIdentificador') execute sp_droptype TIdentificador
go
if exists(select 1 from systypes where name='TTxt100') execute sp_droptype TTxt100
go
if exists(select 1 from systypes where name='TTxt50') execute sp_droptype TTxt50

go
if exists(select 1 from systypes where name='TNif') 
  begin
    execute sp_unbindrule TNif
    execute sp_droptype   TNif       
  end

if exists (select 1 from sysobjects where id=object_id('R_Nif') and type='R') drop rule  R_Nif
 
GO  
if exists(select 1 from systypes where name='TNome') execute sp_droptype TNome
GO  
if exists(select 1 from systypes where name='TDt') execute sp_droptype   TDt
GO         
--               Montante User Type 
if exists(select 1 from systypes where name='TMontante') 
  begin
    execute sp_unbindrule TMontante
    execute sp_droptype   TMontante
  end
go
if exists (select 1 from sysobjects where id=object_id('R_Montante') and type='R') drop rule  R_Montante
go
--               Nib User Type 
if exists(select 1 from systypes where name='TNib') 
  begin
    execute sp_unbindrule TNib
    execute sp_droptype   TNib
  end
go
if exists (select 1 from sysobjects where id=object_id('R_Nib') and type='R') drop rule  R_Nib
go
--               EstadoCivil User Type 
if exists(select 1 from systypes where name='TEstadoCivil') 
  begin
    execute sp_unbindrule TEstadoCivil
    execute sp_droptype   TEstadoCivil
  end
go


if exists (select 1 from sysobjects where id=object_id('R_EstadoCivil') and type='R') drop rule  R_EstadoCivil
go


--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
--                             Create Statments
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

go

execute sp_addtype TSaldo, 'varchar(20)', 'not null'    


go

execute sp_addtype TPeriodicidade, 'char(1)', 'not null'    
go
create rule R_Periodicidade as @column in (   'D' -- Simulação
                                             ,'S' -- Atribuido
                                             ,'M' -- Concluido  
                                             ,'T' -- Trimestral 
                                             ,'S' -- Semestral
                                             ,'A' -- Anual
                                          )
go
execute sp_bindrule R_Periodicidade, TPeriodicidade

go


execute sp_addtype TSituacao, 'char(1)', 'not null'    
go
create rule R_Situacao as @column in (   'S' -- Simulação
                                        ,'A' -- Atribuido
                                        ,'C' -- Concluido  
                                     )
go
execute sp_bindrule R_Situacao, TSituacao

go
execute sp_addtype TTipoProduto, 'char(1)', 'not null'    
go
create rule R_TipoProduto as @column in ( 'A', 'O' )
go
execute sp_bindrule R_TipoProduto, TTipoProduto

go
	execute sp_addtype TTaxa , 'decimal(4, 4)', 'not null'
go
execute sp_addtype TFlag , 'bit', 'not null' 
go
execute sp_addtype TIdentificador , 'int', 'not null'

go
execute sp_addtype TTxt100 , 'varchar(100)'

go
execute sp_addtype TTxt50 , 'varchar(50)'



go
execute sp_addtype TNif, 'varchar(9)'         , 'not null'
go
create rule R_Nif 
As
    @column is null 
Or (  
      ( len( @column ) = 9 And isNumeric( @column ) != 0 ) 
  And ( 
			( 
						(  11 -  ( (      convert( int, substring(@column, 1, 1) ) * 9
										+ convert( int, substring(@column, 2, 1) ) * 8
										+ convert( int, substring(@column, 3, 1) ) * 7
										+ convert( int, substring(@column, 4, 1) ) * 6
										+ convert( int, substring(@column, 5, 1) ) * 5
										+ convert( int, substring(@column, 6, 1) ) * 4
										+ convert( int, substring(@column, 7, 1) ) * 3
										+ convert( int, substring(@column, 8, 1) ) * 2 
								 ) % 11 )  
						) >= 10 and substring(@column, 9, 1) = '0' 
			) 
		Or (
							( 
							   11 - ( 
										(
											  convert( int, substring(@column, 1, 1) ) * 9
											+ convert( int, substring(@column, 2, 1) ) * 8
											+ convert( int, substring(@column, 3, 1) ) * 7
											+ convert( int, substring(@column, 4, 1) ) * 6
											+ convert( int, substring(@column, 5, 1) ) * 5
											+ convert( int, substring(@column, 6, 1) ) * 4
											+ convert( int, substring(@column, 7, 1) ) * 3
											+ convert( int, substring(@column, 8, 1) ) * 2 
										) % 11 
									)
							) = convert( int, substring(@column, 9, 1 ) )
			) 
    )
  )

go
execute sp_bindrule R_Nif, TNif



go
execute sp_addtype TNome         , 'varchar(100)', 'not null'
go
execute sp_addtype TDt           , 'datetime'
go

execute sp_addtype TMontante     , 'decimal(27,4)', 'not null'    
go
create rule R_Montante as @column >= 0
go
execute sp_bindrule R_Montante, TMontante
go

--    Nib
execute sp_addtype TNib     , 'char(21)', 'not null'    
go
create rule R_Nib as IsNumeric(@column) = 1 And len(rtrim(ltrim(@column))) = 21 
go
execute sp_bindrule R_Nib, TNib
go
--    Estado Civil
execute sp_addtype TEstadoCivil     , 'char(1)', 'not null'    
go
create rule R_EstadoCivil as len(rtrim(ltrim(@column))) = 1 And @column in ( 'S', 'C', 'D', 'V' )
/*
  S == solteiro
  C == Casado
  D == Divorciado
  V == Viuvo
*/
go
execute sp_bindrule R_EstadoCivil, TEstadoCivil
go

