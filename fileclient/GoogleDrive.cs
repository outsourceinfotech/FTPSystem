using System;
using System.Collections.Generic;
using System.Web;
using System.Threading.Tasks;
using System.Threading;
using System.Linq;
using System.IO;
using System.Text;
using Google;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Download;
using Google.Apis.Drive.v2;
using Google.Apis.Drive.v2.Data;
using Google.Apis.Logging;
using Google.Apis.Services;
using Google.Apis.Upload;
using Google.Apis.Util.Store;
using System.Net;
using System.ComponentModel;
using System.Diagnostics;
using System.IO.Compression;
using System.Drawing;    

namespace fileclient
{
    public class GoogleDrive
    {
        static string[] Scopes = { DriveService.Scope.Drive };
        static string parent_ID = "";
        static string ApplicationName = "outsource";
        static string credPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyDocuments);
        static  UserCredential credential = GoogleWebAuthorizationBroker.AuthorizeAsync(new ClientSecrets
            {
                ClientId = "649916736075-pnd0t96vi9on9l77k8c5bkvuo51c6j9h.apps.googleusercontent.com",
                ClientSecret = "uHsvo5zOqNHzncJGVukUE_D2"
            }, Scopes, "user", CancellationToken.None, new FileDataStore(credPath, true)).Result;

        static DriveService service = new DriveService(new BaseClientService.Initializer()
        {
            HttpClientInitializer = credential,
            ApplicationName = ApplicationName,
        });

        public GoogleDrive()
        {        
        
        }


        //  #String[] FileName = { Upper of Client Name,year,month,day,ToUpper of Order ID};
        public void Create_Folder(string[] FileName)
        {
            if (FileName.Length != 0)
            {
                for (int i = 0; i < FileName.Length; i++)
                {
                    //string folderId = GetFolderID(FileName[i]);

                    List<Google.Apis.Drive.v2.Data.File> result = new List<Google.Apis.Drive.v2.Data.File>();
                    FilesResource.ListRequest request = service.Files.List();
                    string s = "mimeType='application/vnd.google-apps.folder' and trashed=false and title = '" + FileName[i] + "'";
                    if (parent_ID != "")
                    { s = s + " and '" + parent_ID + "' in parents"; }
                    request.Q = s;
                    Google.Apis.Drive.v2.Data.FileList fileList = request.Execute();
                    if (fileList.Items.Count != 0)
                    {
                        parent_ID = fileList.Items[0].Id;
                    }
                    else if (fileList.Items.Count == 0 && parent_ID != "")
                    {
                        Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
                        body.Title = FileName[i];
                        body.MimeType = "application/vnd.google-apps.folder";
                        body.Parents = new List<ParentReference>() { new ParentReference() { Id = parent_ID } };
                        Google.Apis.Drive.v2.Data.File file = service.Files.Insert(body).Execute();
                        parent_ID = file.Id;
                    }
                    else if (parent_ID == "" && fileList.Items.Count == 0)
                    {
                        Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
                        body.Title = FileName[i];
                        body.MimeType = "application/vnd.google-apps.folder";
                        Google.Apis.Drive.v2.Data.File file = service.Files.Insert(body).Execute();
                        parent_ID = file.Id;
                    }
                }
                parent_ID = "";
            }
        }
        // Root Folder Creation
        public string Single_Folder(string FolderName, string ParentID)
        {
            Google.Apis.Drive.v2.Data.File NewDirectory = null;
            Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
            body.Title = FolderName;
            body.MimeType = "application/vnd.google-apps.folder";
            body.Parents = new List<ParentReference>() { new ParentReference() { Id = ParentID } };

            FilesResource.InsertRequest request = service.Files.Insert(body);
            NewDirectory = request.Execute();
            return NewDirectory.Id.ToString();
        }   

