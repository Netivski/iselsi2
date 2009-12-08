print 'Table Morada - Create Primary Key pk_morada'
go
alter table dbo.morada add constraint pk_morada primary key clustered (
                                                                         idmorada
	                                                                  ) with(  pad_index = off
                                                                              ,fillfactor = 30
                                                                              ,statistics_norecompute = off
                                                                              ,ignore_dup_key = off
                                                                              ,allow_row_locks = on
                                                                              ,allow_page_locks = on
                                                                            )on [primary]

go

print 'Table LkTipoContacto - Create Primary Key pk_lktipocontacto'
go
alter table dbo.lktipocontacto add constraint pk_lktipocontacto primary key clustered (
                                                                                         IdTipoContacto
	                                                                                ) with(  pad_index = off
                                                                                            ,fillfactor = 30
                                                                                            ,statistics_norecompute = off
                                                                                            ,ignore_dup_key = off
                                                                                            ,allow_row_locks = on
                                                                                            ,allow_page_locks = on
                                                                                          )on [primary]

go

print 'Table Titular - Create Primary Key pk_titular'
go
alter table dbo.titular add constraint pk_titular primary key clustered (
                                                                            nif
	                                                                     ) with(  pad_index = off
                                                                                 ,fillfactor = 30
                                                                                 ,statistics_norecompute = off
                                                                                 ,ignore_dup_key = off
                                                                                 ,allow_row_locks = on
                                                                                 ,allow_page_locks = on
                                                                               )on [primary]

go

print 'Table TitularContacto - Create Primary Key pk_titularcontacto'
go
alter table dbo.titularcontacto add constraint pk_titularcontacto primary key clustered (
                                                                                            nifTitular, IdTipoContacto
	                                                                                     ) with(  pad_index = off
                                                                                                 ,fillfactor = 30
                                                                                                 ,statistics_norecompute = off
                                                                                                 ,ignore_dup_key = off
                                                                                                 ,allow_row_locks = on
                                                                                                 ,allow_page_locks = on
                                                                                               )on [primary]

go

print 'Table LkMarca - Create Primary Key pk_lkmarca'
go
alter table dbo.lkmarca add constraint pk_lkmarca primary key clustered (
                                                                              IdMarca
	                                                                      ) with(  pad_index = off
                                                                                  ,fillfactor = 30
                                                                                  ,statistics_norecompute = off
                                                                                  ,ignore_dup_key = off
                                                                                  ,allow_row_locks = on
                                                                                  ,allow_page_locks = on
                                                                                 )on [primary]


go 

print 'Table LkMarca - Create Unique Key uix_lkmarca'

create unique nonclustered index uix_lkmarca on dbo.lkmarca (
	                                                            nome
	                                                         ) with(  statistics_norecompute = off
                                                                      ,ignore_dup_key = off
                                                                      ,allow_row_locks = on
                                                                      ,allow_page_locks = on
                                                                    ) on si2indexfilegroup
go

print 'Table LkMoeda - Create Primary Key pk_lkmoeda'
go
alter table dbo.lkmoeda add constraint pk_lkmoeda primary key clustered (
                                                                              nome
	                                                                      ) with(  pad_index = off
                                                                                  ,fillfactor = 30
                                                                                  ,statistics_norecompute = off
                                                                                  ,ignore_dup_key = off
                                                                                  ,allow_row_locks = on
                                                                                  ,allow_page_locks = on
                                                                                 )on [primary]

go

print 'Table Produto - Create Primary Key pk_produto'
go
alter table dbo.produto add constraint pk_produto primary key clustered (
                                                                              IdProduto
	                                                                      ) with(  pad_index = off
                                                                                  ,fillfactor = 30
                                                                                  ,statistics_norecompute = off
                                                                                  ,ignore_dup_key = off
                                                                                  ,allow_row_locks = on
                                                                                  ,allow_page_locks = on
                                                                                 )on [primary]

go

