<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DadosTitular.aspx.cs"
    Inherits="DadosTitular" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Gestão de Clientes:.</title>
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
                            <asp:Button ID="btnGravar" runat="server" Text="Gravar" OnClick="btnGravarOnClick" />
                            <asp:PlaceHolder ID="plhOpcoes" runat="server"></asp:PlaceHolder>
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
                            <asp:TextBox ID="txbNome" runat="server" MaxLength="100" Width="413px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Data Nascimento:</b>
                            <asp:TextBox ID="txbDtNascimento" runat="server" MaxLength="10"></asp:TextBox>&nbsp;(
                            aaaa-mm-dd )
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Estado Civil: </b>
                            <asp:DropDownList ID="ddbEstadoCivil" runat="server">
                                <asp:ListItem Value="S">Solteiro</asp:ListItem>
                                <asp:ListItem Value="C">Casado</asp:ListItem>
                                <asp:ListItem Value="D">Divorciado</asp:ListItem>
                                <asp:ListItem Value="V">Viuvo</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Rendimento Anual</b>
                            <asp:TextBox ID="txbRendimentoAnual" runat="server" MaxLength="10"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Nib</b>
                            <asp:TextBox ID="txbNib" runat="server" MaxLength="21" Width="333px"></asp:TextBox>
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
                                        <b>Dados da Morada</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <b>Linha 1</b>
                                                    <asp:TextBox ID="txbLinha1" runat="server" MaxLength="100" Width="331px"></asp:TextBox>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>
                                                    <b>Linha 2</b>
                                                    <asp:TextBox ID="txbLinha2" runat="server" MaxLength="100" Width="330px"></asp:TextBox>
                                                </td>
                                             </tr>
                                             <tr>                                              
                                                <td>
                                                    <b>Código Postal</b>
                                                    <asp:TextBox ID="txbCodPostal1" runat="server" MaxLength="4" Width="83px" ></asp:TextBox>
                                                    &nbsp;<b>-</b>&nbsp;
                                                    <asp:TextBox ID="txbCodPostal2" runat="server" MaxLength="3" Width="69px"></asp:TextBox>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td>
                                                    <b>Localidade</b>
                                                    <asp:TextBox ID="txbLocalidade" runat="server" MaxLength="50" Width="306px" ></asp:TextBox>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td align="right">
                                                    <asp:Button runat="server" ID="btnAlterar" Text="Alterar"
                                                        OnClick="btnAlterarOnClick" />
                                                </td>
                                            </tr>
                                        </table>
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
                                        <b>Contactos</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:Repeater ID="rptContactos" runat="server" 
                                            onitemdatabound="rptContactosDataBound">
                                            <HeaderTemplate>
                                                <tr>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <b>Tipo de Contacto</b>
                                                                </td>
                                                                <td>
                                                                    <b>Contacto</b>
                                                                </td>
                                                                <td>
                                                                    <b>Preferencial</b>
                                                                </td>
                                                                <td><b>Alterar</b>
                                                    
                                                    <td>
                                                        <b>Apagar</b>
                                                    </td>
                                                </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:DropDownList ID="ddbTipoContacto" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txbContacto" runat="server" MaxLength="100"></asp:TextBox>
                                                    </td>
                                                    <td>                                                        
                                                        <asp:CheckBox ID="ckbPreferencial" runat="server" Text="Contacto Preferencial" />
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" ID="btnAlterar" Text="Alterar" OnClick="btnContactoAlterarOnClick" />
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" ID="btnApagar" Text="Apagar" OnClick="btnContactoApagarOnClick" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table> </td> </tr>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                </tr>
                                <tr><td><hr /></td></tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <b>Tipo de Contacto</b>
                                                </td>
                                                <td>
                                                    <b>Contacto</b>
                                                </td>
                                                <td>
                                                    <b>Preferencial</b>
                                                </td>
                                                <td>
                                                    <b>Adicionar Novo</b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddbNovoTipoContacto" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txbNovoContacto" runat="server" MaxLength="100"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="ckbNovoPreferencial" runat="server" Text="Contacto Preferencial" />
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btnAdicionarNovoContacto" Text="Novo Contacto" OnClick="btnAdicionarNovocontactoOnClick" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
