using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data.SqlClient;
using System.Web.SessionState;


namespace fileclient
{
    /// <summary>
    /// Summary description for Handler1
    /// </summary>
    public class Handler1 : IHttpHandler, System.Web.SessionState.IRequiresSessionState 
    {
        public string foldername;
        public void ProcessRequest(HttpContext context)
        {
            FTPServer FTP = new FTPServer();

            context.Response.ContentType = "text/plain";

            string dirFullPath = HttpContext.Current.Server.MapPath("~/upload/");
            string[] files;
            int numFiles;
            files = System.IO.Directory.GetFiles(dirFullPath);
            numFiles = files.Length;
            numFiles = numFiles + 1;
            
            string User_Name = context.Session["username"].ToString();

            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                string path = Path.GetDirectoryName(file.FileName);
                string folderpath = context.Request.Form["foldername"];
                foldername = folderpath.Replace(file.FileName, "").Replace("/", "");
                string fileName = file.FileName;
                string fileExtension = file.ContentType;

                string dir = HttpContext.Current.Server.MapPath("/upload/") + foldername;
                var directory = new DirectoryInfo(dir);
                if (directory.Exists == false)
                {
                    directory.Create();
                }

                if (!string.IsNullOrEmpty(fileName))
                {
                    fileExtension = Path.GetExtension(fileName);
                    string pathToSave_100 = dir + "\\" + fileName;
                    file.SaveAs(pathToSave_100);
                }
            }

            OrderCreation(foldername, User_Name);
        }

        public void OrderCreation(string FolderName, string UserName)
        {
            DateTime sysDate = DateTime.Now;
            string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "select count(*) FolderCount from [Order_Details] where [Order_Name] = '" + FolderName + "' and [Ordered_Date] = '" + sysDate.ToString("dd-MM-yyyy") + "' and [User_Name] = '" + UserName.Trim() + "' ";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr[0].ToString() == "0")
                    {
                        using (var con1 = new SqlConnection(conString))
                        {
                            con1.Open();
                            string query1 = "INSERT INTO [Order_Details]([Order_Name],[Order_Status],[Order_Priority],[Ordered_Date],[User_Name]) values('" + FolderName + "', 'New','Normal','" + sysDate.ToString("dd-MM-yyyy") + "','" + UserName.Trim() + "')";
                            SqlCommand cmd1 = new SqlCommand(query1, con1);
                            cmd1.ExecuteNonQuery();
                        }
                    }
                    else if (Convert.ToInt32(dr[0].ToString()) > 0)
                    {
                        // ALERT
                    }
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}