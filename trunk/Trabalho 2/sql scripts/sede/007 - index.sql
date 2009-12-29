use sede

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
                                                                    ) on sedeindexfilegroup
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
                                                                    ) on sedeindexfilegroup
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

print 'Table Balcao - Create Primary Key pk_balcao'
go
alter table dbo.balcao add constraint pk_balcao primary key clustered (
                                                                         nome
	                                                                  ) with(  pad_index = off
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
	