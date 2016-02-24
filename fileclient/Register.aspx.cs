using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fileclient
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);

            {
                // Check username exists
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from User_Registration where User_Name = '" + user_name.Text + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    if (dr["User_Name"].ToString() == user_name.Text)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username has been already Registered .')", true);
                    }
                }
                else
                {
                    //chech email exists
                    dr.Close();
                    SqlCommand cmd1 = new SqlCommand("select * from User_Registration where User_Email = '" + Email.Text + "' ", con);
                    SqlDataReader dr1 = cmd1.ExecuteReader();

                    if (dr1.HasRows)
                    {
                        dr1.Read();
                        if (dr1["User_Email"].ToString() == Email.Text)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Email has been already Registered .')", true);
                        }
                    }
                    else
                    {
                        dr1.Close();
                        SqlCommand cmd2 = new SqlCommand("insert into User_Registration (User_Name,User_Email,User_Password,Created_Date) values('" + user_name.Text + "','" + Email.Text + "','" + password.Text + "',GETDATE())", con);
                        cmd2.ExecuteNonQuery();
                        con.Close();
                        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Registration Successfull');window.location ='Login.aspx';", true);

                    }

                }
                con.Close();
            }
        }
    }
}