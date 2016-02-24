using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Text;

namespace fileclient
{
    public class FTPServer
    {
        public static string ftpAddress = "ftp://103.237.59.251/ftp_shares/Yuvaraj/";
        public string login = "Yuvaraj";
        public string password = "SEO@123";
        private byte[] downloadedData;

        public void CreateFolder(string[] FolderName, string[] DynamicName)
        {
            string currentDir = ftpAddress;
            foreach (string subDir in FolderName)
            {
                currentDir = currentDir + "/" + subDir;

                try
                {
                    FtpWebRequest requestDir = (FtpWebRequest)FtpWebRequest.Create(new Uri(currentDir));
                    requestDir.Method = WebRequestMethods.Ftp.MakeDirectory;
                    requestDir.Credentials = new NetworkCredential(login, password);
                    requestDir.UsePassive = true;
                    requestDir.UseBinary = true;
                    requestDir.KeepAlive = false;
                    FtpWebResponse response = (FtpWebResponse)requestDir.GetResponse();
                    Stream ftpStream = response.GetResponseStream();

                    ftpStream.Close();
                    response.Close();
                }
                catch (WebException ex)
                {
                    FtpWebResponse response = (FtpWebResponse)ex.Response;
                    if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                    {
                        response.Close();
                    }
                    else
                    {
                        response.Close();
                    }
                }
            }

            try
            {
                string StrUpload = currentDir + "/TO DO";

                FtpWebRequest requestDir = (FtpWebRequest)FtpWebRequest.Create(new Uri(StrUpload));
                requestDir.Method = WebRequestMethods.Ftp.MakeDirectory;
                requestDir.Credentials = new NetworkCredential(login, password);
                requestDir.UsePassive = true;
                requestDir.UseBinary = true;
                requestDir.KeepAlive = false;
                FtpWebResponse response = (FtpWebResponse)requestDir.GetResponse();
                Stream ftpStream = response.GetResponseStream();

                ftpStream.Close();
                response.Close();

                foreach (string subDir in DynamicName)
                {
                    try
                    {
                        FtpWebRequest requestInnerDir = (FtpWebRequest)FtpWebRequest.Create(new Uri(StrUpload + "/" + subDir));
                        requestInnerDir.Method = WebRequestMethods.Ftp.MakeDirectory;
                        requestInnerDir.Credentials = new NetworkCredential(login, password);
                        requestInnerDir.UsePassive = true;
                        requestInnerDir.UseBinary = true;
                        requestInnerDir.KeepAlive = false;
                        FtpWebResponse responseDir = (FtpWebResponse)requestInnerDir.GetResponse();
                        Stream ftpStreamDir = responseDir.GetResponseStream();

                        ftpStreamDir.Close();
                        response.Close();
                    }
                    catch (WebException ex)
                    {
                        FtpWebResponse responseDire = (FtpWebResponse)ex.Response;
                        if (responseDire.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                        {
                            responseDire.Close();
                        }
                        else
                        {
                            responseDire.Close();
                        }
                    }
                }
            }

            catch (WebException ex)
            {
                FtpWebResponse response = (FtpWebResponse)ex.Response;
                if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                {
                    response.Close();
                }
                else
                {
                    response.Close();
                }
            }

            try
            {
                string StrDownload = currentDir + "/Completed";

                FtpWebRequest requestDir = (FtpWebRequest)FtpWebRequest.Create(new Uri(StrDownload));
                requestDir.Method = WebRequestMethods.Ftp.MakeDirectory;
                requestDir.Credentials = new NetworkCredential(login, password);
                requestDir.UsePassive = true;
                requestDir.UseBinary = true;
                requestDir.KeepAlive = false;
                FtpWebResponse response = (FtpWebResponse)requestDir.GetResponse();
                Stream ftpStream = response.GetResponseStream();

                ftpStream.Close();
                response.Close();
            }

            catch (WebException ex)
            {
                FtpWebResponse response = (FtpWebResponse)ex.Response;
                if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                {
                    response.Close();
                }
                else
                {
                    response.Close();
                }
            }
        }

        public void deleteDirectory(string path)
        {
            FtpWebRequest clsRequest = (System.Net.FtpWebRequest)WebRequest.Create(path);
            clsRequest.Credentials = new System.Net.NetworkCredential(login, password);
            List<string> filesList = DirectoryListing(path, login, password);

            foreach (string file in filesList)
            {
                DeleteFTPFile(path + file, login, password);
            }

            clsRequest.Method = WebRequestMethods.Ftp.RemoveDirectory;

            string result = string.Empty;
            FtpWebResponse response = (FtpWebResponse)clsRequest.GetResponse();
            long size = response.ContentLength;
            Stream datastream = response.GetResponseStream();
            StreamReader sr = new StreamReader(datastream);
            result = sr.ReadToEnd();
            sr.Close();
            datastream.Close();
            response.Close();
        }

        public static List<string> DirectoryListing(string Path, string login, string password)
        {
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(Path);
            request.Credentials = new System.Net.NetworkCredential(login, password);
            request.Method = WebRequestMethods.Ftp.ListDirectory;
            FtpWebResponse response = (FtpWebResponse)request.GetResponse();
            Stream responseStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(responseStream);
            List<string> result = new List<string>();
            while (!reader.EndOfStream)
            {
                result.Add(reader.ReadLine());
            }
            reader.Close();
            response.Close();

            return result;
        }

        public static void DeleteFTPFile(string Path, string Login, string Password)
        {
            FtpWebRequest clsRequest = (System.Net.FtpWebRequest)WebRequest.Create(Path);
            clsRequest.Credentials = new System.Net.NetworkCredential(Login, Password);

            clsRequest.Method = WebRequestMethods.Ftp.DeleteFile;

            string result = string.Empty;
            FtpWebResponse response = (FtpWebResponse)clsRequest.GetResponse();
            long size = response.ContentLength;
            Stream datastream = response.GetResponseStream();
            StreamReader sr = new StreamReader(datastream);
            result = sr.ReadToEnd();
            sr.Close();
            datastream.Close();
            response.Close();
        }
        public void Folder(string url)
        {
            try
            {
                FtpWebRequest requestDir = (FtpWebRequest)FtpWebRequest.Create(url);
                requestDir.Method = WebRequestMethods.Ftp.MakeDirectory;
                requestDir.Credentials = new NetworkCredential(login, password);
                requestDir.UsePassive = true;
                requestDir.UseBinary = true;
                requestDir.KeepAlive = false;
                FtpWebResponse response = (FtpWebResponse)requestDir.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                ftpStream.Close();
                response.Close();

            }
            catch (WebException ex)
            {
                FtpWebResponse response = (FtpWebResponse)ex.Response;
                if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                {
                    response.Close();
                }
                else
                {
                    response.Close();
                }
            }
        }
        public DataTable FileView(string Source)
        {
            try
            {
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpAddress + @Source);
                request.Method = WebRequestMethods.Ftp.ListDirectory;

                request.Credentials = new NetworkCredential(login, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.EnableSsl = false;

                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                List<string> entries = new List<string>();
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    entries = reader.ReadToEnd().Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries).ToList();
                }
                response.Close();

                //Create a DataTable.
                DataTable dtFiles = new DataTable();
                dtFiles.Columns.AddRange(new DataColumn[2] { new DataColumn("Name", typeof(string)), new DataColumn("View", typeof(string)) });

                //Loop and add details of each File to the DataTable.
                foreach (string entry in entries)
                {
                    dtFiles.Rows.Add();
                    dtFiles.Rows[dtFiles.Rows.Count - 1]["Name"] = entry;
                    dtFiles.Rows[dtFiles.Rows.Count - 1]["View"] = ftpAddress + @Source + entry;
                }

                return dtFiles;
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
        }

