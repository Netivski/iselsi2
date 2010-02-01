<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PagamentoExterno.aspx.cs" Inherits="PagamentoExterno" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Pagamento Externo:.</title>
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%">
        <tr>
            <td>
                <b>Balcão:</b>&nbsp;
                <asp:DropDownList ID="ddlBalcao" runat="server"></asp:DropDownList>
            </td>        
        </tr>
        <tr>
            <td>
                <b>Número de Identificação Fiscal:</b>
                <asp:TextBox ID="txbNif" runat="server"></asp:TextBox>
            </td>
        </tr>        
        <tr>
            <td>
                <b>Id Dossier</b>
                <asp:TextBox ID="txbIdDossier" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <b>Montante&nbsp;</b>
                <asp:TextBox ID="txbMontante" runat="server"></asp:TextBox>
            </td>
        </tr>        
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Button ID="btnPagamento" runat="server" OnClick="btnPagamentoOnClink" Text="Pagamento" />
            </td>
        </tr>                
        <tr>
            <td>
                <hr />
            </td>
        </tr>
     </table>
    </form>
</body>
</html>
