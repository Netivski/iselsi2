 

create view dbo.vDossierActivo
as
  select * from dossier
  where situacao = 'A'


go


create view dbo.vDossierSaldo
as
  select * 
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntKVincendo')     As MntKVincendo
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntKVencido')      As MntKVencido
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntJrVencido')     As MntJrVencido
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntCobranca')      As MntCobranca
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntIncumprimento') As MntIncumprimento
  from dossier



go


create view dbo.vAvalista
as
  select nifAvalista from dossier where nifAvalista is not null
  union 
  select nifAvalista from creditoviatura where nifAvalista is not null

go

create view dbo.vTotalMntKVincendo
as
  select nif, dbo.u_f_total_creditos( nif ) as TotalMntKVincendo from titular

go 

create view dbo.vTotalMntKVincendoAvalista
as 
 select nifAvalista, dbo.u_f_total_creditos_avalista(nifAvalista) as TotalKAvalizado from vAvalista


go

create view dbo.vTitularIncumprimento
as
  select titular.nif, titular.nome, sum(MntIncumprimento) As TotalMntIncumprimento 
  from vDossierSaldo, titular 
  where vDossierSaldo.nifTitular = titular.nif
    and MntIncumprimento > 0 
  group by titular.nif, titular.nome



