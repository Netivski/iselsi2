use sede

go

create view dbo.vTitulares
as
  select nif, nome from sintra.sintra.dbo.Titular
  union 
  select nif, nome from vilamoura.vilamoura.dbo.Titular

go

create view dbo.vTitularIncumprimento
as
  select * from sintra.sintra.dbo.vTitularIncumprimento 
  union 
  select * from vilamoura.vilamoura.dbo.vTitularIncumprimento 
