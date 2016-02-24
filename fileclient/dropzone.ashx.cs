using System;
using System.Web;
using System.IO;
using System.Drawing;
namespace fileclient
{
    /// <summary>
    /// Summary description for dropzone
    /// </summary>
    public class dropzone : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string dirFullPath = HttpContext.Current.Server.MapPath("~/upload/");
            string[] files;
            int numFiles;
            files = System.IO.Directory.GetFiles(dirFullPath);
            numFiles = files.Length;
            numFiles = numFiles + 1;

            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                string path = Path.GetDirectoryName(file.FileName);
                string folderpath = context.Request.Form["foldername"];
                string foldername = folderpath.Replace(file.FileName, "").Replace("/","");
                string fileName = file.FileName;
                string fileExtension = file.ContentType;

                string dir = HttpContext.Current.Server.MapPath("~/upload/") + foldername;
                var directory = new DirectoryInfo(dir);
                if (directory.Exists == false)
                {
                    directory.Create();
                }


                if (!string.IsNullOrEmpty(fileName))
                {
                    fileExtension = Path.GetExtension(fileName);
                    string pathToSave_100 = dir +"\\"+ fileName;
                    file.SaveAs(pathToSave_100);
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