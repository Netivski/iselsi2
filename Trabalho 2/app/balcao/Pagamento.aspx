<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pagamento.aspx.cs" Inherits="Pagamento" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Pagamento:.</title>
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
        <tr><td>
        <asp:PlaceHolder ID="plhOptions" runat="server" Visible="false">
        <table width="100%">
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
        <asp:Repeater ID="rptDossier" runat="server">
            <HeaderTemplate>
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td>
                                    <b>Id Dossier</b>
                                </td>
                                <td>
                                    <b>Prazo</b>
                                </td>
                                <td>
                                    <b>Periodicidade</b>
                                </td>
                                <td>
                                    <b>Taeg</b>
                                </td>
                                <td>
                                    <b>Montante</b>
                                </td>
                                <td>
                                    <b>Nome</b>
                                </td>
                                <td>
                                    <b>Capital Vincendo</b>
                                </td>
                                <td>
                                    <b>Capital Vencido</b>
                                </td>
                                <td>
                                    <b>Juro Vencido</b>
                                </td>
                                <td>
                                    <b>Montante a Cobrança</b>
                                </td>
                                <td>
                                    <b>Incumprimento</b>
                                </td>
                            </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "IdDossier")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "prazo")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "periodicidade")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "taeg")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "montante")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "nome")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "MntKVincendo")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "MntKVencido")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "MntJrVencido")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "MntCobranca")%>
                    </td>
                    <td>
                        <%#DataBinder.Eval(Container.DataItem, "MntIncumprimento")%>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table> </td> </tr>
            </FooterTemplate>
        </asp:Repeater>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                  <tr>
                    <td><b>Id Dossier</b> <asp:TextBox ID="txbIdDossier" runat="server"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td><b>Montante&nbsp;</b> <asp:TextBox ID="txbMontante" runat="server"></asp:TextBox></td>
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
                <hr />
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Button ID="btnPagamento" runat="server" OnClick="btnPagamentoOnClink" Text="Pagamento" />
            </td>
        </tr>
        
        </table>        
        </asp:PlaceHolder>
        </td></tr>
    </table>
    </form>
</body>
</html>
