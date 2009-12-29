use balcao

go



if exists( select 1 from sysobjects where id = object_id('u_f_trim') and type = 'FN' ) drop function u_f_trim

go

create function dbo.u_f_trim( @txt varchar(max) )
returns varchar(max)
as  
  begin
    return rtrim(ltrim( @txt ))
  end 


go

if exists( select 1 from sysobjects where id = object_id('u_f_is_valid_nif') and type = 'FN' ) drop function u_f_is_valid_nif

go

create function dbo.u_f_is_valid_nif( @nif  dbo.TNif )
returns bit
as
  begin
     set @nif = dbo.u_f_trim(@nif)

     if len( @nif ) = 9 And isNumeric( @nif ) != 0
		if( 
				(  11 -  ( (      convert( int, substring(@nif, 1, 1) ) * 9
								+ convert( int, substring(@nif, 2, 1) ) * 8
								+ convert( int, substring(@nif, 3, 1) ) * 7
								+ convert( int, substring(@nif, 4, 1) ) * 6
								+ convert( int, substring(@nif, 5, 1) ) * 5
								+ convert( int, substring(@nif, 6, 1) ) * 4
								+ convert( int, substring(@nif, 7, 1) ) * 3
								+ convert( int, substring(@nif, 8, 1) ) * 2 
						 ) % 11 )  
				) >= 10 and substring(@nif, 9, 1) = '0' 
			) return 1        
		else if (
                    ( 
                       11 - ( 
                                (
									  convert( int, substring(@nif, 1, 1) ) * 9
									+ convert( int, substring(@nif, 2, 1) ) * 8
									+ convert( int, substring(@nif, 3, 1) ) * 7
									+ convert( int, substring(@nif, 4, 1) ) * 6
									+ convert( int, substring(@nif, 5, 1) ) * 5
									+ convert( int, substring(@nif, 6, 1) ) * 4
									+ convert( int, substring(@nif, 7, 1) ) * 3
									+ convert( int, substring(@nif, 8, 1) ) * 2 
						        ) % 11 
                            )
				    ) = convert( int, substring(@nif, 9, 1 ) )
		        ) return 1
    return 0
  end 



go

if exists( select 1 from sysobjects where id = object_id('u_f_total_creditos') and type = 'FN' ) drop function u_f_total_creditos

go

create function dbo.u_f_total_creditos( @nif  dbo.TNif )
returns dbo.TMontante
as
  begin
    declare @montante TMontante
    
    select @montante = sum( s.montante ) 
    from vDossierActivo d, saldo s
    where d.iddossier  = s.iddossier
      and s.saldo      = 'MntKVincendo'
      and d.nifTitular = @nif 

    return  @montante
  end

go 

if exists( select 1 from sysobjects where id = object_id('u_f_taxa_esforco') and type = 'FN' ) drop function u_f_taxa_esforco
go
create function dbo.u_f_taxa_esforco( @mntKVincendo TMontante, @rendimentoAnual TMontante )
returns decimal( 8, 4 )
as
  begin
    return  @mntKVincendo / @rendimentoAnual
  end


go 

--Procedimento que retorna a area geográfica em função do código postal
if exists( select 1 from sysobjects where id = object_id('u_f_area_geografica') and type = 'FN' ) drop function u_f_taxa_esforco
go
create function dbo.u_f_area_geografica( @codPostal smallint )
returns varchar( max )
as
  begin
    if @codPostal = 2710 return 'Sintra'

    return 'area_geografica_' + convert(varchar(5), @codPostal)  
  end


go
