using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class ListarTitularIncumprimento : Persistence.DbWebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindList();
    }

    void BindList()
    {
        SqlDataReader dr = null;
        db.RecordSet("select * from vTitularIncumprimento order by nome, totalmntincumprimento", out dr);
        rptClientIncumprimentoList.DataSource = dr;
        rptClientIncumprimentoList.DataBind();
    }
}
