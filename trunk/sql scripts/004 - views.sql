
use si2

go


create view dbo.vDossierActivo
as
  select * from dossier
  where situacao = 'A'


go


create view dbo.vDossierSaldo
as
  select dossier.* 
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntKVincendo')     As MntKVincendo
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntKVencido')      As MntKVencido
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntJrVencido')     As MntJrVencido
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntCobranca')      As MntCobranca
         ,( select montante from saldo where IdDossier = dossier.IdDossier and saldo = 'MntIncumprimento') As MntIncumprimento
  from dossier
