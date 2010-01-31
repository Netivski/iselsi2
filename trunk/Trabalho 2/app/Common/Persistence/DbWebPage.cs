using System;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Text;

namespace Persistence
{
    public class DbWebPage: Page
    {
        static    string connectionString;
        protected Db     db;

        string ConnectionString
        {
            get
            {
                return connectionString;
            }
        }

        static DbWebPage()
        {
            connectionString = ConfigurationSettings.AppSettings["ConnectionString"];
        }

        public DbWebPage()
        {
            PreInit += new EventHandler(OpenConnection);
            Unload  += new EventHandler(CloseConnection);
        }

        void OpenConnection(object sender, EventArgs e)
        {
            db = new Db();
            db.Open(connectionString);
        }

        void CloseConnection(object sender, EventArgs e)
        {
            if (db != null) db.Close();
        }

        protected Control GetChildControl(Control ctrl, string clientId)
        {
            if (ctrl == null) return null;

            Control aux;
            foreach (Control c in ctrl.Controls)
            {
                if (string.Compare(c.ClientID, clientId) == 0) return c;

                if ((aux = GetChildControl(c, clientId)) != null)
                {
                    if (string.Compare(aux.ClientID, clientId) == 0) return aux;
                }
                
            }

            return null;
        }

        protected string GetCtrlNameFromBrother(Control brother, string sufix)
        {
            if( brother == null ) throw new ArgumentNullException("brother");

            StringBuilder rValue = new StringBuilder(); 
            string[] tmp = brother.ClientID.Split('_');
            for (int i = 0; i < tmp.Length - 1; i++)
            {
                rValue.AppendFormat( "{0}_", tmp[i]);
            }

            rValue.AppendFormat("{0}", sufix);

            return rValue.ToString();
        }

        protected void WriteControl( Control ctrl )
        {
            if (ctrl == null) return;

            Response.Write(string.Format("ctrl.ID = {0}; ctrl.ClienteId={1}<br/>", ctrl.ID, ctrl.ClientID));
            foreach (Control c in ctrl.Controls) WriteControl( c );
        }
    }
}