        public string GetFolderID(string FolderName)
        {
            if(FolderName!="")
            {
                Google.Apis.Drive.v2.FilesResource.ListRequest request = service.Files.List();
                request.Q = "title = '" + FolderName + "'";
                Google.Apis.Drive.v2.Data.FileList files = request.Execute();
                if (files.Items.Count != 0)
                { return files.Items[0].Id; }
                else { return null; }
            }
            else { return null; }
        }


        //Folder Upload
        public bool FolderUpload(string FileFullPath, string Parent_ID, string FileName)
        {
            string Parent_folderId = Single_Folder(FileName, Parent_ID);
            //string s = System.IO.Path.GetFullPath(FileFullPath);
            string[] fileEntries = Directory.GetFiles(FileFullPath);

            for (int i = 0; i < fileEntries.Length; i++)
            {
                FileInfo fileInfo = new FileInfo(fileEntries[i].ToString());

                Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
                body.Title = fileInfo.Name;
                body.MimeType = getContent_Type(fileInfo.Extension);
                body.Parents = new List<ParentReference>() { new ParentReference() { Id = Parent_folderId } };

                byte[] byteArray = System.IO.File.ReadAllBytes(fileInfo.ToString());
                System.IO.MemoryStream stream = new System.IO.MemoryStream(byteArray);

                Google.Apis.Drive.v2.FilesResource.InsertMediaUpload request = service.Files.Insert(body, stream, getContent_Type(fileInfo.Extension));
                request.Upload();
            }

            return true;
        }
        // File Upload
        public void FileUpload(string FileFullPath, string Parent_folderId)
        {
            string FileType = getContent_Type(System.IO.Path.GetExtension(FileFullPath));
            //string Parent_folderId = Order_ID;
            if (System.IO.File.Exists(FileFullPath))
            {
                Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
                body.Title = System.IO.Path.GetFileName(FileFullPath);
                body.MimeType = FileType;
                body.Parents = new List<ParentReference>() { new ParentReference() { Id = Parent_folderId } };

                byte[] byteArray = System.IO.File.ReadAllBytes(FileFullPath);
                System.IO.MemoryStream stream = new System.IO.MemoryStream(byteArray);
                try
                {
                    Google.Apis.Drive.v2.FilesResource.InsertMediaUpload request = service.Files.Insert(body, stream, FileType);
                    request.Upload();
                }
                catch (Exception e)
                {
                    Console.WriteLine("An error occurred: " + e.Message);
                }
            }
            else
            { Console.WriteLine("File does not exist: " + FileFullPath); }
        }


        public void DropZoneUpload(HttpPostedFile fileupload, string dirPath)
        {
                Google.Apis.Drive.v2.Data.File body = new Google.Apis.Drive.v2.Data.File();
                body.Title = fileupload.FileName;
                body.MimeType = fileupload.ContentType;
                body.Parents = new List<ParentReference>() { new ParentReference() { Id = dirPath } };

                var binaryReader = new BinaryReader(fileupload.InputStream);
                byte[] byteArray = binaryReader.ReadBytes(fileupload.ContentLength);
                System.IO.MemoryStream stream = new System.IO.MemoryStream(byteArray);
                try
                {
                    Google.Apis.Drive.v2.FilesResource.InsertMediaUpload request = service.Files.Insert(body, stream, "image/*");
                    request.Upload();
                }
                catch (Exception e)
                {
                    Console.WriteLine("An error occurred: " + e.Message);
                }
         }


        // Get File MIME Type
        public string getContent_Type(string file_extension)
        {
            string contenttype = "";
            switch (file_extension.ToUpper())
            {
                case ".JPG":
                case ".PNG":
                    contenttype = "image/*";
                    break;
                
                case ".GIF":
                    contenttype = "image/gif";
                    break;
                case ".ZIP":
                    contenttype = "application/zip";
                    break;
                case "":
                    contenttype = "application/vnd.google-apps.folder";
                    break;
            }
            return contenttype;
        }

