<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ZipFileListing.aspx.cs" Inherits="fileclient.ZipFileListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- page content -->
            <div class="right_col" role="main">

                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>Create Order</h3>
                        </div>

                        <div class="title_right">
                            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search for...">
                                    <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Go!</button>
                        </span>
                                </div>
                            </div>
                        </div>
                    </div>
                 <div class="clearfix"></div>

                <div class="row">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                             <div class="x_title">
                                    <h2>Files From Zip File</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a href="#"><i class="fa fa-chevron-up"></i></a>
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
                                        <li><a href="#"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>

                             <div class="x_content">          
                            <table aria-describedby="example_info" id="FilesZip" class="table table-striped responsive-utilities jambo_table dataTable">
                                        <thead>
                                            <tr role="row" class="headings">
                                                <th class="sorting">FileName</th>
                                                <th class="sorting">Compressed Size</th>
                                                <th class="sorting">Compression Level</th>
                                                <th class="sorting">Compression Method</th>
                                                <th class="sorting"><span class="nobr">Action</span></th>
                                            </tr>
                                        </thead>
                                        <tbody aria-relevant="all" aria-live="polite" role="alert">                                          
                                            <asp:Repeater ID="fileRpt" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("FileName") %></td>
                                                        <td><%# Eval("UncompressedSize") %></td>
                                                        <td><%# Eval("CompressedSize") %></td>
                                                        <td><%# Eval("CompressionMethod") %></td>
                                                        <td><asp:LinkButton ID="DonwloadFile" CommandArgument='<%# Eval("FileName") %>' runat="server" OnClick="DownloadFile">Download</asp:LinkButton></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                 </table>  
                            </div>
                        </div>
                    </div>
                </div>
                <!-- footer content -->
            <footer>
                <div class="">
                    <p class="pull-right">Gentelella Alela! a Bootstrap 3 template by <a>Kimlabs</a>. |
                        <span class="lead"> <i class="fa fa-paw"></i> Gentelella Alela!</span>
                    </p>
                </div>
                <div class="clearfix"></div>
            </footer>
            <!-- /footer content -->
                
            </div>
         </div>
            <!-- /page content -->


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScript" runat="server">
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.min.js"></script>
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

    <script>
        $(".dwnfilebtn").click(function () {
            var link = $(this).data("link");
            console.log(link);
            
            $.ajax({
                type: "POST",
                url: "ZipFileListing.aspx/DownloadFile",
                data: "{'filename':'" + link + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    alert("Success");
                },
                error: function (data) {
                    alert("fail");
                }
            });
         });

        // Datatalble for accessing files from the Zip File
         var asInitVals = new Array();
         $(document).ready(function () {
            $('#FilesZip').dataTable();
         });
        </script>
</asp:Content>
