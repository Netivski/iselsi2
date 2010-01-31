use sede

go

create view dbo.vTitulares
as
  select nif, nome from balcao.dbo.Titular

go

create view dbo.vTitularIncumprimento
as
  select * from balcao.dbo.vTitularIncumprimento 