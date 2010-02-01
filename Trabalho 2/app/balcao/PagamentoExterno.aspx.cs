using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class PagamentoExterno : Persistence.DbWebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindForm();
    }

    protected void BindForm()
    {
        SqlDataReader dr = null;
        SqlParameter[] prams = new SqlParameter[] { db.MakeInParam("@balcao", System.Data.SqlDbType.VarChar, 75, ConfigurationSettings.AppSettings["balcao"]) };
        db.RecordSet("select nome from balcao where nome not in ( 'sede', @balcao) order by nome", prams, out dr);
        while (dr.Read())
        {
            ddlBalcao.Items.Add(new ListItem((string)dr["nome"], (string)dr["nome"]));
        }
        dr.Close();
        dr.Dispose();        
    }

    protected void btnPagamentoOnClink(object sender, EventArgs e)
    {
        SqlParameter[] prams = new SqlParameter[] {
             db.MakeInParam("@balcao", System.Data.SqlDbType.VarChar, 75, ddlBalcao.SelectedValue)
            ,db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, txbNif.Text)        
            ,db.MakeInParam("@montante", System.Data.SqlDbType.Decimal, 10, txbMontante.Text)        
            ,db.MakeInParam("@IdDossier", System.Data.SqlDbType.Int, 10, txbIdDossier.Text)
        };

        db.ExecProc("u_sp_pagamento_externo", prams);
    }
}
