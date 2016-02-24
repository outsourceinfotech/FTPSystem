<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="fileclient.test" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Untitled Document</title>
    <link href="css/picedit.css" rel="stylesheet" />
    <script src="js/jquery.min.js"></script>
    <style>
        table {
            width: 60%;
            text-align: left;
            background: white;
            float:left;
            margin-top:10%;
        }

        th, td {
            border: none;
            border-bottom: 1px solid #808080;
            line-height: 25px;
        }
        
#controllers {
  width: 600px;
  font-size: 0.8em;
  color: #333;
}
#paint {
  border: 1px solid #000;
  background: #fff;
}
.controller {
  display: inline-block;
  background: #eee;
  border: 1px solid #e7e7e7;
  padding: 5px;
}
    </style>
</head>
<body style="background-color: #2A3F54;">
    <form id="form1" runat="server">
        <div>
            <div class="right_col" role="main">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="width: 100%; float: left;">
                        <div class="x_panel">
                            <div class="x_content">
                                <div style="margin: 0 auto 0 auto; display: table;">
                                    <div id="xid">
                                        <div class="picedit_Heading">
                                            <ul>
                                                <li>
                                                    <h2><small style="color: #808080;">Order Id:</small> <%=Session["orderid"] %></h2>
                                                </li>
                                                <li>
                                                    <h2><small style="color: #808080;">File Name:</small> <%=Session["FileName"] %> </h2>
                                                </li>
                                            </ul>
                                        </div>
                                        <br />
                                        <input type="file" name="thefile" class="thebox">
                                        <div style="margin-top: 30px; text-align: center;">
                                            <h2 class="picedit_Heading">Add Editing notes for editors</h2>
                                            <div class="col-md-12">
                                                <asp:TextBox ID="EditingNotes" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <button class="picedit_btn" type="submit">Submit</button>
                                            <button class="picedit_btn" onclick="myFunction()" type="submit">Reload</button>
                                            <asp:Button ID="Button2" class="picedit_btn" runat="server" OnClick="Button2_Click" Text="Back" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
    <script src="js/picedit.js"></script>
    <script type="text/javascript">
        function myFunction() {
            location.reload();
        }
        // Send the canvas image to the server.
        $(function () {
            $('.thebox').picEdit({
                defaultImage: 'data:image/jpeg;base64,' + '<%=Session["img_data"] %>',
                <%-- defaultImage: '<%=Request.QueryString["imageData"]%>',--%>
                formSubmitted: function () {
                    var image = document.getElementById("FinalImage").toDataURL("image/png");
                    var filepath = '<%=Request.QueryString["imageData"]%>';
                    var order_Id = '<%=Request.QueryString["orderid"]%>';
                    var E_Notes = $('#EditingNotes').val();
                    console.log(order_Id);
                    image = image.replace('data:image/png;base64,', '');
                    $.ajax({
                        type: 'POST',
                        url: 'WebService1.asmx/HelloWorld',
                        data: '{ "imgData" : " ' + image + ' ", "filepath" : "' + filepath + '", "OrderId" : "' + order_Id + '", "Editing_Notes" : "' + E_Notes + '" }',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            alert('Image saved successfully !');
                            window.location.href = "upload.aspx";
                            //window.history.back();
                        }
                    });
                },

            });

        });
    </script>
    
</body>
</html>
