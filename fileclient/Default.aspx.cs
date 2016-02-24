using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WinSCP;

namespace fileclient
{
    public partial class Default : System.Web.UI.Page
    {
        string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
        public long Total_Folder_Count = 0;
        public long Total_File_Count = 0;
        public long Cancel_Order_Count = 0;
        public long Completed_Order_Count = 0;
        public long Editing_Order_Count = 0;
        public long Uploaded_Order_Count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Folder count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT count(*) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Total_Folder_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

            //File count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT SUM([File_Count]) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Total_File_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

            //Completed Order count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT count(*) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' and [Order_Status] = 'Completed' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Completed_Order_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

            //Cancel Order count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT count(*) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' and [Order_Status] = 'Cancelled' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Cancel_Order_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

            //Editing Order count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT count(*) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' and [Order_Status] = 'Editing' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Editing_Order_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

            //Editing Order count
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT count(*) FROM [dbo].[Order_Details] WHERE [User_Name] ='" + Session["username"] + "' and [Order_Status] = 'Uploaded' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Uploaded_Order_Count = Convert.ToInt64(dr[0]);
                }
                con.Close();
            }

        }
    }
}