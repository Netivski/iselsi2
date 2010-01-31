using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class DadosTitular : Persistence.DbWebPage
{
    protected List<TitularContacto> ContactosTempBuffer
    {
        get
        {
            return (List<TitularContacto>)Session["AlterarDadosTitular_ContactosTempBuffer"];
        }
        set
        {
            Session["AlterarDadosTitular_ContactosTempBuffer"] = value;
        }
    }
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) BindNovoContacto();
    }

    protected void btnPesquisarOnClick(object sender, EventArgs e)
    {
        if (txbNif.Text.Length != 9)
        {
            txbNif.BackColor = System.Drawing.Color.Red;
            return;
        }

        BindTitular(txbNif.Text);        
    }

    protected void btnGravarOnClick(object sender, EventArgs e)
    {
        // Validação do form
        // transacção gerida na base de dados
        try
        {
            int[]    idTipoContacto = {0, 0};
            string[] contacto       = {"", ""};
            bool[]   preferencial   = {false, false};

            if (ContactosTempBuffer != null)
            {
                if (ContactosTempBuffer.Count > 0)
                {
                    idTipoContacto[0] = ContactosTempBuffer[0].IdTipoContacto;
                    contacto[0] = ContactosTempBuffer[0].Contacto;
                    preferencial[0] = ContactosTempBuffer[0].Preferencial;
                }

                if (ContactosTempBuffer.Count > 1)
                {
                    idTipoContacto[1] = ContactosTempBuffer[1].IdTipoContacto;
                    contacto[1] = ContactosTempBuffer[1].Contacto;
                    preferencial[1] = ContactosTempBuffer[1].Preferencial;
                }

                ContactosTempBuffer = null; //clean object
            }
                                   
            SqlParameter[] prams = new SqlParameter[] {
                 db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, txbNif.Text)
                ,db.MakeInParam("@nome", System.Data.SqlDbType.VarChar, 100, txbNome.Text )
                ,db.MakeInParam("@dtNascimento", System.Data.SqlDbType.DateTime, 30, Convert.ToDateTime( txbDtNascimento.Text ) )
                ,db.MakeInParam("@estadoCivil", System.Data.SqlDbType.VarChar, 1, ddbEstadoCivil.SelectedValue )
                ,db.MakeInParam("@rendimentoAnual", System.Data.SqlDbType.Decimal, 10, Convert.ToDecimal(txbRendimentoAnual.Text) )
                ,db.MakeInParam("@nib", System.Data.SqlDbType.VarChar, 21, txbNib.Text )
                ,db.MakeInParam("@linha1", System.Data.SqlDbType.VarChar, 100, txbLinha1.Text )
                ,db.MakeInParam("@linha2", System.Data.SqlDbType.VarChar, 100, txbLinha2.Text )
                ,db.MakeInParam("@codpostal1", System.Data.SqlDbType.Int, 4, Convert.ToInt32( txbCodPostal1.Text ) )
                ,db.MakeInParam("@codpostal2", System.Data.SqlDbType.Int, 3, Convert.ToInt32( txbCodPostal2.Text ) )
                ,db.MakeInParam("@localidade", System.Data.SqlDbType.VarChar, 50, txbLocalidade.Text )
                ,db.MakeInParam("@IdTipoContacto1", System.Data.SqlDbType.Int, 10, idTipoContacto[0] )
                ,db.MakeInParam("@contacto1", System.Data.SqlDbType.Text, 100, contacto[0] )
                ,db.MakeInParam("@iPreferencial1", System.Data.SqlDbType.Bit, 1, preferencial[0] )
                ,db.MakeInParam("@IdTipoContacto2", System.Data.SqlDbType.Int, 10, idTipoContacto[1] )
                ,db.MakeInParam("@contacto2", System.Data.SqlDbType.Text, 100, contacto[1] )
                ,db.MakeInParam("@iPreferencial2", System.Data.SqlDbType.Bit, 1, preferencial[1] )
            };

            db.ExecProc("u_sp_titular_registar", prams);



        }
        catch (Exception exc)
        {
            throw exc;
        }
    }

    protected void btnAlterarOnClick(object sender, EventArgs e)
    {
        SqlParameter[] prams = new SqlParameter[7]{
             db.MakeInParam("@idMorada", System.Data.SqlDbType.Int, 10, Convert.ToInt32( btnAlterar.CommandArgument))
            ,db.MakeInParam("@linha1", System.Data.SqlDbType.VarChar, 100, txbLinha1.Text)
            ,db.MakeInParam("@linha2", System.Data.SqlDbType.VarChar, 100, txbLinha2.Text)
            ,db.MakeInParam("@codpostal1", System.Data.SqlDbType.SmallInt, 4, txbCodPostal1.Text)
            ,db.MakeInParam("@codpostal2", System.Data.SqlDbType.SmallInt, 3, txbCodPostal2.Text)
            ,db.MakeInParam("@localidade", System.Data.SqlDbType.VarChar, 50, txbLocalidade.Text)
            ,db.MakeInParam("@principal", System.Data.SqlDbType.Bit, 1, 1)
        };

        db.ExecProc("u_sp_morada_update", prams);
    }

    protected void btnContactoAlterarOnClick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string nif;
        int idTipoContacto;
        GetContactoFromCommonArguments(btn, out nif, out idTipoContacto);

        TextBox contacto = (TextBox)GetChildControl(rptContactos, GetCtrlNameFromBrother(btn, "txbContacto"));
        CheckBox preferencial = (CheckBox)GetChildControl(rptContactos, GetCtrlNameFromBrother(btn, "ckbPreferencial"));

        SqlParameter[] prams = new SqlParameter[4]{
             db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, nif)
            ,db.MakeInParam("@IdTipoContacto", System.Data.SqlDbType.Int, 10, idTipoContacto)
            ,db.MakeInParam("@contacto", System.Data.SqlDbType.VarChar, 100, contacto.Text)
            ,db.MakeInParam("@iPreferencial", System.Data.SqlDbType.Bit, 1, ckbNovoPreferencial.Checked)
        };

        db.ExecProc("u_sp_titularcontacto_update", prams);
    }

    protected void btnContactoApagarOnClick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string nif;
        int idTipoContacto;
        GetContactoFromCommonArguments(btn, out nif, out idTipoContacto);

        SqlParameter[] prams = new SqlParameter[2]{
            db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, nif)
            ,db.MakeInParam("@IdTipoContacto", System.Data.SqlDbType.Int, 10, idTipoContacto)
        };

        db.ExecProc("u_sp_titularcontacto_del", prams);

        BindContacto(nif);
    }

    protected void BindTitular( string nif )
    {
        if (nif == null) throw new ArgumentNullException("nif");

        if (nif.Length == 9)
        {
            int idMorada = 0;
            SqlDataReader dr = null;
            SqlParameter[] prams = new SqlParameter[] { db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, nif) };
            db.RecordSet("select * from titular where nif = @nif", prams, out dr);
            if (dr.Read())
            {
                txbNome.Text = (string)dr["nome"];
                idMorada = Convert.ToInt32(dr["idMorada"]);
                txbDtNascimento.Text = ((DateTime)dr["dtNascimento"]).ToString("yyyy-MM-dd");
                foreach( ListItem item in ddbEstadoCivil.Items ) item.Selected = false; 
                ddbEstadoCivil.Items.FindByValue((string)dr["estadoCivil"]).Selected = true;
                txbRendimentoAnual.Text = (Convert.ToDecimal(dr["rendimentoAnual"])).ToString();
                txbNib.Text = (string)(dr["nib"]);

                HyperLink linkAtribuirCredito = new HyperLink();
                linkAtribuirCredito.ID = "linkAtribuirCredito";
                linkAtribuirCredito.NavigateUrl = string.Format("AtribuirCredito.aspx?nif={0}", Server.UrlEncode( nif ));
                linkAtribuirCredito.Text = "Atribuir Crédito";
                plhOpcoes.Controls.Add(linkAtribuirCredito);
            }
            else
            {
                txbNif.BackColor = System.Drawing.Color.Red;
            }
            dr.Close();
            dr.Dispose();

            BindMorada(idMorada);
            BindContacto(nif);
        }
    }

    protected void BindMorada( int idMorada )
    {
        if (idMorada < 1) throw new ArgumentException("idMorada");

        SqlDataReader dr = null;
        db.RecordSet( string.Format( "select * from morada where idMorada = {0}", idMorada ), out dr);
        if (dr.Read())
        {
            txbLinha1.Text = (string)dr["linha1"];
            txbLinha2.Text = (string)dr["linha2"];
            txbCodPostal1.Text = Convert.ToInt32( dr["codpostal1"]).ToString();
            txbCodPostal2.Text = Convert.ToInt32( dr["codpostal2"]).ToString();
            txbLocalidade.Text = (string)dr["localidade"];

            btnAlterar.CommandArgument = Convert.ToInt32( dr["IdMorada"] ).ToString();
        }
        else
        {
            txbNif.BackColor = System.Drawing.Color.Red;
        }
        dr.Close();
        dr.Dispose();
    }

    protected void BindContacto(string nif)
    {
        if (nif == null) throw new ArgumentNullException("nif");

        if (nif.Length == 9)
        {
            SqlDataReader dr = null;
            SqlParameter[] prams = new SqlParameter[1] { db.MakeInParam("@nifTitular", System.Data.SqlDbType.VarChar, 9, nif) };
            db.RecordSet("select * from titularcontacto where nifTitular = @nifTitular", prams, out dr);
            List<TitularContacto> tContactos = new List<TitularContacto>();
            while (dr.Read()) tContactos.Add(new TitularContacto(Convert.ToInt32(dr["IdTipoContacto"]), (string)dr["contacto"], Convert.ToBoolean(dr["iPreferencial"])));
            dr.Close();
            dr.Dispose();
            rptContactos.DataSource = tContactos;
            rptContactos.DataBind();
        }
    }

    protected void BindNovoContacto()
    {
        SqlDataReader dr = null;
        db.RecordSet("select IdTipoContacto, descricao from LkTipoContacto order by descricao", out dr);
        ddbNovoTipoContacto.DataSource = dr;
        ddbNovoTipoContacto.DataTextField = "descricao";
        ddbNovoTipoContacto.DataValueField = "IdTipoContacto";
        ddbNovoTipoContacto.DataBind();
        dr.Close();
        dr.Dispose();
    }

    protected string GetContactoCommonArguments(string nif, int IdTipoContacto)
    {
        return string.Format("{0}_$_{1}", nif, IdTipoContacto);
    }

    protected void GetContactoFromCommonArguments(Button btn, out string nif, out int idTipoContacto)
    {
        if (btn == null) throw new ArgumentNullException( "btn" );
        if (btn.CommandArgument.IndexOf("_$_") == -1) throw new InvalidOperationException("Invalid Button Command Arguments");

        string[] aux = btn.CommandArgument.Split("_$_".ToCharArray());
        nif = aux[0];
        idTipoContacto = Convert.ToInt32(aux[aux.Length -1]);        
    }

    protected void rptContactosDataBound(object sender, RepeaterItemEventArgs e)
    {
        DropDownList tipoContacto = (DropDownList)e.Item.FindControl("ddbTipoContacto");

        if (tipoContacto != null)
        {
            TitularContacto record = (TitularContacto)e.Item.DataItem;

            SqlDataReader dr = null;
            db.RecordSet("select IdTipoContacto, descricao from LkTipoContacto order by descricao", out dr);
            tipoContacto.DataSource = dr;
            tipoContacto.DataTextField = "descricao";
            tipoContacto.DataValueField = "IdTipoContacto";
            tipoContacto.DataBind();
            tipoContacto.Items.FindByValue(record.IdTipoContacto.ToString()).Selected = true;
            dr.Close();
            dr.Dispose();

            CheckBox r = (CheckBox)e.Item.FindControl("ckbPreferencial");
            r.Checked = record.Preferencial;

            Button btn = (Button)e.Item.FindControl("btnAlterar");
            btn.CommandArgument = GetContactoCommonArguments(txbNif.Text, record.IdTipoContacto);
            btn = (Button)e.Item.FindControl("btnApagar");
            btn.CommandArgument = GetContactoCommonArguments(txbNif.Text, record.IdTipoContacto);

            TextBox contacto = (TextBox)e.Item.FindControl("txbContacto");
            contacto.Text = record.Contacto;
       }
    }

    protected void AddNewContacto(string nif, int idTipoContacto, string contacto, bool preferencial)
    {
        SqlParameter[] prams = new SqlParameter[4]{ 
                db.MakeInParam( "@nifTitular", System.Data.SqlDbType.VarChar, 9, nif)
                ,db.MakeInParam( "@IdTipoContacto", System.Data.SqlDbType.Int, 10, idTipoContacto)
                ,db.MakeInParam( "@contacto", System.Data.SqlDbType.VarChar, 100, contacto)
                ,db.MakeInParam( "@iPreferencial", System.Data.SqlDbType.Bit,1, preferencial)                
            };

        db.ExecProc("u_sp_titularcontacto_add", prams);
    }

    protected bool TitularExist(string nif)    
    {
        SqlDataReader dr = null;
        SqlParameter[] prams = new SqlParameter[1] { db.MakeInParam("@nif", System.Data.SqlDbType.VarChar, 9, nif) };
        db.RecordSet("select 1 from Titular where nif = @nif", prams, out dr);
        bool exist = dr.Read();
        dr.Close();
        dr.Dispose();

        return exist;
    }

    protected void btnAdicionarNovocontactoOnClick(object sender, EventArgs e)
    {
        if (txbNovoContacto.Text.Length == 0)
        {
            txbNovoContacto.BackColor = System.Drawing.Color.Red;
            return;
        }

        txbNovoContacto.BackColor = System.Drawing.Color.White;


        if (TitularExist(txbNif.Text))
        {
            AddNewContacto(txbNif.Text, Convert.ToInt32(ddbNovoTipoContacto.SelectedValue), txbNovoContacto.Text, ckbNovoPreferencial.Checked);
            BindContacto(txbNif.Text);
        }
        else
        {
            if (ContactosTempBuffer == null) ContactosTempBuffer = new List<TitularContacto>();
            ContactosTempBuffer.Add(new TitularContacto(Convert.ToInt32(ddbNovoTipoContacto.SelectedValue), txbNovoContacto.Text, ckbNovoPreferencial.Checked));
        }

        txbNovoContacto.Text = string.Empty;
        ckbNovoPreferencial.Checked = false;
    }
}

public class TitularContacto
{
    public int IdTipoContacto;
    public string Contacto;
    public bool Preferencial;

    public TitularContacto(int idTipoContacto, string contacto, bool preferencial)
    {
        IdTipoContacto = idTipoContacto;
        Contacto = contacto;
        Preferencial = preferencial;
    }



}
