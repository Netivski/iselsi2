<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListarTitularIncumprimento.aspx.cs" Inherits="ListarTitularIncumprimento" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Listagem de Clientes em incumprimento</title>
</head>
<body>
    <form id="form1" runat="server">
<table width="100%">
        <asp:Repeater ID="rptClientIncumprimentoList" runat="server">
        <HeaderTemplate> 
          <tr>
            <td>
              <table width="100%">
                <tr>
                  <td><b>Número de Identificação Fiscal</b></td>
                  <td><b>Nome</b></td>
                  <td><b>Montante do incumprimento</b></td>
                </tr>
                <tr><td colspan="3"><hr /></td></tr>
         </HeaderTemplate> 
         <ItemTemplate> 
              <tr>
                  <td><%#DataBinder.Eval(Container.DataItem,"nif") %></td>
                  <td><%#DataBinder.Eval(Container.DataItem, "nome")%></td>
                  <td><%#DataBinder.Eval(Container.DataItem, "TotalMntIncumprimento")%></td>                  
                  </tr>
              </ItemTemplate> 
              <FooterTemplate>
                  </table>
                </td>
              </tr>
          </FooterTemplate>
        </asp:Repeater>
    </table>       
    </form>
</body>
</html>