        public void UploadFileToFTP(string source, string destination)
        {
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpAddress + "/" + destination + Path.GetFileName(source));
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(login, password);
            request.UsePassive = true;
            request.UseBinary = true;
            request.KeepAlive = false;
            byte[] bytes = System.IO.File.ReadAllBytes(source);
            request.ContentLength = bytes.Length;
            using (Stream request_stream = request.GetRequestStream())
            {
                request_stream.Write(bytes, 0, bytes.Length);
                request_stream.Close();
            }
        }


        public bool UploadToFTP(HttpPostedFile fileToUpload, string destination)
        {
           
            string fileName = fileToUpload.FileName;
            FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpAddress + "/" + destination + fileName);
            request.Method = WebRequestMethods.Ftp.UploadFile;
            request.Credentials = new NetworkCredential(login, password);
            request.UsePassive = true;
            request.UseBinary = true;
            request.KeepAlive = false;

            // Copy the contents of the file to the request stream.
            StreamReader sourceStream = new StreamReader(fileToUpload.InputStream);
            byte[] fileContents = Encoding.UTF8.GetBytes(sourceStream.ReadToEnd());
            sourceStream.Close();
            request.ContentLength = fileContents.Length;
            using (Stream request_stream = request.GetRequestStream())
            {
                request_stream.Write(fileContents, 0, fileContents.Length);
                request_stream.Close();
            }
            return true;
        }
        public byte[] downloadFile(string FilePath)
        {
            downloadedData = new byte[0];
            try
            {
                FtpWebRequest request = FtpWebRequest.Create(@FilePath) as FtpWebRequest;
                request = FtpWebRequest.Create(@FilePath) as FtpWebRequest;
                request.Method = WebRequestMethods.Ftp.DownloadFile;
                request.Credentials = new NetworkCredential(login, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false; //close the connection when done

                FtpWebResponse response = request.GetResponse() as FtpWebResponse;
                Stream reader = response.GetResponseStream();
                MemoryStream memStream = new MemoryStream();
                byte[] buffer = new byte[1024]; //downloads in chuncks
                while (true)
                {
                    int bytesRead = reader.Read(buffer, 0, buffer.Length);
                    if (bytesRead == 0)
                    { break; }
                    else
                    { memStream.Write(buffer, 0, bytesRead); }
                }

                downloadedData = memStream.ToArray();
                reader.Close();
                memStream.Close();
                response.Close();
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }

            return downloadedData;
        }

        public List<string> GetFileList(string source)
        {
            try
            {
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftpAddress + @source);
                request.Method = WebRequestMethods.Ftp.ListDirectory;
                request.Credentials = new NetworkCredential(login, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.EnableSsl = false;
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                List<string> entries = new List<string>();
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    entries = reader.ReadToEnd().Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries).ToList();
                }
                response.Close();

                return entries;
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
        }

        public void Download(string source, string file, string Foldername)
        {
            try
            {
                FtpWebRequest request;
                request = FtpWebRequest.Create(ftpAddress + @source + file) as FtpWebRequest;
                request.Method = WebRequestMethods.Ftp.DownloadFile;
                request.Credentials = new NetworkCredential(login, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false; //close the connection when done

                //Streams
                FtpWebResponse response = request.GetResponse() as FtpWebResponse;
                Stream responseStream = response.GetResponseStream();

                string path = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

                FileStream writeStream = new FileStream(@path + @"\" + Foldername + @"\" + file, FileMode.Create);
                int Length = 2048;
                Byte[] buffer = new Byte[Length];
                int bytesRead = responseStream.Read(buffer, 0, Length);
                while (bytesRead > 0)
                {
                    writeStream.Write(buffer, 0, bytesRead);
                    bytesRead = responseStream.Read(buffer, 0, Length);
                }
                writeStream.Close();
                response.Close();
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
        }

        public List<string> getDirectorylist(string source)
        {
            FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(ftpAddress + @source);
            ftpRequest.Credentials = new NetworkCredential(login, password);
            ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;
            FtpWebResponse response = (FtpWebResponse)ftpRequest.GetResponse();
            StreamReader streamReader = new StreamReader(response.GetResponseStream());

            List<string> directories = new List<string>();

            string line = streamReader.ReadLine();
            while (!string.IsNullOrEmpty(line))
            {
                directories.Add(line);
                line = streamReader.ReadLine();
            }

            streamReader.Close();
            return directories;
        }


        public MemoryStream downloadFileZip(string filename)
        {
            MemoryStream memStream = new MemoryStream();
            try
            {
                FtpWebRequest request = FtpWebRequest.Create(ftpAddress + filename) as FtpWebRequest;
                request.Method = WebRequestMethods.Ftp.DownloadFile;
                request.Credentials = new NetworkCredential(login, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false; //close the connection when done

                FtpWebResponse response = request.GetResponse() as FtpWebResponse;
                Stream reader = response.GetResponseStream();
                byte[] buffer = new byte[1024]; //downloads in chuncks
                //memStream.Seek(0, SeekOrigin.Begin);
                while (true)
                {
                    int bytesRead = reader.Read(buffer, 0, buffer.Length);
                    if (bytesRead == 0)
                    {
                        break;
                    }
                    else
                    {
                        memStream.Write(buffer, 0, bytesRead);
                    }
                }
                reader.Close();
                //memStream.Close();
                response.Close();
            }
            catch (WebException ex)
            {
                throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
            }
            return memStream;
        }
      
    }
}