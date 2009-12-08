print 'Create Table Morada'
go
Create Table dbo.Morada(  IdMorada   dbo.TIdentificador  identity( 1, 1 ) 
	                     ,linha1     dbo.Ttxt100         not null
	                     ,linha2     dbo.Ttxt100         not null
	                     ,codpostal1 smallint            not null
	                     ,codpostal2 smallint            not null
	                     ,localidade dbo.Ttxt50          not null
                         ,principal  dbo.TFlag           not null default(0)
                       ) ON [PRIMARY]

go


print 'Create Table LkTipoContacto'
go
Create Table dbo.LkTipoContacto(  IdTipoContacto   dbo.TIdentificador  identity( 1, 1 )
                                 ,nome             dbo.Ttxt50  not null
                                 ,descricao        dbo.Ttxt100 not null
                               )


go

print 'Create Table Titular'
Create Table dbo.Titular(   nif                 dbo.TNif
                           ,nome                dbo.TNome          
                           ,IdMorada            dbo.TIdentificador  
                           ,dtNascimento        dbo.TDt
                           ,estadoCivil         dbo.TEstadoCivil
                           ,rendimentoAnual     dbo.TMontante
                           ,nib                 dbo.TNib  
                           ,iFinanciavel        dbo.TFlag         default( 1 ) not null
                        )  ON [PRIMARY]

go


print 'Create Table TitularContacto'
go
Create Table dbo.TitularContacto(  
                                      nifTitular       dbo.TNif
                                     ,IdTipoContacto   dbo.TIdentificador  
                                     ,contacto         dbo.Ttxt100          not null
                                     ,iPreferencial    dbo.TFlag            not null default(0)
                               )


go

print 'Create Table LkMarca'
go
Create Table dbo.LkMarca(   
                             IdMarca    dbo.TIdentificador  identity( 1, 1 )
                            ,nome       dbo.Ttxt50  not null
                          )


print 'Create Table LkMoeda'
go
Create Table dbo.LkMoeda(   
                             nome             char(3)          not null  
                            ,nomeLongo        dbo.Ttxt50       not null
                            ,valorReferencia  decimal( 10, 5 ) not null
                          )


go

print 'Create Table Produto'
go
Create Table dbo.Produto(   
                             IdProduto      dbo.TIdentificador  identity( 1, 1 )
                            ,nome           dbo.Ttxt50          not null  
                            ,prazo          smallint            not null 
                            ,periodicidade  dbo.TPeriodicidade       
                            ,taeg           TTaxa            
                            ,tipoProduto    dbo.TTipoProduto     
                       )

go

print 'Create Table Produto Limites Taxas'
go
--Relação entre o Produto, Taxa de esforço do titular e taxa a aplicar
Create Table dbo.ProdutoTaeg(   
                                  IdProdutoTaeg  dbo.TIdentificador  identity( 1, 1 ) 
                                 ,idProduto      dbo.TIdentificador 
                                 ,limiteInferior decimal( 6, 3 )   not null
                                 ,limiteSuperior decimal( 6, 3 )   not null
                                 ,taeg           TTaxa            
                             )

go


print 'Create Table Dossier'
go
Create Table dbo.Dossier(   
                             IdDossier      dbo.TIdentificador  identity( 1, 1 )                          
                            ,nifTitular     dbo.TNif            not null
                            ,nifAvalista    dbo.TNif            null
                            ,moedaNome      char(3)             not null default( 'EUR' )          
                            ,IdProduto      dbo.TIdentificador  
                            ,situacao       dbo.TSituacao       default( 'S' ) -- simulação 
                            ,prazo          smallint            not null 
                            ,periodicidade  dbo.TPeriodicidade       
                            ,taeg           TTaxa            
                            ,montante       dbo.TMontante
                            ,tipoProduto    dbo.TTipoProduto     
                       )


go


print 'Create Table CreditoObra'
go
Create Table dbo.CreditoObra(   
                                IdDossier        dbo.TIdentificador                            
                               ,IdMorada         dbo.TIdentificador  
                               ,valorPatrimonial dbo.TMontante     
                             )


go


print 'Create Table CreditoViatura'
go
Create Table dbo.CreditoViatura(   
                                   IdDossier        dbo.TIdentificador                            
                                  ,nifAvalista      dbo.TNif            
                                  ,idMarca          dbo.TIdentificador  
                                  ,modelo           dbo.Ttxt50          not null
                                  ,matricula        varchar(6)          not null
                               )


go

print 'Create Table Saldo'
go
Create Table dbo.Saldo(   
                                   IdDossier        dbo.TIdentificador                            
                                  ,saldo            dbo.TSaldo
                                  ,montante         dbo.TMontante
                      )


go

print 'Create Table Evento'
go
Create Table dbo.Evento(   
                                   IdEvento         dbo.TIdentificador  identity( 1, 1 )
                                  ,IdDossier        dbo.TIdentificador                            
                                  ,codTipEvento     varchar( 10 )       not null
                                  ,dtEvento         dbo.TDt             default( getdate() )  
                       )


go

print 'Create Table EventoSaldo'
go
Create Table dbo.EventoSaldo(   
                                   IdEvento         dbo.TIdentificador                            
                                  ,saldo            dbo.TSaldo
                                  ,mntAntesEvento   dbo.TMontante
                                  ,mntDepoisEvento  dbo.TMontante
                            )


go