print 'Table Produto - Create Unique Key uix_produto'

create unique nonclustered index uix_produto on dbo.produto (
	                                                            IdProduto
	                                                         ) with(  statistics_norecompute = off
                                                                      ,ignore_dup_key = off
                                                                      ,allow_row_locks = on
                                                                      ,allow_page_locks = on
                                                                    ) on si2indexfilegroup
go

print 'Table ProdutoTaeg - Create Primary Key pk_ProdutoTaeg'
go
alter table dbo.ProdutoTaeg add constraint pk_ProdutoTaeg primary key clustered (
                                                                                    IdProdutoTaeg
	                                                                            ) with(  pad_index = off
                                                                                        ,fillfactor = 30
                                                                                        ,statistics_norecompute = off
                                                                                        ,ignore_dup_key = off
                                                                                        ,allow_row_locks = on
                                                                                        ,allow_page_locks = on
                                                                                      )on [primary]

go


print 'Table Dossier - Create Primary Key pk_Dossier'
go
alter table dbo.Dossier add constraint pk_Dossier primary key clustered (
                                                                                    IdDossier
	                                                                     ) with(  pad_index = off
                                                                                 ,fillfactor = 30
                                                                                  ,statistics_norecompute = off
                                                                                  ,ignore_dup_key = off
                                                                                  ,allow_row_locks = on
                                                                                  ,allow_page_locks = on
                                                                                )on [primary]



go

print 'Table CreditoObra - Create Primary Key pk_creditoobra'
go
alter table dbo.creditoobra add constraint pk_creditoobra primary key clustered (
                                                                                  IdDossier 
	                                                                             ) with(  pad_index = off
                                                                                         ,fillfactor = 30
                                                                                         ,statistics_norecompute = off
                                                                                         ,ignore_dup_key = off
                                                                                         ,allow_row_locks = on
                                                                                         ,allow_page_locks = on
                                                                                       )on [primary]
go

print 'Table CreditoViatura - Create Primary Key pk_creditoviatura'
go
alter table dbo.creditoviatura add constraint pk_creditoviatura primary key clustered (
                                                                                        IdDossier 
	                                                                                   ) with(   pad_index = off
                                                                                                ,fillfactor = 30
                                                                                                ,statistics_norecompute = off
                                                                                                ,ignore_dup_key = off
                                                                                                ,allow_row_locks = on
                                                                                               ,allow_page_locks = on
                                                                                              )on [primary]
go

print 'Table Saldo - Create Primary Key pk_saldo'
go
alter table dbo.saldo add constraint pk_saldo primary key clustered (
                                                                       IdDossier, saldo
	                                                                 ) with(   pad_index = off
                                                                              ,fillfactor = 30
                                                                              ,statistics_norecompute = off
                                                                              ,ignore_dup_key = off
                                                                              ,allow_row_locks = on
                                                                              ,allow_page_locks = on
                                                                            )on [primary]
go

print 'Table Evento - Create Primary Key pk_evento'
go
alter table dbo.evento add constraint pk_evento primary key clustered (
                                                                         IdEvento
	                                                                  ) with(   pad_index = off
                                                                              ,fillfactor = 30
                                                                              ,statistics_norecompute = off
                                                                              ,ignore_dup_key = off
                                                                              ,allow_row_locks = on
                                                                              ,allow_page_locks = on
                                                                            )on [primary]
go

print 'Table EventoSaldo - Create Primary Key pk_eventosaldo'
go
alter table dbo.eventosaldo add constraint pk_eventosaldo primary key clustered (
                                                                                    IdEvento, saldo
	                                                                            ) with(   pad_index = off
                                                                                         ,fillfactor = 30
                                                                                         ,statistics_norecompute = off
                                                                                         ,ignore_dup_key = off
                                                                                         ,allow_row_locks = on
                                                                                         ,allow_page_locks = on
                                                                                      )on [primary]
go

--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
--                                                     TABLE RELATIONS
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

