using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fileclient
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/Default.aspx?user='" + Session["username"] + "'");
                }
                if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
                {
                    user_name.Text = Request.Cookies["UserName"].Value;
                    password.Attributes["value"] = Request.Cookies["Password"].Value;
                }
            }
        }

        protected void button_click(object sender, EventArgs e)
        {
            if (RememberMe.Checked)
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);

                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
            }
            else
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

            }
            Response.Cookies["UserName"].Value = user_name.Text.Trim();
            Response.Cookies["Password"].Value = password.Text.Trim();

            string constr = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sqry = "select * from User_Registration where User_Name = '" + user_name.Text + "' and User_Password= '" + password.Text + "'";
                SqlCommand cmd = new SqlCommand(sqry, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Session["username"] = dr["User_Name"].ToString();
                    if (dr["User_Name"].ToString() != null)
                    {
                        dr.Close();
                        SqlCommand cmd2 = new SqlCommand("UPDATE User_Registration SET Last_Login = GETDATE() WHERE User_Name = '" + user_name.Text + "'", con);
                        cmd2.ExecuteNonQuery();
                        Response.Redirect("~/Default.aspx");
                    }

                }
                else
                {
                    Label1.Visible = true;
                    Label1.Text = "UserName or Password Incorrect";
                }

                con.Close();
            }
        }
    }
}