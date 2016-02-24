using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;
using System.Text;
using System.Data.SqlClient;
using System.Net;

namespace fileclient
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    //[System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";

        [WebMethod]
        public bool HelloWorld(string imgData, string filepath, string OrderId, string Editing_Notes)
        {
            string[] FilepathSplit = filepath.Split('/');
            string FolderName = FilepathSplit[FilepathSplit.Length - 2];
            string FileName = FilepathSplit[FilepathSplit.Length - 1];
            string ModifiedFileName = "";
            if (FileName.Contains("Marked_") == true)
            {
                ModifiedFileName = FileName;
            }
            else
            {
                ModifiedFileName = "Marked_" + FileName;
            }


            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT [Order_Status],[Order_Name] FROM [Order_Details] where [Order_ID] = '" + OrderId.Trim() + "' ";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr["Order_Status"].ToString() == "Uploaded")
                    {
                        FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderId.Trim() + "/" + dr["Order_Name"].ToString() + "/" + ModifiedFileName);
                        request.Method = WebRequestMethods.Ftp.UploadFile;
                        request.Credentials = new NetworkCredential("Yuvaraj", "SEO@123");
                        request.UsePassive = true;
                        request.UseBinary = true;
                        request.KeepAlive = false;
                        byte[] bytes = Convert.FromBase64String(imgData);
                        request.ContentLength = bytes.Length;
                        using (Stream request_stream = request.GetRequestStream())
                        {
                            request_stream.Write(bytes, 0, bytes.Length);
                            request_stream.Close();
                        }

                        using (var con1 = new SqlConnection(conString))
                        {
                            con1.Open();
                            string query1 = "INSERT INTO [dbo].[FileDetails]([Order_ID], [FileName], [FilePriority],[EditingNotes], [IsMarkedFile]) values('" + OrderId.Trim() + "','" + FileName + "', 'Normal', '" + Editing_Notes + "', 'Y')";
                            SqlCommand cmd1 = new SqlCommand(query1, con1);
                            cmd1.ExecuteNonQuery();
                            con1.Close();
                        }

                    }
                    else if (dr["Order_Status"].ToString() == "New")
                    {
                        string Pic_Path = HttpContext.Current.Server.MapPath("upload" + "\\" + FolderName + "\\" + ModifiedFileName);
                        using (FileStream fs = new FileStream(Pic_Path, FileMode.Create))
                        {
                            using (BinaryWriter bw = new BinaryWriter(fs))
                            {
                                byte[] data = Convert.FromBase64String(imgData);
                                bw.Write(data);
                                bw.Close();
                            }
                        }
                        if (FileName.Contains("Marked_") == false)
                        {
                            using (var con1 = new SqlConnection(conString))
                            {
                                con1.Open();
                                string query1 = "INSERT INTO [dbo].[Temp_FileDetails]([Order_ID], [FileName], [FilePriority],[EditingNotes], [IsMarkedFile]) values('" + OrderId.Trim() + "','" + FileName + "', 'Normal', '" + Editing_Notes + "', 'Y')";
                                SqlCommand cmd1 = new SqlCommand(query1, con1);
                                cmd1.ExecuteNonQuery();
                                con1.Close();
                            }
                        }



                    }

                }
            }

            return true;

            Context.Response.Redirect("upload.aspx");
        }
    }
}
