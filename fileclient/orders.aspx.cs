using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace fileclient
{
    public partial class orders : System.Web.UI.Page
    {
        public static DataTable TableData = new DataTable();
        public static string conString = @"Data Source=(localdb)\ProjectsV12;Initial Catalog=ftpsystem;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetAllData();
            }
        }

        private void GetAllData() //Get all the data and bind it in HTLM Table 
        {
            using (var con = new SqlConnection(conString))
            {
                string query = "SELECT * FROM [Order_Details] where [Order_Status]='Uploaded' and [User_Name] = '" + Session["username"] + "' ";
                using (var cmd = new SqlCommand(query, con))
                {
                    using (var sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (TableData)
                        {
                            TableData.Clear();
                            sda.Fill(TableData);
                        }
                    }
                }
            }
        }

        [WebMethod]
        public static void CreateData(DataFeilds datafeilds) //Insert data in database
        {
            using (var con = new SqlConnection(conString))
            {
                using (var cmd = new SqlCommand("INSERT INTO [dbo].[Order_Details] ([Order_Name],[Order_Description],[Order_Selection],[Order_Priority],[Order_Status],[Ordered_Date],[Modified_Date],[User_Name]) VALUES(@OrderName,@OrderDesc,@OrderSelect,@OrderPriroty,'New',@CreatedDate,@ModifiedDate,@Username)"))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@OrderName", datafeilds.OrderName);
                    cmd.Parameters.AddWithValue("@OrderDesc", datafeilds.OrderDesc);
                    cmd.Parameters.AddWithValue("@OrderSelect", datafeilds.OrderSelect);
                    cmd.Parameters.AddWithValue("@OrderPriroty", datafeilds.OrderPriority);
                    cmd.Parameters.AddWithValue("@Username", HttpContext.Current.Session["username"].ToString());
                    cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@ModifiedDate", DateTime.Now);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        [WebMethod]
        public static string EditData(int oid) //Show the edit clicked data in the popup window
        {
            string jsondata;
            //var details = new List<Employee>();
            using (var con = new SqlConnection(conString))
            {
                var query = "SELECT * FROM [Order_Details] where [Order_ID]='" + oid + "'";
                using (var cmd = new SqlCommand(query, con))
                {
                    using (var sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        TableData.Clear();
                        sda.Fill(TableData);
                        jsondata = JsonConvert.SerializeObject(TableData);
                    }
                }
            }
            return jsondata;
        }

        [WebMethod]
        public static void UpdateData(DataFeilds datafeilds, int oid) //Update data in database  
        {
            using (var con = new SqlConnection(conString))
            {
                var query = "UPDATE [Order_Details] SET [Order_Name]='" + datafeilds.OrderName + "',[Order_Description]='" + datafeilds.OrderDesc + "',[Order_Selection]='" + datafeilds.OrderSelect + "',[Order_Priority]='" + datafeilds.OrderPriority + "' ,[Modified_Date]='"+datafeilds.ModifiedDateTime+"' WHERE [Order_ID]='" + oid + "'";
                con.Open();
                var cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        [WebMethod]
        public static void Cancel(int oid)
        {
            using (var con = new SqlConnection(conString))
            {
                var query = "UPDATE [Order_Details] SET [Order_Status]='Cancel' WHERE [Order_ID]='" + oid + "'";
                con.Open();
                var cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }

    public class DataFeilds
    {
        public int OrderId;
        public string OrderName;
        public DateTime Order_Date;
        public string OrderDesc;
        public string OrderSelect;
        public string OrderStatus;
        public string OrderPriority;
        public string Comment;
        public DateTime CreatedDateTime;
        public DateTime ModifiedDateTime;
    }

}