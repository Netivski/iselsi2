use sede

go

print 'Create Table LkTipoContacto'
go
Create Table dbo.LkTipoContacto(  IdTipoContacto   dbo.TIdentificador  identity( 1, 1 )
                                 ,nome             dbo.Ttxt50  not null
                                 ,descricao        dbo.Ttxt100 not null
                               ) on [primary]


go

print 'Create Table LkMarca'
go
Create Table dbo.LkMarca(   
                             IdMarca    dbo.TIdentificador  identity( 1, 1 )
                            ,nome       dbo.Ttxt50  not null
                          ) on [primary]


print 'Create Table LkMoeda'
go
Create Table dbo.LkMoeda(   
                             nome             char(3)          not null  
                            ,nomeLongo        dbo.Ttxt50       not null
                            ,valorReferencia  decimal( 10, 5 ) not null
                          ) on [primary]


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
                       ) on [primary]

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
                             ) on [primary]

go

print 'Create Table Balcao'
go
Create Table dbo.Balcao(   
                           Nome		      sysname
                          ,ServerName     sysname
                          ,DbName         sysname
                          ,RemoteUserName sysname
                          ,RemoteUserPwd  sysname
                       ) on [primary]


go

print 'Create Table blacklist'
go

create table dbo.Blacklist ( nif  dbo.TNif ) on [primary]

go

print 'Create Table AvalistaLimite'
go

print 'Create Table AvalistaLimite'
go

create table dbo.AvalistaLimite( nifAvalista  dbo.TNif, mtnMaximo tMontante, mtnKVincendo tMontante ) on [primary]


