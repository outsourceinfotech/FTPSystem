<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="fileclient.WebForm2" %>

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

    <link href="/css/bootstrap.min.css" rel="stylesheet" />

    <link href="/fonts/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/css/animate.min.css" rel="stylesheet" />

    <!-- Custom styling plus plugins -->
    <link href="/css/custom.css" rel="stylesheet" />
    <link href="/css/icheck/flat/green.css" rel="stylesheet" />

    <script src="/js/jquery.min.js"></script>

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
        <a class="hiddenanchor" id="toregister"></a>
        <a class="hiddenanchor" id="tologin"></a>
        <div id="wrapper">
    <div class="animate form">
        <section class="login_content">
            <div class="panel-body">
                <form id="form1" runat="server">
                    
                         <h1>Create Account</h1>

                            <div class="">
                                <asp:TextBox ID="user_name" runat="server" placeholder="UserName" CssClass="form-control txt_box"></asp:TextBox>
                            </div>
                            <div class="">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="You can't leave this empty." ControlToValidate="user_name" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Remove Space or Special Characters" ControlToValidate="user_name" ValidationExpression="^[0-9a-zA-Z]+$" ForeColor="#DD9C00" style="float:left;"></asp:RegularExpressionValidator>
                            </div>
                      
                            <div class="">
                                <asp:TextBox ID="Email" runat="server" placeholder="E-mail" CssClass="form-control txt_box"></asp:TextBox>
                            </div>
                            <div class="">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="You can't leave this empty." ControlToValidate="Email" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Required a Valid Email address" ControlToValidate="Email" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ForeColor="#DD9C00" style="float:left;"></asp:RegularExpressionValidator>
                        </div>
                      
                            <div class="">
                                <asp:TextBox ID="password" type="password" runat="server" placeholder="Password" CssClass="form-control txt_box"></asp:TextBox>
                            </div>
                            <div class="">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="You can't leave this empty." ControlToValidate="password" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Minimum 6 & Maximum 20 only" ControlToValidate="password" ValidationExpression="^[a-zA-Z0-9\s]{6,20}$" ForeColor="#DD9C00" style="float:left;"></asp:RegularExpressionValidator>
                        </div>
                           
                            <div class="">
                                <asp:TextBox ID="pwd_confirm" type="password" runat="server" placeholder="Confirm Password" CssClass="form-control txt_box"></asp:TextBox>
                            </div>
                            <div class="">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="You can't leave this empty." ControlToValidate="pwd_confirm" ForeColor="#E7711A" style="float:left;"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Minimum 6 & Maximum 20 only" ControlToValidate="pwd_confirm" ValidationExpression="^[a-zA-Z0-9\s]{6,20}$" ForeColor="#DD9C00" style="float:left;"></asp:RegularExpressionValidator><br />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password Mistmatch" ControlToCompare="password" ControlToValidate="pwd_confirm" ForeColor="#E7711A" style="float:left;"></asp:CompareValidator>
                        </div>
                           
                        <div>
                            <asp:Button ID="submit2" runat="server" Text="Sign Up" class="btn btn-default submit" OnClick="Register" />
                            </div>
                        <div class="separator">
                            <p class="change_link">
                                Already a member ?
                                <a href="Login.aspx" class="to_register">Log in </a>
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
            </div>
        </section>
    </div>
            </div>
         </div>
</body>
</html>