print 'Relation produtotaeg.idproduto, produto.idproduto '
go
alter table dbo.produtotaeg add constraint fk_produtotaeg_produto 
foreign key( idproduto ) references dbo.produto( idproduto ) on update  no action on delete  no action 
	
go
print 'Relation produtotaeg.idmorada, morada.idmorada '
go
alter table dbo.titular add constraint fk_titular_morada 
foreign key ( idmorada ) references dbo.morada ( idmorada ) on update  no action  on delete  no action 
	
go
print 'Relation titularcontacto.idtipocontacto, lktipocontacto.idtipocontacto'
go
alter table dbo.titularcontacto add constraint fk_titularcontacto_lktipocontacto 
foreign key ( idtipocontacto ) references dbo.lktipocontacto ( idtipocontacto ) on update  no action  on delete  no action 
	
go
print 'Relation titularcontacto.niftitular, titular.nif'
go
alter table dbo.titularcontacto add constraint fk_titularcontacto_titular 
foreign key ( niftitular ) references dbo.titular ( nif ) on update  no action  on delete  no action 
	
go
print 'Relation dossier.moedanome, lkmoeda.nome  '
go
alter table dbo.dossier add constraint fk_dossier_lkmoeda 
foreign key ( moedanome ) references dbo.lkmoeda ( nome ) on update  no action  on delete  no action 
	
go
print 'Relation dossier.niftitular, titular.nif '
go
alter table dbo.dossier add constraint fk_dossier_titular 
foreign key ( niftitular ) references dbo.titular ( nif ) on update  no action  on delete  no action 
	
go
print 'Relation dossier.nifavalista, titular.nif '
go
alter table dbo.dossier add constraint fk_dossier_titular_avalista 
foreign key( nifavalista ) references dbo.titular ( nif ) on update  no action  on delete  no action 
	
go
print 'Relation dossier.idproduto, produto.idproduto '
go
alter table dbo.dossier add constraint fk_dossier_produto 
foreign key ( idproduto ) references dbo.produto ( idproduto ) on update  no action  on delete  no action 
	
go
print 'Relation saldo.iddossier, dossier.iddossier '
go
alter table dbo.saldo add constraint fk_saldo_dossier 
foreign key ( iddossier ) references dbo.dossier ( iddossier ) on update  no action  on delete  no action 
	
go
print 'Relation evento.iddossier, dossier.iddossier '
go
alter table dbo.evento add constraint fk_evento_dossier 
foreign key ( iddossier ) references dbo.dossier ( iddossier ) on update  no action  on delete  no action 
	
go
print 'Relation eventosaldo.idevento, evento.idevento '
go
alter table dbo.eventosaldo add constraint fk_eventosaldo_evento 
foreign key ( idevento ) references dbo.evento ( idevento ) on update  no action  on delete  no action 
	
go
print 'Relation creditoobra.iddossier, dossier.iddossier '
go
alter table dbo.creditoobra add constraint fk_creditoobra_dossier 
foreign key ( iddossier ) references dbo.dossier ( iddossier ) on update  no action  on delete  no action 
	
go
print 'Relation creditoobra.idmorada, morada.idmorada '
go
alter table dbo.creditoobra add constraint fk_creditoobra_morada 
foreign key ( idmorada ) references dbo.morada ( idmorada ) on update  no action  on delete  no action 
	
go
print 'Relation creditoviatura.iddossier, dossier.iddossier '
go
alter table dbo.creditoviatura add constraint fk_creditoviatura_dossier 
foreign key ( iddossier ) references dbo.dossier ( iddossier ) on update  no action  on delete  no action 
	
go
print 'Relation creditoviatura.idmarca, lkmarca.idmarca '
go
alter table dbo.creditoviatura add constraint fk_creditoviatura_lkmarca 
foreign key ( idmarca ) references dbo.lkmarca ( idmarca ) on update  no action  on delete  no action 
	