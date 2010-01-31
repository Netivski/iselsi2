<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AtribuirCredito.aspx.cs"
    Inherits="AtribuirCredito" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Atribuir Crédito a Cliente:.</title>
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%">
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <b>Número de Identificação Fiscal:</b>&nbsp;
                            <asp:TextBox ID="txbNif" runat="server" MaxLength="9"></asp:TextBox>
                            <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" OnClick="btnPesquisarOnClick" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <b>Nome:</b>
                            <asp:Literal ID="ltrNome" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Data Nascimento:</b>
                            <asp:Literal ID="ltrDtNascimento" runat="server"></asp:Literal>&nbsp;( aaaa-mm-dd
                            )
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Estado Civil: </b>
                            <asp:Literal ID="ltrEstadoCivil" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Rendimento Anual</b>
                            <asp:Literal ID="ltrRendimentoAnual" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Nib</b>
                            <asp:Literal ID="ltrNib" runat="server"></asp:Literal>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                  <tr>
                    <td><b>Número de Identificação Fiscal do Avalista:</b><asp:TextBox ID="txbAvalista" runat="server" MaxLength="9"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td><b>Moeda:</b><asp:DropDownList ID="ddlMoeda" runat="server" ></asp:DropDownList></td>
                  </tr>
                  <tr>
                      <td>
                          <b>Produto:</b>
                          <asp:DropDownList ID="ddlProduto" runat="server" OnSelectedIndexChanged="OnProdutoSelect" AutoPostBack="true"></asp:DropDownList>
                          <asp:PlaceHolder ID="plhProdutoOption" runat="server"></asp:PlaceHolder>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <b>Montante:</b><asp:TextBox ID="txbMtn" runat="server" MaxLength="10"></asp:TextBox>
                          <asp:Button ID="btnAtribuirCredito" runat="server" Text="Abrir Dossier" OnClick="BtnAtribuirCreditoOnClick" />
                      </td>
                  </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>     
        <tr>
            <td>
                <asp:Label ID="lblOutMsg" runat="server" ForeColor="Red"></asp:Label>
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
