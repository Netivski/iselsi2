﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


public partial class ListaTitular : Persistence.DbWebPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) BindList();
    }

    void BindList()
    {
        SqlDataReader dr = null;
        db.RecordSet("select nome, nif from Titular order by nome, nif", out dr);
        rptClientList.DataSource = dr;
        rptClientList.DataBind();
    }
}
