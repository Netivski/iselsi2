using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


public partial class Pagamento : Persistence.DbWebPage
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
        }

    }

    protected void btnPagamentoOnClink(object sender, EventArgs e)
    {
        SqlParameter[] prams = new SqlParameter[] {
             db.MakeInParam("@IdDossier", System.Data.SqlDbType.Int, 10, txbIdDossier.Text)
            ,db.MakeInParam("@mntPrestacao", System.Data.SqlDbType.Decimal, 10, txbMontante.Text)
        };

        db.ExecProc("u_sp_u_sp_prestacao_pagamento", prams);

        BindTitular(txbNif.Text);
    }

    protected void btnPesquisarOnClick(object sender, EventArgs e)
    {
        if (txbNif.Text.Length == 9)
        {
            BindTitular(txbNif.Text);
            plhOptions.Visible = true;
        }
    }

    protected void BindTitular(string nif)
    {
        SqlDataReader dr = null;
        SqlParameter[] prams = new SqlParameter[] { db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, nif) };
        db.RecordSet("select * from titular where nif = @nif", prams, out dr);
        bool read;
        if ( ( read = dr.Read() ))
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

        if (read)
        {
            prams = new SqlParameter[] { db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, nif) };
            db.RecordSet( @"
                                select  dossier.IdDossier, dossier.prazo, dossier.periodicidade, dossier.taeg, dossier.montante, produto.nome
                                       ,vDossierSaldo.MntKVincendo, vDossierSaldo.MntKVencido, vDossierSaldo.MntJrVencido
                                       ,vDossierSaldo.MntCobranca, vDossierSaldo.MntIncumprimento
                                from dossier, produto, vDossierSaldo 
                                where dossier.idProduto  =  produto.IdProduto
                                  and dossier.IdDossier  =  vDossierSaldo.IdDossier 
                                  and dossier.situacao   =  'A'
                                  and dossier.nifTitular =  @nifTitular
                             " , prams, out dr);
            rptDossier.DataSource = dr;
            rptDossier.DataBind();

            dr.Close();
            dr.Dispose();
        }
    }
}
