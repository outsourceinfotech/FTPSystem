using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Google.Apis.Drive.v2.Data;
using System.Drawing;
using System.Net;
using System.Text;

namespace fileclient
{
    public partial class order_info : System.Web.UI.Page
    {
        GoogleDrive GD = new GoogleDrive();
        public string ordid;
        public static string Foldername;
        string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";

        protected void Page_Load(object sender, EventArgs e)
        {
            ordid = Request.QueryString["orderid"];

            string query = "SELECT * FROM [Order_Details] WHERE [Order_ID]='" + Request.QueryString["orderid"] + "'";
            string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            rptOrderDetails.DataSource = dt;
                            rptOrderDetails.DataBind();

                            foreach (DataRow row in dt.Rows)
                            {
                                Foldername = row["folderpath"].ToString();
                            }
                        }
                    }
                }
            }

            display_Image(Request.QueryString["orderid"].ToString());

            //StringBuilder html = new StringBuilder();
            //FileList files = GD.ListofFiles(Foldername);

            //if (files.Items != null && files.Items.Count > 0)
            //{
            //    foreach (var file in files.Items)
            //    {
            //        string preview = "https://docs.google.com/uc?id=" +file.Id + "&export=view";
            //        html.AppendFormat("<li class='col-md-1' style='padding-bottom:10px' data-src='{0}'>", preview);
            //        html.AppendFormat("<a href=''>");
            //        html.AppendFormat("<img class='img-responsive' src='{0}'/>", file.ThumbnailLink);
            //        html.AppendFormat("</a>");
            //        html.AppendFormat("</li>");
            //    }
            //}

           // GalleryHolder.Controls.Add(new Literal { Text = html.ToString() });
        }

        public void display_Image(string OrderID)
        {
            string FolderName = getFolderName(OrderID);
            Session["foldername"] = FolderName;

            DataTable files = new DataTable();

            files.Columns.Add("Order_ID", typeof(string));
            files.Columns.Add("Image", typeof(string));
            files.Columns.Add("FileName", typeof(string));
            files.Columns.Add("Priority", typeof(string));
            files.Columns.Add("Temp_Image", typeof(string));
            files.Columns.Add("ISMarked", typeof(string));

            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "Select * from [dbo].[FileDetails] where [Order_ID] = '" + OrderID + "' and [IsMarkedFile] = 'N' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    DataRow dtrow = files.NewRow();

                    dtrow["Order_ID"] = OrderID;
                    dtrow["Image"] = "ftp://username:password@103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/" + dr["FileName"].ToString();
                    dtrow["FileName"] = dr["FileName"].ToString();

                    using (var con1 = new SqlConnection(conString))
                    {
                        con1.Open();
                        string query1 = "Select count(*) from [dbo].[FileDetails] where [Order_ID] = '" + OrderID + "' and CONVERT(VARCHAR,[FileName]) = '" + dr["FileName"].ToString() + "' and [IsMarkedFile] = 'Y' ";
                        SqlCommand cmd1 = new SqlCommand(query1, con1);
                        SqlDataReader dr1 = cmd1.ExecuteReader();
                        if (dr1.Read())
                        {
                            if (dr1[0].ToString() == "0")
                            {
                                dtrow["Temp_Image"] = "ftp://username:password@103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/" + dr["FileName"].ToString();
                                dtrow["ISMarked"] = "";
                            }
                            else
                            {

                                dtrow["Temp_Image"] = "ftp://username:password@103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/Marked_" + dr["FileName"].ToString();
                                dtrow["ISMarked"] = "Marked";
                            }
                        }
                    }

                    dtrow["Priority"] = dr["FilePriority"].ToString();

                    files.Rows.Add(dtrow);
                }

                DataList1.DataSource = files;
                DataList1.DataBind();
            }
        }

        protected string getFolderName(string OrderID)
        {
            string Folder_Name = "";

            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "Select [Order_Name] from [Order_Details] where [Order_ID] = '" + OrderID + "' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Folder_Name = dr["Order_Name"].ToString();
                }
                return Folder_Name;
            }
        }
    }
}