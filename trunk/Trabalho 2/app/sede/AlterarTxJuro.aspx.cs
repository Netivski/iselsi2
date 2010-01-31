using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class AlterarTxJuro : Persistence.DbWebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) ProdutoBinding();
    }

    void ProdutoBinding()
    {
        SqlDataReader dr = null;
        db.RecordSet("select IdProduto, nome from produto order by nome", out dr);
        while (dr.Read())
        {
            cbxProduto.Items.Add(new ListItem((string)dr["nome"], Convert.ToInt32( dr["IdProduto"] ).ToString()));
        }
        dr.Close();
        dr.Dispose();
    }

    void TaegBinding( int idProduto ){
        SqlDataReader dr = null;
        db.RecordSet(string.Format("select IdProdutoTaeg, limiteInferior, limiteSuperior, taeg from ProdutoTaeg where idProduto = {0}", idProduto), out dr);
        rptProdutoTxJuro.DataSource = dr;
        rptProdutoTxJuro.DataBind();
    }
    protected void cbxProduto_SelectedIndexChanged(object sender, EventArgs e)
    {
        TaegBinding(Convert.ToInt32(cbxProduto.SelectedValue)); 
    }
    protected void btnAlterarOnClick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int idProdutoTaeg;
        int.TryParse(btn.CommandArgument, out idProdutoTaeg);
        if (idProdutoTaeg != 0)
        {
            TextBox txJuro = (TextBox)GetChildControl(rptProdutoTxJuro, GetCtrlNameFromBrother(btn, "txtTxJuro"));
            if (txJuro == null) throw new ApplicationException("Invalid Control Name. (txtTxJuro)");

            decimal taeg;
            Decimal.TryParse(txJuro.Text, out taeg);
            if (taeg == 0)
            {
                txJuro.BackColor = System.Drawing.Color.Red;
                return;
            }

            SqlParameter[] prams = new SqlParameter[2] {
                                                           db.MakeInParam( "@IdProdutoTaeg", System.Data.SqlDbType.Int, 8, idProdutoTaeg )
                                                          ,db.MakeInParam( "@taeg", System.Data.SqlDbType.Decimal, 5, taeg )
            }                                          ;

            db.ExecProc( "u_sp_produtotaeg_update", prams );               
        }
    }
}