        // Get File List in a Folder
        public Google.Apis.Drive.v2.Data.FileList ListofFiles(string FolderId)
        {
            List<Google.Apis.Drive.v2.Data.File> result = new List<Google.Apis.Drive.v2.Data.File>();
            FilesResource.ListRequest request = service.Files.List();
            request.Q = "'" + FolderId + "' in parents  and trashed = false";
            Google.Apis.Drive.v2.Data.FileList fileList = request.Execute();
            return fileList;
        }

        public int FileCount(string Foldername)
        {
            string folderId = GetFolderID(Foldername);
            List<Google.Apis.Drive.v2.Data.File> result = new List<Google.Apis.Drive.v2.Data.File>();
            FilesResource.ListRequest request = service.Files.List();
            request.Q = "'" + folderId + "' in parents";
            Google.Apis.Drive.v2.Data.FileList fileList = request.Execute();
            return fileList.Items.Count;
        }

        // Get Folder Size
        public string FileSize(string FolderName)
        {
            string Unit = "";
            string folderId = GetFolderID(FolderName);
            double size = 0.0;
            double bytes = 0.0;
            List<Google.Apis.Drive.v2.Data.File> result = new List<Google.Apis.Drive.v2.Data.File>();
            FilesResource.ListRequest request = service.Files.List();
            request.Q = "'" + folderId + "' in parents  and trashed = false";
            Google.Apis.Drive.v2.Data.FileList fileList = request.Execute();
            for (int i = 0; i < fileList.Items.Count; i++)
            {
                Google.Apis.Drive.v2.Data.File File = service.Files.Get(fileList.Items[i].Id).Execute();
                bytes += Convert.ToDouble(File.FileSize);
            }

            if (bytes != 0)
            {
                const int byteConversion = 1024;
                if (bytes >= Math.Pow(byteConversion, 3)) //GB Range
                { size = Math.Round(bytes / Math.Pow(byteConversion, 3), 2); Unit = size + "GB"; }
                else if (bytes >= Math.Pow(byteConversion, 2)) //MB Range
                { size = Math.Round(bytes / Math.Pow(byteConversion, 2), 2); Unit = size + "MB"; }
                else if (bytes >= byteConversion) //KB Range
                { size = Math.Round(bytes / byteConversion, 2); Unit = size + "KB"; }
                else //Bytes
                { size = bytes; }
            }
            return Unit;
        }
        // Get Last Modified Date
        public DateTime LastModifiedDate(string FolderName)
        {
            string folderId = GetFolderID(FolderName);
            Google.Apis.Drive.v2.Data.File File = service.Files.Get(folderId).Execute();
            return Convert.ToDateTime(File.ModifiedDate);
        }

        // File Delete
        public void FileDelete(string FileName)
        {
            string FileID = GetFolderID(FileName);
            Google.Apis.Drive.v2.FilesResource.DeleteRequest DeleteRequest = service.Files.Delete(FileID);
            DeleteRequest.Execute();
        }

        // File Download
        public Image DownloadFile(string fileID)
        {
            //string fileID = GetFolderID(filename);
            var file = service.Files.Get(fileID).Execute();
            byte[] byteArrayIn = service.HttpClient.GetByteArrayAsync(file.DownloadUrl).Result;

            MemoryStream ms = new MemoryStream(byteArrayIn, 0, byteArrayIn.Length);
            ms.Position = 0; // this is important
            Image returnImage = Image.FromStream(ms, true);
            return returnImage;
        }

        public void DownloadFile_DownloadURL(string downloadURL)
        {
            var stream = service.HttpClient.GetStreamAsync(downloadURL);
            var result = stream.Result;


            byte[] byteArrayIn = service.HttpClient.GetByteArrayAsync(downloadURL).Result;

            MemoryStream ms = new MemoryStream(byteArrayIn, 0, byteArrayIn.Length);
            ms.Position = 0; // this is important
        }


