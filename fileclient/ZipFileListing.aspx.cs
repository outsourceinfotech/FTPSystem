using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.IO.Compression;
using Ionic.Zip;

namespace fileclient
{
    public partial class ZipFileListing : System.Web.UI.Page
    {
        public ZipFile zipFile;
        FTPServer FTP = new FTPServer();
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var webClient = new WebClient())
            {
                MemoryStream memoryStream = new MemoryStream();
                string FileName = "SampleUpload.zip";
                memoryStream = FTP.downloadFileZip(FileName);
                memoryStream.Seek(0, SeekOrigin.Begin);
                using (zipFile = ZipFile.Read(memoryStream))
                {
                    fileRpt.DataSource = zipFile.Entries;
                    fileRpt.DataBind();


                    //StringBuilder html = new StringBuilder();
                    //foreach (ZipEntry entry in zipFile.Entries)
                    //{
                    //    html.AppendLine("<tr>");
                    //    html.AppendFormat("<td>{0}</td>", entry.FileName);
                    //    html.AppendFormat("<td>{0}</td>", entry.CompressedSize);
                    //    html.AppendFormat("<td>{0}</td>", entry.CompressionLevel);
                    //    html.AppendFormat("<td>{0}</td>", entry.CompressionMethod);
                    //    html.AppendFormat("<td><input type='button' class='btn btn-primary dwnfilebtn' data-link='{0}' id='dwnfilebtn' value='Download' /></td>",entry.FileName);
                    //    html.AppendLine("</tr>");
                       

                    //    if (!entry.IsDirectory)
                    //    {
                    //        using (MemoryStream ms = new MemoryStream())
                    //        {
                    //            entry.Extract(ms);
                    //        }
                    //    }
                    //}

                    //ZipDataTables.Controls.Add(new Literal { Text = html.ToString() });
                }
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            string filename = (sender as LinkButton).CommandArgument;
            using (MemoryStream ms = new MemoryStream())
            {
                ZipEntry entry = zipFile[filename];
                entry.Extract(ms);
                byte[] bytes = ms.GetBuffer();
                Response.Buffer = true;
                Response.Clear();
                //Response.ContentType = "image/*";
                Response.AddHeader("content-disposition", "attachment;filename= " + entry.FileName);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(ms.ToArray());
                Response.End();
            }

        }
    }
}