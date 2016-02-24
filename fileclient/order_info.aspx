<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="order_info.aspx.cs" Inherits="fileclient.order_info" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
        <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <!-- LightGallery plugins -->
    <link href="plugins/LightGallery/css/lightgallery.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/icheck/flat/green.css" rel="stylesheet">
    <link href="css/select/select2.min.css" rel="stylesheet" />
    <link href="css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Order Information</h3>
                        </div>
                        <div class="title_right">
                            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                <div class="input-group">
                                    <input class="form-control" placeholder="Search for..." type="text">
                                    <span class="input-group-btn"><button class="btn btn-default" type="button">Go!</button></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Havard Process</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#">Settings 1</a>
                                                </li>
                                                <li><a href="#">Settings 2</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>                        
                                <asp:Repeater ID="rptOrderDetails" runat="server">
                            <ItemTemplate>
                                <div class="x_content">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th># Order Id</th>
                                                <td><%# Eval("Order_ID") %></td>
                                             </tr>
                                            <tr>
                                                <th>Order Priority</th>
                                                <td><%# Eval("Order_Priority") %></td>
                                           </tr>
                                            <tr>
                                                <th scope="row">Order Name</th>
                                                <td><%# Eval("Order_Name") %></td>
                                               </tr>
                                            <tr> 
                                                <th scope="row">Order Status</th>
                                                <td><%# Eval("Order_Status") %></td>
                                            </tr>
                                            <tr>

                                                <th scope="row">Order Date</th>
                                                <td><%# Eval("Ordered_Date") %></td>
                                             </tr>
                                            <tr>
                                                <th scope="row">No.Of.Files</th>
                                                <td><%# Eval("File_Count") %></td>
                                            </tr>

                                        </tbody>
                                    </table>
                                    </div>
                                </div>
                            </div>
                        
                        <div class="clearfix"></div>

                       <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                            <div class="x_title">
                                                <h2><i class="fa fa-edit"></i> Editing Notes</h2>
                                                <ul class="nav navbar-right panel_toolbox">
                                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                    </li>
                                                    <li class="dropdown">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                        <ul class="dropdown-menu" role="menu">
                                                            <li><a href="#">Settings 1</a>
                                                            </li>
                                                            <li><a href="#">Settings 2</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                    </li>
                                                </ul>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="x_content">
                                                <div class="col-md-12">
                                                       <p><%# Eval("Comments") %></p>
                                                </div>
                                            </div>
                                        </div>  
                                    </div>
                         </ItemTemplate>
              </asp:Repeater>
                       <div class="clearfix"></div>

                       <div class="col-md-12">
                           <div class="x_panel">
                               <div class="x_title">
                                    <h2><i class="fa fa-edit"></i> Orginal Files</h2>
                                       <ul class="nav navbar-right panel_toolbox">
                                           <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                               <li class="dropdown">
                                                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                    <ul class="dropdown-menu" role="menu">
                                                            <li><a href="#">Settings 1</a></li>
                                                            <li><a href="#">Settings 2</a></li>
                                                    </ul>
                                               </li>
                                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                        </ul>
                                  <div class="clearfix">
                                      
                                  </div>
                                 </div>
                                 
                              <div class="x_content">
                                  <div class="row">
                                        <div class="x_content">
                                      <asp:DataList ID="DataList1" runat="server" ExtractTemplateRows="false" RepeatColumns="4" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <div class="isotope-item col-sm-12 col-md-12 col-lg-12">
                                            <div class="thumbnail" style="height:auto; overflow: visible;">
                                                   <div class="thumb-preview">
                                                    <a class="thumb-image with-caption" href="<%# Eval("Image") %>" data-value="<%# Eval("Order_ID") %>" data-source="<%# Eval("Temp_Image") %>" title="<%# Eval("FileName") %>">
                                                        <asp:Image ID="Image1" ImageUrl='<%# Eval("Image") %>' runat="server" class="img-responsive" />
                                                    </a>
                                                </div>
                                                <h5 class="mg-title text-weight-semibold"><%# Eval("FileName") %></h5>
                                             
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
</div>
                                  </div>                  
                               </div>
                           </div>
                      </div>

                     <%--   <div class="clearfix"></div>

                         <div class="col-md-12">
                           <div class="x_panel">
                               <div class="x_title">
                                    <h2><i class="fa fa-edit"></i> Completed Files</h2>
                                       <ul class="nav navbar-right panel_toolbox">
                                           <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                               <li class="dropdown">
                                                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                    <ul class="dropdown-menu" role="menu">
                                                            <li><a href="#">Settings 1</a></li>
                                                            <li><a href="#">Settings 2</a></li>
                                                    </ul>
                                               </li>
                                                
                                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                        </ul>

                                  <div class="clearfix"></div>
                                 </div>
                                 
                               <div class="x_content">
                                  <div class="row">
                                      <ul id="download-files" class="list-unstyled row">
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/1.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/1.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/2.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/2.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/3.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/3.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/4.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/4.jpg">
                                            </a>
                                        </li>
                                           <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/1.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/1.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/2.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/2.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/3.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/3.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/4.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/4.jpg">
                                            </a>
                                        </li>
                                    </ul>                   
                                  </div>
                               </div>
                           </div>
                      </div>


                        <div class="clearfix"></div>

                         <div class="col-md-12">
                           <div class="x_panel">
                               <div class="x_title">
                                    <h2><i class="fa fa-edit"></i> Re Edited Files</h2>
                                       <ul class="nav navbar-right panel_toolbox">
                                           <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                               <li class="dropdown">
                                                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                    <ul class="dropdown-menu" role="menu">
                                                            <li><a href="#">Settings 1</a></li>
                                                            <li><a href="#">Settings 2</a></li>
                                                    </ul>
                                               </li>
                                                
                                                <li><a class="close-link"><i class="fa fa-close"></i></a></li>
                                        </ul>

                                  <div class="clearfix"></div>
                                 </div>
                                 
                               <div class="x_content">
                                  <div class="row">
                                      <ul id="reedit-files" class="list-unstyled row">
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/1.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/1.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/2.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/2.jpg">
                                            </a>
                                        </li>
                                        <li class="col-md-1" style="padding-bottom:10px" data-src="images/ex-slide/3.jpg">
                                            <a href="">
                                                <img class="img-responsive" src="images/ex-slide/thumbs/3.jpg">
                                            </a>
                                        </li>
                                    </ul>                   
                                  </div>
                               </div>
                           </div>
                      </div>--%>

                   </div>
                <div class="clearfix"></div>

         
                <!-- /footer content -->
            </div>
         </div>
                    </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScript" runat="server">
  
     <script src="js/bootstrap.min.js"></script>

    <!-- chart js -->
    <script src="js/chartjs/chart.min.js"></script>
    <!-- bootstrap progress js -->
    <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
    <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
    <!-- icheck -->
    <script src="js/icheck/icheck.min.js"></script>
    <script src="js/select/select2.full.js"></script>

    <script src="js/custom.js"></script>

     <script src="js/datatables/js/jquery.dataTables.js"></script>
     <script src="js/datatables/tools/js/dataTables.tableTools.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>
    <script src="plugins/LightGallery/js/lg-autoplay.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-fullscreen.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-hash.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-pager.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-thumbnail.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-video.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lg-zoom.js" type="text/javascript"></script>
    <script src="plugins/LightGallery/js/lightgallery.js" type="text/javascript"></script>
    <script src="js/jquery.mousewheel.min.js" type="text/javascript"></script>

    <script>
        $('#uploaded-files').lightGallery({
            thumbnail: true,
            controls: true,
            keyPress: true,
            zoom: true,
            scale: 1,
            enableZoomAfter: 10
        });

        $('#download-files').lightGallery({
            thumbnail: true,
            controls: true,
            keyPress: true,
            zoom: true,
            scale: 1,
            enableZoomAfter: 10
        });

        $('#reedit-files').lightGallery({
            thumbnail: true,
            controls: true,
            keyPress: true,
            zoom: true,
            scale: 1,
            enableZoomAfter: 10
        });
    </script>

</asp:Content>

