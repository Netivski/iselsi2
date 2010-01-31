<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AlterarTxJuro.aspx.cs" Inherits="AlterarTxJuro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alteração da tx. de juro</title>
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%">
        <tr>
            <td> <b>Produto: </b>
                <asp:DropDownList ID="cbxProduto" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="cbxProduto_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <asp:Repeater ID="rptProdutoTxJuro" runat="server">
        <HeaderTemplate> 
          <tr>
            <td>
              <table width="100%">
                <tr>
                  <td><b>Limite Inferior</b></td>
                  <td><b>Limite Superior</b></td>
                  <td><b><u>Tx. de Juro</u></b></td>
                  <td><b>Alterar</b></td>
                </tr>
         </HeaderTemplate> 
         <ItemTemplate> 
              <tr>
                  <td><%#DataBinder.Eval(Container.DataItem,"limiteInferior") %></td>
                  <td><%#DataBinder.Eval(Container.DataItem, "limiteSuperior")%></td>
                  <td><asp:TextBox ID="txtTxJuro" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "taeg")%>'></asp:TextBox></td>
                  <td><asp:Button runat="server" ID="btnAlterar" Text="Alterar" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "IdProdutoTaeg")%>' OnClick="btnAlterarOnClick" /> </td>
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
