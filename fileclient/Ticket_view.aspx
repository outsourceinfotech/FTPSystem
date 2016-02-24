<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ticket_view.aspx.cs" Inherits="fileclient.Ticket_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
     <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="css/animate.min.css" rel="stylesheet"/>

    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet"/>
    <link href="css/icheck/flat/green.css" rel="stylesheet"/>


    <script src="js/jquery.min.js"></script>

    <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
         <div class="right_col" role="main">
                  <div class="row">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2><strong>Details For Ticket 12040 </strong></h2>
                                    <h2 class="nav navbar-right panel_toolbox">
                                        <strong>Closed</strong>
                                    </h2>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                           
                                     <div class="row">
                                      <div class="col-md-6 col-xs-12">

                                            <div class="box-header with-border">
                                              <h3 class="box-title"><strong>Ticket Information</strong></h3>
                                            </div><!-- /.box-header -->
                                          <div class="box-body no-padding">
                                              <table class="table">
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Ticket Title</th>
                                                      <td style="width: 50%;">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                  </tr>
                                                    <tr style="width: 100%;">
                                                      <th style="width: 50%;">Ticket For</th>
                                                      <td style="width: 50%;">Imgage_32.jpg</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Shoot address</th>
                                                      <td style="width: 50%;">36 Craigmount Brae</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Submitted By</th>
                                                      <td style="width: 50%;">Movie Bee</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Created at</th>
                                                      <td style="width: 50%;">Jan. 15, 2016, 2:23 p.m.</td>
                                                  </tr>
                                              </table>

                                          </div>
                                          <!-- /.box-body -->

                                      </div>
                                      <div class="col-md-6 col-xs-12">

                                           <div class="box-header">
                              <h3 class="box-title"><strong>Order Information</strong></h3>               
                            </div><!-- /.box-header -->
                                          <div class="box-body no-padding">
                                              <table class="table">
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Order</th>
                                                      <td style="width: 50%;">731000017</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Order Name</th>
                                                      <td style="width: 50%;">Havard</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Reason</th>
                                                      <td style="width: 50%;">Amendment</td>
                                                  </tr>
                                                  <tr style="width: 100%;">
                                                      <th style="width: 50%;">Note</th>
                                                      <td style="width: 50%;">front ext missing add "Exterior b"</td>
                                                  </tr>    
                                                   <tr style="width: 100%;">
                                                      <th style="width: 50%;">Priority</th>
                                                      <td style="width: 50%;">Urgent</td>
                                                  </tr>                                    
                                              </table>

                                          </div>
                                          <!-- /.box-body -->

                                      </div>
                                      <!-- /.col -->
                                      </div> 
                               <hr />
                                    <h3>Ticket File</h3>
                                    <br />
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                    <div class="img-container">
                                          <img src="images/03.jpg" />
                                    </div>
                                        </div>
                                    <div class="col-md-1"></div>
                          </div>
                          </div>
              </div>
                      </div>
             <div class="row">
                 
                <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>Respond</h2>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="form-group">
                                    <label class="control-label col-md-12 col-sm-12 col-xs-12">Comments:</label>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <textarea class="resizable_textarea form-control" style="width: 100%; overflow: hidden; word-wrap: break-word; resize: horizontal; height: 100px; margin-bottom:40px;">This text area automatically resizes its height as you fill in more text courtesy of autosize-master it out...
                                        </textarea>
                                            <asp:Button ID="Button1" CssClass="btn btn-primary pull-right" runat="server" Text="Submit" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
             </div>
      </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScript" runat="server">
</asp:Content>
