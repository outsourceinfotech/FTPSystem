<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="fileclient.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/animate.min.css" rel="stylesheet" />

    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/icheck/flat/green.css" rel="stylesheet" />

    <script src="js/jquery.min.js"></script>

    <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
     <style>
        .txt_box{
            margin:0px !important;
        }
    </style>
</head>
<body style="background: #F7F7F7;">
    <div class="">
        <div id="wrapper">
            <div class="animate form">
                <section class="login_content">
                    <form id="form1" runat="server">
                        <h1>Login Form</h1>
                         <div>
                            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False" ForeColor="#DD6C00"></asp:Label>
                        </div>
                        <div>
                            <asp:TextBox ID="user_name" placeholder="Username" CssClass="form-control txt_box" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required UserName" ControlToValidate="user_name" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Use Without Space and Special Characters" ControlToValidate="user_name" ValidationExpression="^[0-9a-zA-Z]+$" ForeColor="#DD6C00" style="float:left;"></asp:RegularExpressionValidator>
                            <%--<input type="text" class="form-control" placeholder="Username" required="" />--%>
                        </div>

                        <div>
                            <asp:TextBox ID="password" TextMode="Password" placeholder="Password" CssClass="form-control txt_box" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required Password" ControlToValidate="password" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator><br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Minimum 3 & Maximum 20 characters only" ControlToValidate="password" ValidationExpression="^[a-zA-Z0-9\s]{6,20}$" ForeColor="#DD6C00" style="float:left;"></asp:RegularExpressionValidator>
                        </div>
                        <%-- <input type="password" class="form-control" placeholder="Password" required="" />--%>

                        <div style="float:left;">
                            <asp:CheckBox ID="RememberMe" runat="server" />
                            <label for="RememberMe">Remember Me</label>
                            <asp:Button ID="Button1" OnClick="button_click" CssClass="btn btn-default submit" runat="server" Text="login" />
                            <a class="reset_pass" href="#" style="float:left;">Lost your password?</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">
                            <p class="change_link">
                                New to site?
                                <a href="Register.aspx" class="to_register">Create Account </a>
                            </p>
                            <div class="clearfix"></div>
                            <br />
                            <div>
                                <h1>
                                    <img src="logo.png" style="font-size: 26px;" />Outsource Infotech</h1>
                                <p>©2015 All Rights Reserved. Outsource Infotech Pvt Ltd. Privacy and Terms</p>
                            </div>
                        </div>
                    </form>
                    <!-- form -->
                </section>
                <!-- content -->
            </div>
        </div>
    </div>
</body>
</html>