        // Folder Download
        public void DownloadFolderToZip(string sOutFile)
        {
            FileList f = ListofFiles("test123");
            using (FileStream outFile = new FileStream(sOutFile, FileMode.Create, FileAccess.Write, FileShare.None))
            using (GZipStream zipStream = new GZipStream(outFile, CompressionMode.Compress))
                for (int i = 0; i < f.Items.Count; i++)
                {
                    var file = service.Files.Get(f.Items[i].Id).Execute();
                    //Compress file name
                    char[] chars = f.Items[i].Title.ToCharArray();
                    zipStream.Write(BitConverter.GetBytes(chars.Length), 0, sizeof(int));
                    foreach (char c in chars)
                        zipStream.Write(BitConverter.GetBytes(c), 0, sizeof(char));
                    //Compress file content
                    byte[] bytes = service.HttpClient.GetByteArrayAsync(file.DownloadUrl).Result;
                    zipStream.Write(BitConverter.GetBytes(bytes.Length), 0, sizeof(int));
                    zipStream.Write(bytes, 0, bytes.Length);
                }
        }

        public void DecompressToDirectory(string sCompressedFile, string sDir)
        {
            using (FileStream inFile = new FileStream(sCompressedFile, FileMode.Open, FileAccess.Read, FileShare.None))
            using (GZipStream zipStream = new GZipStream(inFile, CompressionMode.Decompress, true))
                while (DecompressFile(sDir, zipStream)) ;
        }

        static bool DecompressFile(string sDir, GZipStream zipStream)
        {
            //Decompress file name
            byte[] bytes = new byte[sizeof(int)];
            int Readed = zipStream.Read(bytes, 0, sizeof(int));
            if (Readed < sizeof(int))
                return false;

            int iNameLen = BitConverter.ToInt32(bytes, 0);
            bytes = new byte[sizeof(char)];
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < iNameLen; i++)
            {
                zipStream.Read(bytes, 0, sizeof(char));
                char c = BitConverter.ToChar(bytes, 0);
                sb.Append(c);
            }
            string sFileName = sb.ToString();
            //if (progress != null)
            // progress(sFileName);

            //Decompress file content
            bytes = new byte[sizeof(int)];
            zipStream.Read(bytes, 0, sizeof(int));
            int iFileLen = BitConverter.ToInt32(bytes, 0);

            bytes = new byte[iFileLen];
            zipStream.Read(bytes, 0, bytes.Length);

            string sFilePath = Path.Combine(sDir, sFileName);
            string sFinalDir = Path.GetDirectoryName(sFilePath);
            if (!Directory.Exists(sFinalDir))
                Directory.CreateDirectory(sFinalDir);

            using (FileStream outFile = new FileStream(sFilePath, FileMode.Create, FileAccess.Write, FileShare.None))
                outFile.Write(bytes, 0, iFileLen);

            return true;
        }

        public void File_download(string url)
        {
            string fileName = "abc";
            Stream stream = null;
            int bytesToRead = 10000;
            byte[] buffer = new Byte[bytesToRead];

            try
            {
                HttpWebRequest fileReq = (HttpWebRequest)HttpWebRequest.Create(url);
                HttpWebResponse fileResp = (HttpWebResponse)fileReq.GetResponse();
                if (fileReq.ContentLength > 0)
                    fileResp.ContentLength = fileReq.ContentLength;
                stream = fileResp.GetResponseStream();
                var resp = HttpContext.Current.Response;
                resp.ContentType = "image/jpeg";

                resp.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                resp.AddHeader("Content-Length", fileResp.ContentLength.ToString());
                int length;
                do
                {
                    if (resp.IsClientConnected)
                    {
                        // Read data into the buffer.
                        length = stream.Read(buffer, 0, bytesToRead);

                        // and write it out to the response's output stream
                        resp.OutputStream.Write(buffer, 0, length);

                        // Flush the data
                        resp.Flush();

                        //Clear the buffer
                        buffer = new Byte[bytesToRead];
                    }
                    else
                    {
                        // cancel the download if client has disconnected
                        length = -1;
                    }
                } while (length > 0);
            }
            finally
            {
                if (stream != null)
                {
                    //Close the input stream
                    stream.Close();
                }
            }
        }
    }
}