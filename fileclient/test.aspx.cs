using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace fileclient
{
    public partial class test : System.Web.UI.Page
    {
        FTPServer FTP = new FTPServer();
        string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
        protected void Page_Load(object sender, EventArgs e)
        {
            string FilePath = Request.QueryString["imageData"];
            string Order_ID = Request.QueryString["orderid"];
            string File_Name = Request.QueryString["Temp_file_name"];
            Session["orderid"] = Order_ID;
            Session["FileName"] = File_Name;
            string base64String = "";

            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT [Order_Status],[Order_Name] FROM [Order_Details] where [Order_ID] = '" + Order_ID + "' ";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr["Order_Status"].ToString() == "Uploaded")
                    {
                        byte[] b = FTP.downloadFile(FilePath);
                        base64String = Convert.ToBase64String(b, 0, b.Length);
                    }
                    else if (dr["Order_Status"].ToString() == "New")
                    {
                        System.Drawing.Image img = System.Drawing.Image.FromFile(Server.MapPath(FilePath));
                        System.Drawing.ImageConverter imgCon = new System.Drawing.ImageConverter();
                        byte[] b = (byte[])imgCon.ConvertTo(img, typeof(byte[]));
                        base64String = Convert.ToBase64String(b, 0, b.Length);
                    }

                }
            }
            Session["img_data"] = base64String;
            Button2.Attributes.Add("onClick", "javascript:history.back(); return false;");
        }
       
        protected void Button2_Click(object sender, EventArgs e)
        {

        }
    }
}