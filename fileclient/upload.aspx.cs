using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Net;
using System.Data.SqlClient;

namespace fileclient
{ 
    public partial class upload : System.Web.UI.Page
    {
        string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
        public static FTPServer FTP = new FTPServer();
        public string username = FTP.login;
        public string password = FTP.password;       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                OrderView();
                
                uploadall_button.Visible = false;
                if (DataListContent.Items.Count > 0)
                {
                    uploadall_button.Visible = true;
                    butUpload.Visible = true;
                    butCancel.Visible = true;
                    table_head.Visible = true;
                }
            }
        }
        protected void display_Image(object sender, EventArgs e)
        {
            string OrderID = ((Button)sender).CommandArgument.ToString();
            string FolderName = getFolderName(OrderID);
            Session["foldername"] = FolderName;

            DataTable files = new DataTable();

            files.Columns.Add("Order_ID", typeof(string));
            files.Columns.Add("Image", typeof(string));
            files.Columns.Add("FileName", typeof(string));
            files.Columns.Add("Priority", typeof(string));
            files.Columns.Add("Temp_Image", typeof(string));
            files.Columns.Add("ISMarked", typeof(string));

            DirectoryInfo objDir = new DirectoryInfo(Server.MapPath("~/upload/" + FolderName + "/"));

            // Before Upload 
            if (objDir.Exists)
            {
                using (var con = new SqlConnection(conString))
                {
                    con.Open();
                    string query = "Select * from [dbo].[Temp_FileDetails] where [Order_ID] = '" + OrderID + "' and [IsMarkedFile] = 'N' ";

                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        DataRow dtrow = files.NewRow();

                        dtrow["Order_ID"] = OrderID;
                        dtrow["Image"] = "/upload/" + FolderName + "/" + dr["FileName"].ToString();
                        dtrow["FileName"] = dr["FileName"].ToString();

                        using (var con1 = new SqlConnection(conString))
                        {
                            con1.Open();
                            string query1 = "Select count(*) from [dbo].[Temp_FileDetails] where [Order_ID] = '" + OrderID + "' and CONVERT(VARCHAR,[FileName]) = '" + dr["FileName"].ToString() + "' and [IsMarkedFile] = 'Y' ";
                            SqlCommand cmd1 = new SqlCommand(query1, con1);
                            SqlDataReader dr1 = cmd1.ExecuteReader();
                            if (dr1.Read())
                            {
                                if (dr1[0].ToString() == "0")
                                {
                                    dtrow["Temp_Image"] = "/upload/" + FolderName + "/" + dr["FileName"].ToString();
                                    dtrow["ISMarked"] = "";
                                }
                                else
                                {
                                    dtrow["Temp_Image"] = "/upload/" + FolderName + "/Marked_" + dr["FileName"].ToString();
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

            // After Upload
            else
            {
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

            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "imagemodal();", true);
        }
              
        protected void FTP_Upload(object sender, EventArgs e)
        {
            foreach (DataListItem item in DataListContent.Items)
            {
                CheckBox myCheckBox = (CheckBox)item.FindControl("CheckBox1");
                if (myCheckBox.Checked)
                {
                    var hD = (HiddenField)item.FindControl("HiddenField1");

                    string OrderID = hD.Value.Trim();
                    string FolderName = getFolderName(OrderID);

                    FTP.Folder("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID);
                    FTP.Folder("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName);

                    if (Directory.Exists(Server.MapPath("~/upload/" + FolderName + "/")))
                    {
                        string[] FileList = Directory.GetFiles(Server.MapPath("~/upload/" + FolderName + "/"));
                        for (var i = 0; i < FileList.Length; i++)
                        {
                            FileInfo MyFile = new FileInfo(FileList[i]);
                            string FileName = Path.GetFileName(MyFile.Name);

                            FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/" + FileName);
                            request.Method = WebRequestMethods.Ftp.UploadFile;
                            request.Credentials = new NetworkCredential("Yuvaraj", "SEO@123");
                            request.UsePassive = true;
                            request.UseBinary = true;
                            request.KeepAlive = false;
                            byte[] bytes = System.IO.File.ReadAllBytes(MyFile.FullName);
                            request.ContentLength = bytes.Length;
                            using (Stream request_stream = request.GetRequestStream())
                            {
                                request_stream.Write(bytes, 0, bytes.Length);
                                request_stream.Close();
                            }

                        }
                        StatusUpload(OrderID, FolderName, FileList.Length);
                        //OrderView();
                        FolderDelete(FolderName);
                    }
                    else
                    {
                        //Alert --> Folder not present
                    }
                    //File.Delete(file);
                }
            }
            OrderView();
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

        protected void FTP_Upload_All(object sender, EventArgs e)
        {
            DateTime sysDate = DateTime.Now;
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT [Order_Details].* FROM [Order_Details] where [Ordered_Date] = '" + sysDate.ToString("dd-MM-yyyy") + "' and [Order_Status] ='New' and [User_Name] = '" + Session["username"].ToString().Trim() + "' ";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string OrderID = dr["Order_ID"].ToString();
                    string FolderName = getFolderName(OrderID);

                    FTP.Folder("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID);
                    FTP.Folder("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName);

                    if (Directory.Exists(Server.MapPath("~/upload/" + FolderName + "/")))
                    {
                        string[] FileList = Directory.GetFiles(Server.MapPath("~/upload/" + FolderName + "/"));
                        for (var i = 0; i < FileList.Length; i++)
                        {
                            FileInfo MyFile = new FileInfo(FileList[i]);
                            string FileName = Path.GetFileName(MyFile.Name);

                            FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/" + FileName);
                            request.Method = WebRequestMethods.Ftp.UploadFile;
                            request.Credentials = new NetworkCredential("Yuvaraj", "SEO@123");
                            request.UsePassive = true;
                            request.UseBinary = true;
                            request.KeepAlive = false;
                            byte[] bytes = System.IO.File.ReadAllBytes(MyFile.FullName);
                            request.ContentLength = bytes.Length;
                            using (Stream request_stream = request.GetRequestStream())
                            {
                                request_stream.Write(bytes, 0, bytes.Length);
                                request_stream.Close();
                            }
                        }

                        StatusUpload(OrderID, FolderName, FileList.Length); // Status Update
                        OrderView();
                        FolderDelete(FolderName);
                    }
                    else
                    {
                        //Alert --> Folder not present
                    }
                }
            }
        }

        protected void Delete_Folder(object sender, EventArgs e)
        {
            foreach (DataListItem item in DataListContent.Items)
            {
                CheckBox myCheckBox = (CheckBox)item.FindControl("CheckBox1");
                if (myCheckBox.Checked)
                {
                    var hD = (HiddenField)item.FindControl("HiddenField1");
                    string OrderID = hD.Value.Trim();

                    string OrderStatus = "";
                    string FolderName = "";

                    using (var con = new SqlConnection(conString))
                    {
                        con.Open();
                        string query = "Select [Order_Status],[Order_Name] from [Order_Details] where [Order_ID] = '" + OrderID + "' ";

                        SqlCommand cmd = new SqlCommand(query, con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            OrderStatus = dr["Order_Status"].ToString();
                            FolderName = dr["Order_Name"].ToString();
                        }
                    }

                    if (OrderStatus == "Uploaded")
                    {
                        OrderCancelledUpdate(OrderID);
                        string path = "ftp://103.237.59.251/ftp_shares/Yuvaraj/" + OrderID + "/" + FolderName + "/";
                        FTP.deleteDirectory(path);
                    }
                    else if (OrderStatus == "New")
                    {
                        using (var con1 = new SqlConnection(conString))
                        {
                            con1.Open();
                            string query1 = "UPDATE [Order_Details] set [Order_Status] = 'Cancelled' where [Order_ID] = '" + OrderID + "' ";
                            SqlCommand cmd1 = new SqlCommand(query1, con1);
                            cmd1.ExecuteNonQuery();
                            con1.Close();
                        }

                        using (var con1 = new SqlConnection(conString))
                        {
                            con1.Open();
                            string query1 = "DELETE FROM [dbo].[Temp_FileDetails] where [Order_ID] = '" + OrderID + "' ";
                            SqlCommand cmd1 = new SqlCommand(query1, con1);
                            cmd1.ExecuteNonQuery();
                            con1.Close();
                        }
                        FolderDelete(FolderName);

                    }
                }
            }

            OrderView();

        }

        protected void OrderCancelledUpdate(string OrderID)
        {
            // Status update in Order_Details
            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "UPDATE [Order_Details] set [Order_Status] = 'Cancelled' where [Order_ID] = '" + OrderID + "' ";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }

            // Delete Folder Details
            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "DELETE FROM [FolderDetails] WHERE [FolderID] = '" + OrderID + "' ";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }

            // Delete File Details
            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "DELETE FROM [FileDetails] WHERE [Order_ID] = '" + OrderID + "' ";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }

        }

        protected void FolderDelete(string FolderName)
        {
            if (System.IO.Directory.Exists(Server.MapPath("~/upload/" + FolderName + "/")))
            {
                Directory.Delete(Server.MapPath("~/upload/" + FolderName + "/"), true);
            }
        }

        protected void OrderView()
        {
            DateTime sysDate = DateTime.Now;
            DataTable dt = new DataTable();
            dt.Columns.Add("OrderID", typeof(string));
            dt.Columns.Add("DirectoryName", typeof(string));
            dt.Columns.Add("FileCount", typeof(string));
            dt.Columns.Add("Priority", typeof(string));
            dt.Columns.Add("UploadStatus", typeof(string));
            string[] DirectoryList = Directory.GetDirectories(Server.MapPath("~/upload/"));

            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT [Order_Details].* FROM [Order_Details] where [Ordered_Date] = '" + sysDate.ToString("dd-MM-yyyy") + "' and [User_Name] = '" + Session["username"].ToString() +"' ";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    DataRow dtrow = dt.NewRow();
                    dtrow["OrderID"] = dr["Order_ID"].ToString();
                    dtrow["DirectoryName"] = dr["Order_Name"].ToString();
                    if (dr["File_Count"].ToString() == "")
                    {
                        string DirPath = Server.MapPath("~/upload/" + dr["Order_Name"].ToString() + "//");
                        if (Directory.Exists(DirPath))
                        {
                            using (var con1 = new SqlConnection(conString))
                            {
                                con1.Open();
                                string query1 = "UPDATE [Order_Details] set [File_Count] = '" + Directory.GetFiles(DirPath).Length.ToString() + "' where [Order_ID] = '" + dr["Order_ID"].ToString() + "' ";
                                SqlCommand cmd1 = new SqlCommand(query1, con1);
                                cmd1.ExecuteNonQuery();
                                con1.Close();
                            }

                            string[] FileList = Directory.GetFiles(Server.MapPath("~/upload/" + dr["Order_Name"].ToString() + "/"));
                            for (var i = 0; i < FileList.Length; i++)
                            {
                                FileInfo MyFile = new FileInfo(FileList[i]);
                                string FileName = Path.GetFileName(MyFile.Name);

                                using (var con1 = new SqlConnection(conString))
                                {
                                    con1.Open();
                                    string query1 = "INSERT INTO [dbo].[Temp_FileDetails]([Order_ID], [FileName], [FilePriority], [IsMarkedFile]) values('" + dr["Order_ID"].ToString() + "', '" + FileName + "', 'Normal', 'N')";
                                    SqlCommand cmd1 = new SqlCommand(query1, con1);
                                    cmd1.ExecuteNonQuery();
                                    con1.Close();
                                }
                            }

                            dtrow["FileCount"] = Directory.GetFiles(DirPath).Length.ToString();
                        }
                    }
                    else
                    {
                        dtrow["FileCount"] = dr["File_Count"].ToString();
                    }

                    dtrow["Priority"] = dr["Order_Priority"].ToString();
                    dtrow["UploadStatus"] = dr["Order_Status"].ToString();
                    dt.Rows.Add(dtrow);
                }
            }
            DataListContent.DataSource = dt;
            DataListContent.DataBind();

            foreach (DataListItem dli in DataListContent.Items)
            {
                //Button btn_edit = (Button)dli.FindControl("btn_edit");
                //if (btn_edit.CommandName == "Uploaded")
                //{
                //    btn_edit.Enabled = false;
                //}

                Button butOpen = (Button)dli.FindControl("btn_open");
                if (butOpen.CommandName == "Cancelled")
                {
                    butOpen.Enabled = false;
                    Button butEdit = (Button)dli.FindControl("btn_edit");
                    butEdit.Enabled = false;
                }
            }
        }
        
        protected void btnShowModal_Click(object sender, EventArgs e)
        {
            string Order_ID = ((Button)sender).CommandArgument.ToString();
            string FolderName = getFolderName(Order_ID);
            Session["folder"] = FolderName;

            DataTable dt = new DataTable();
            dt.Columns.Add("OrderID", typeof(string));
            dt.Columns.Add("DirectoryName", typeof(string));
            dt.Columns.Add("FileCount", typeof(Int32));
            dt.Columns.Add("Priority", typeof(string));
            dt.Columns.Add("EditingNotes", typeof(string));

            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "SELECT [Order_Details].* FROM [Order_Details] where [Order_ID] = '" + Order_ID + "' ";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    DataRow dtrow = dt.NewRow();
                    dtrow["OrderID"] = dr["Order_ID"].ToString();
                    dtrow["DirectoryName"] = dr["Order_Name"].ToString();
                    dtrow["FileCount"] = dr["File_Count"].ToString();
                    dtrow["Priority"] = dr["Order_Priority"].ToString();
                    dtrow["EditingNotes"] = dr["Comments"].ToString();
                    dt.Rows.Add(dtrow);
                }
            }
            
            DataList2.DataSource = dt;
            DataList2.DataBind();

            Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "foldermodal();", true);
            
        }

        protected void StatusUpload(string OrderID, string FolderName, int FileCount)
        {
            using (var con = new SqlConnection(conString))
            {
                con.Open();
                string query = "UPDATE [Order_Details] set [Order_Status] = 'Uploaded' where [Order_ID] = '" + OrderID + "' ";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
            }

            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "INSERT INTO [dbo].[FolderDetails]([FolderID], [FolderName], [FileCount]) values('" + OrderID + "', '" + FolderName + "', '" + FileCount + "')";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }

            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "INSERT INTO [dbo].[FileDetails] ([Order_ID], [FileName], [FilePriority],[EditingNotes], [IsMarkedFile]) SELECT [Order_ID], [FileName], [FilePriority],[EditingNotes],[IsMarkedFile] FROM [dbo].[Temp_FileDetails] WHERE [Order_ID] = '" + OrderID + "' ";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }

            using (var con1 = new SqlConnection(conString))
            {
                con1.Open();
                string query1 = "DELETE FROM [dbo].[Temp_FileDetails] WHERE [Order_ID] = '" + OrderID + "' ";
                SqlCommand cmd1 = new SqlCommand(query1, con1);
                cmd1.ExecuteNonQuery();
                con1.Close();
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Order_ID = ((Button)sender).CommandArgument.ToString();

            foreach (DataListItem item in DataList2.Items)
            {
                TextBox foldername = (TextBox)item.FindControl("TextBox1");
                DropDownList priority = (DropDownList)item.FindControl("EOrderPriority") as DropDownList;
                TextBox notes = (TextBox)item.FindControl("TextArea1");
                string name = foldername.Text;
                string order_priority = priority.SelectedValue;
                string E_notes = notes.Text;
               
                using (var con = new SqlConnection(conString))
                {
                    SqlCommand cmd1 = new SqlCommand("UPDATE [dbo].[Order_Details] SET [Order_Priority]='" + order_priority + "', [Comments]='" + E_notes + "' WHERE [Order_ID]='" + Order_ID.Trim() + "'", con);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }
            }
            OrderView();
        }
        protected void Editing_Submit(object sender, EventArgs e)
        {
            foreach (DataListItem item in DataList1.Items)
            {
                var hiddenData = (HiddenField)item.FindControl("HF_orderid");
                var hiddenData1 = (HiddenField)item.FindControl("HF_filename");
                string Ordder_ID = hiddenData.Value;
                string File_Name = hiddenData1.Value;
                string OrderStatus = "";
                var PriorityCtl = (DropDownList)item.FindControl("EOrderPriority");
                string Priority = PriorityCtl.SelectedValue;

                using (var con = new SqlConnection(conString))
                {
                    con.Open();
                    string query = "Select [Order_Status],[Order_Name] from [Order_Details] where [Order_ID] = '" + Ordder_ID.Trim() + "' ";

                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        OrderStatus = dr["Order_Status"].ToString();
                    }
                }
                if (OrderStatus == "Uploaded")
                {
                    using (var con = new SqlConnection(conString))
                    {
                        string query = "UPDATE [dbo].[FileDetails] SET [FilePriority]='" + Priority.Trim() + "' WHERE [Order_ID] = '" + Ordder_ID.Trim() + "' and CONVERT(VARCHAR,[FileName]) = '" + File_Name.Trim() + "' ";
                        SqlCommand cmd1 = new SqlCommand(query, con);
                        con.Open();
                        cmd1.ExecuteReader();
                        con.Close();
                    }

                }
                else if (OrderStatus == "New")
                {
                    using (var con = new SqlConnection(conString))
                    {
                        string query = "UPDATE [dbo].[Temp_FileDetails] SET [FilePriority]='" + Priority.Trim() + "' WHERE [Order_ID] = '" + Ordder_ID.Trim() + "' and CONVERT(VARCHAR,[FileName]) = '" + File_Name.Trim() + "' ";
                        SqlCommand cmd1 = new SqlCommand(query, con);
                        con.Open();
                        cmd1.ExecuteReader();
                        con.Close();
                    }
                }
            }
        }
        protected void EOrderPriority_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList FolderPriority = (DropDownList)sender;
            string fPriority = FolderPriority.SelectedValue;
            string Order_ID = FolderPriority.DataTextField.ToString();

            using (var con = new SqlConnection(conString))
            {
                SqlCommand cmd1 = new SqlCommand("UPDATE [dbo].[Order_Details] SET [Order_Priority]='" + fPriority + "' WHERE [Order_ID]='" + Order_ID + "'", con);
                con.Open();
                cmd1.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void Edit_btn_ServerClick(object sender, EventArgs e)
        {
            string[] cmd_Args = ((Button)sender).CommandArgument.ToString().Split(new char[] { ',' });
            Response.Redirect("test.aspx?imageData= " + cmd_Args[2] + " &orderid= " + cmd_Args[0] + " &Temp_file_name= " + cmd_Args[1] + " ");
        } 
    }
}