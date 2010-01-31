using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class AtribuirCredito : Persistence.DbWebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string nif;
            if ((nif = Request.QueryString["nif"]) != null && nif.Length == 9)
            {
                BindTitular(nif);
                txbNif.Text = nif;
            }

            BindForm();
        }

    }

    protected void btnPesquisarOnClick(object sender, EventArgs e)
    {
        if ( txbNif.Text.Length == 9)
        {
            BindTitular(txbNif.Text);
        }
    }

    protected void BindTitular( string nif )
    {        
        SqlDataReader dr = null;
        SqlParameter[] prams = new SqlParameter[] { db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, nif) };
        db.RecordSet("select * from titular where nif = @nif", prams, out dr);
        if (dr.Read())
        {
            ltrNome.Text = (string)dr["nome"];
            ltrDtNascimento.Text = ((DateTime)dr["dtNascimento"]).ToString("yyyy-MM-dd");
            string estadoCivil = null;
            switch ((string)dr["estadoCivil"])
            {
                case "S":
                    estadoCivil = "solteiro";
                    break;
                case "C":
                    estadoCivil = "Casado";
                    break;
                case "D":
                    estadoCivil = "Divorciado";
                    break;
                case "V":
                    estadoCivil = "Viuvo";
                    break;
            }
            ltrEstadoCivil.Text = estadoCivil; 
            ltrRendimentoAnual.Text = (Convert.ToDecimal(dr["rendimentoAnual"])).ToString();
            ltrNib.Text = (string)(dr["nib"]);
        }
        else
        {
            txbNif.BackColor = System.Drawing.Color.Red;
        }
        dr.Close();
        dr.Dispose();

    }

    protected void BindForm()
    {
        SqlDataReader dr = null;
        ListItem li;
        db.RecordSet("select nome, nomeLongo from lkmoeda order by nomeLongo asc", out dr);
        while (dr.Read())
        {
            ddlMoeda.Items.Add(li = new ListItem((string)dr["nomeLongo"], (string)dr["nome"]));
            if (string.Compare(li.Value, "EUR") == 0) li.Selected = true;
        }
        dr.Close();
        dr.Dispose();

        db.RecordSet("select IdProduto, nome from produto order by nome asc", out dr);
        while (dr.Read())
        {
            ddlProduto.Items.Add(new ListItem((string)dr["nome"], Convert.ToInt32( dr["IdProduto"] ).ToString()));
        }
        dr.Close();
        dr.Dispose();

        OnProdutoSelect(null, null);
    }

    protected void BtnAtribuirCreditoOnClick(object sender, EventArgs e)
    {
        try
        {
            decimal mtn;
            Decimal.TryParse( txbMtn.Text, out mtn );
            if (mtn == 0)
            {
                txbMtn.BackColor = System.Drawing.Color.Red;
                return;
            }

            SqlParameter[] prams = null;
            string spName = null;

            //Form - Obras
            string txbLinha1         = Request.Form["txbLinha1"];
            string txbLinha2         = Request.Form["txbLinha2"];
            string txbCodPostal1     = Request.Form["txbCodPostal1"];
            string txbCodPostal2     = Request.Form["txbCodPostal2"];
            string txbLocalidade     = Request.Form["txbLocalidade"];
            string txbValPatrimonial = Request.Form["txbValPatrimonial"];

            //Form - Viatura
            string ddlMarca          = Request.Form["ddlMarca"];
            string txbModelo         = Request.Form["txbModelo"];
            string txbMatricula      = Request.Form["txbMatricula"];

            switch (GetTipoProduto(Convert.ToInt32(ddlProduto.SelectedValue)))
            {
                case "O":
                    spName = "u_sp_dossier_obras_registar_parte2";
                    prams = new SqlParameter[]{ 
                             db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, txbNif.Text)
                            ,db.MakeInParam("@nifAvalista", System.Data.SqlDbType.VarChar, 9, txbAvalista.Text.Length == 0? Convert.DBNull: txbAvalista.Text)
                            ,db.MakeInParam("@moedaNome", System.Data.SqlDbType.VarChar, 3, ddlMoeda.SelectedValue)
                            ,db.MakeInParam("@IdProduto", System.Data.SqlDbType.Int, 10, Convert.ToInt32( ddlProduto.SelectedValue))
                            ,db.MakeInParam("@montante", System.Data.SqlDbType.Decimal, 10, mtn)
                            ,db.MakeInParam("@linha1", System.Data.SqlDbType.VarChar, 100, txbLinha1)
                            ,db.MakeInParam("@linha2", System.Data.SqlDbType.VarChar, 100, txbLinha2)
                            ,db.MakeInParam("@codpostal1", System.Data.SqlDbType.SmallInt, 4, txbCodPostal1)
                            ,db.MakeInParam("@codpostal2", System.Data.SqlDbType.SmallInt, 3, txbCodPostal2)
                            ,db.MakeInParam("@localidade", System.Data.SqlDbType.VarChar, 50, txbLocalidade)
                            ,db.MakeInParam("@valorPatrimonial", System.Data.SqlDbType.Decimal, 10, txbValPatrimonial)
                    };
                    break;
                case "A":
                    spName = "u_sp_dossier_viatura_registar";
                    prams = new SqlParameter[]{ 
                             db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, txbNif.Text)
                            ,db.MakeInParam("@nifAvalista", System.Data.SqlDbType.VarChar, 9, txbAvalista.Text.Length == 0? Convert.DBNull: txbAvalista.Text)
                            ,db.MakeInParam("@moedaNome", System.Data.SqlDbType.VarChar, 3, ddlMoeda.SelectedValue)
                            ,db.MakeInParam("@IdProduto", System.Data.SqlDbType.Int, 10, Convert.ToInt32( ddlProduto.SelectedValue ))
                            ,db.MakeInParam("@montante", System.Data.SqlDbType.Decimal, 10, mtn)
                            ,db.MakeInParam("@idMarca", System.Data.SqlDbType.Int, 10, ddlMarca)
                            ,db.MakeInParam("@modelo", System.Data.SqlDbType.VarChar, 50, txbModelo)
                            ,db.MakeInParam("@matricula", System.Data.SqlDbType.VarChar, 6, txbMatricula)
                    };
                    break;
                default:
                    lblOutMsg.Text = "Produto inválido.";
                    return;
            }

            db.ExecProc(spName, prams);
            lblOutMsg.Text = "Crédito Atribuído com Sucesso." ;
        }
        catch (Exception exc)
        {
            lblOutMsg.Text = exc.Message;
        }
    }

    protected void RenderObrasForm()
    {
        TextBox linha1            = new TextBox() { EnableViewState = true, ID="txbLinha1", MaxLength = 100, Width = 331 };
        TextBox linha2            = new TextBox() { EnableViewState = true, ID = "txbLinha2", MaxLength = 100, Width = 330 }; ;
        TextBox txbCodPostal1     = new TextBox() { EnableViewState = true, ID = "txbCodPostal1", MaxLength = 4, Width = 83 };
        TextBox txbCodPostal2     = new TextBox() { EnableViewState = true, ID = "txbCodPostal2", MaxLength = 3, Width = 69 };
        TextBox txbLocalidade     = new TextBox() { EnableViewState = true, ID = "txbLocalidade", MaxLength = 50, Width = 306 };
        TextBox txbValPatrimonial = new TextBox() { EnableViewState = true, ID = "txbValPatrimonial", MaxLength = 10, Width = 306 };


        Table tbl = new Table() { Width = new Unit(100, UnitType.Percentage) };
        TableRow tr = new TableRow();
        TableCell td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Linha1</b>:&nbsp;") });
        td.Controls.Add(linha1);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow();
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Linha2</b>:&nbsp;") });
        td.Controls.Add(linha2);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow();
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Código Postal</b>:&nbsp;") });
        td.Controls.Add(txbCodPostal1);
        td.Controls.Add(new Literal() { Text = "&nbsp;-&nbsp;" });
        td.Controls.Add(txbCodPostal2);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow(); 
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Localidade</b>:&nbsp;") });        
        td.Controls.Add(txbLocalidade);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow(); 
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Valor Patrimonial</b>:&nbsp;") });
        td.Controls.Add(txbValPatrimonial);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);        

        plhProdutoOption.Controls.Add(tbl);
    }

    protected void RenderViaturaForm()
    {
        DropDownList marca     = new DropDownList() { EnableViewState=true, ID = "ddlMarca" };
        TextBox      modelo    = new TextBox() { EnableViewState=true, ID = "txbModelo", MaxLength=50 };
        TextBox      matricula = new TextBox() { EnableViewState=true, ID="txbMatricula", MaxLength = 6, Width = 306 };

        SqlDataReader dr = null;
        db.RecordSet("select IdMarca, nome from lkmarca order by nome asc", out dr);
        while (dr.Read())
        {
            marca.Items.Add(new ListItem((string)dr["nome"], Convert.ToInt32( dr["IdMarca"] ).ToString()));
        }
        dr.Close();
        dr.Dispose();

        Table tbl = new Table() { Width = new Unit(100, UnitType.Percentage) };
        TableRow tr = new TableRow();
        TableCell td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Marca</b>:") });
        td.Controls.Add(marca);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow();
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Modelo</b>:") });
        td.Controls.Add(modelo);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        tr = new TableRow();
        td = new TableCell();
        td.Controls.Add(new Literal() { Text = string.Format("<b>Matricúla</b>:") });
        td.Controls.Add(matricula);
        tr.Controls.Add(td);
        tbl.Controls.Add(tr);

        plhProdutoOption.Controls.Add(tbl);
    }

    protected string GetTipoProduto( int idProduto )
    {
        SqlDataReader dr = null;
        string tipoProduto = null; ;
        db.RecordSet(string.Format("select tipoProduto from produto where IdProduto = {0}", idProduto), out dr);
        if (dr.Read())
        {
            tipoProduto = (string)dr["tipoProduto"];
        }
        dr.Close();
        dr.Dispose();

        return tipoProduto;
    }

    public void OnProdutoSelect(object sender, EventArgs e)
    {
        switch (GetTipoProduto(Convert.ToInt32(ddlProduto.SelectedValue)))
        {
            case "O":
                RenderObrasForm();
                break;
            case "A":
                RenderViaturaForm();
                break;
            default:
                lblOutMsg.Text = "Produto inválido.";
                break;
        }
    }
}
