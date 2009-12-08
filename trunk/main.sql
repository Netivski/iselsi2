MntKVincendo   - Montante de capital em divida
MntKVencido    - Montante de capital pago
MntJrVencido   - Montante de Juro Pago
MntCobranca    - Montante da divida do cliente
MntDspVencida  - 
MntImpVencido  - Montante de imposto pago
MntPenalizacao - 



Primitivas 

  1 - 


declare @d numeric( 10,8 )
set @d = 0.22334455
select @d


create function dbo.u_f_calc_juro_simples( @c numeric(18,6),  @i numeric(10,8), @n int )
returns numeric(18,6)
as
  begin
    return @c * @i/100 * @n
  end


declare @c numeric(18,6)
set @c = 1000
select dbo.u_f_calc_juro_simples( @c, 3, 1 )
select @c / 12


