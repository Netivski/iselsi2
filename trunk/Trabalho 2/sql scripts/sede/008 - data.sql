use sede

go


set nocount on

print 'Insert lkMoeda data'
exec u_sp_lkMoeda_add 'EUR', 'Euro'          , 1
exec u_sp_lkMoeda_add 'USD', 'US DOLLAR'     , 1.5068
exec u_sp_lkMoeda_add 'JPY', 'JAPANESE YEN'  , 133.08
exec u_sp_lkMoeda_add 'GBP', 'POUND STERLING', 0.9048
exec u_sp_lkMoeda_add 'CHF', 'SWISS FRANC'   , 1.5063
exec u_sp_lkMoeda_add 'BRL', 'BRAZILIAN REAL', 2.573


print 'Insert produto & taeg data'
declare @rowId int
exec @rowId = u_sp_produto_add 'Vida Livre'  , 24, 'M', 0.2848, 'A'
  exec u_sp_produtotaeg_add @rowId, 0, 24.999 , 0.2048
  exec u_sp_produtotaeg_add @rowId, 25, 49.999, 0.2648
  exec u_sp_produtotaeg_add @rowId, 50, 74.999, 0.3248
  exec u_sp_produtotaeg_add @rowId, 75, 99.999, 0.3648
  exec u_sp_produtotaeg_add @rowId, 100, 999.999 , 0.5748
exec @rowId = u_sp_produto_add 'Conta Certa' , 12, 'M', 0.1476, 'O'
  exec u_sp_produtotaeg_add @rowId, 0, 24.999 , 0.1948
  exec u_sp_produtotaeg_add @rowId, 25, 49.999, 0.1448
  exec u_sp_produtotaeg_add @rowId, 50, 74.999, 0.1848
  exec u_sp_produtotaeg_add @rowId, 75, 99.999, 0.2148
  exec u_sp_produtotaeg_add @rowId, 100, 999.999 , 0.5748
exec @rowId = u_sp_produto_add 'MAXI Crédito', 36, 'M', 0.1976, 'A'
  exec u_sp_produtotaeg_add @rowId, 0, 24.999 , 0.1448
  exec u_sp_produtotaeg_add @rowId, 25, 49.999, 0.1848
  exec u_sp_produtotaeg_add @rowId, 50, 74.999, 0.2348
  exec u_sp_produtotaeg_add @rowId, 75, 99.999, 0.2648
  exec u_sp_produtotaeg_add @rowId, 100, 999.999 , 0.5748
exec @rowId = u_sp_produto_add 'Valor Top'   , 6 , 'M', 0.3276, 'O'
  exec u_sp_produtotaeg_add @rowId, 0, 24.999 , 0.2848
  exec u_sp_produtotaeg_add @rowId, 25, 49.999, 0.3048
  exec u_sp_produtotaeg_add @rowId, 50, 74.999, 0.3648
  exec u_sp_produtotaeg_add @rowId, 75, 99.99 , 0.3848
  exec u_sp_produtotaeg_add @rowId, 100, 999.999, 0.5748


print 'Insert lkmarca data'
exec u_sp_lkmarca_add 'Audi'
exec u_sp_lkmarca_add 'Bmw'
exec u_sp_lkmarca_add 'Fiat'
exec u_sp_lkmarca_add 'Mercedes-Benz'
exec u_sp_lkmarca_add 'Opel'
exec u_sp_lkmarca_add 'Peugeot'
exec u_sp_lkmarca_add 'Renault'
exec u_sp_lkmarca_add 'Volkswagen'
exec u_sp_lkmarca_add 'Volvo'


print 'Insert lktipocontacto data'
exec u_sp_lktipocontacto_add 'TEL_PESS', 'Telemóvel Pessoal'
exec u_sp_lktipocontacto_add 'TEL_EMP' , 'Telemóvel Empresarial'
exec u_sp_lktipocontacto_add 'TEL_CASA', 'Telefone Casa'
exec u_sp_lktipocontacto_add 'TEL_ESC' , 'Telefone Escritório'
exec u_sp_lktipocontacto_add 'E-MAIL'  , 'E-Mail'

set nocount off


