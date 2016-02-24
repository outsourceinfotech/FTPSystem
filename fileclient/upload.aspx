<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="fileclient.upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/maps/jquery-jvectormap-2.0.1.css" />
    <link href="css/icheck/flat/green.css" rel="stylesheet" />
    <link href="css/floatexamples.css" rel="stylesheet" type="text/css" />
    <link href="js/dropzone/dropzone.css" rel="stylesheet" />

    <script src="js/jquery.min.js"></script>
    <script src="js/nprogress.js"></script>
    <script>
        NProgress.start();
    </script>
    <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    <link href="assets/font-awesome.css" rel="stylesheet" />
    <link href="assets/magnific-popup.css" rel="stylesheet" />
    <!-- Theme CSS -->
    <link href="assets/gridview.css" rel="stylesheet" />
    <style>
        table {
            width: 100%;
            border: none;
        }
        td {
            width: 10%;
        }
        th{
            width:10%;
            color:#336699;
            font-size:16px;
        }
    </style>
    <style type="text/css">
        .web_dialog_overlay {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
            background: #000000;
            opacity: .5;
            filter: alpha(opacity=15);
            -moz-opacity: .15;
            z-index: 101;
            display: none;
        }
        .web_dialog {
            display: none;
            position: absolute;
            width: 60%;
            height: auto;
            top: 20%;
            left: 25%;
            /*margin-left: -190px;
   margin-top: -100px;*/
            background-color: #ffffff;
            border: 2px solid #336699;
            padding: 0px;
            z-index: 102;
        }
        .web_dialog_image {
            display: none;
            position: absolute;
            width: 80%;
            height: auto;
            top: 10%;
          
            /*margin-left: -190px;
   margin-top: -100px;*/
            background-color: #ffffff;
            border: 2px solid #336699;
            padding: 0px;
            z-index: 102;
        }

        .web_dialog_title {
            border-bottom: solid 2px #336699;
            background-color: #336699;
            padding: 4px;
            color: White;
            font-weight: bold;
        }

            .web_dialog_title a {
                color: White;
                text-decoration: none;
            }

        .align_right {
            text-align: right;
        }

        .image-link {
            cursor: -webkit-zoom-in;
            cursor: -moz-zoom-in;
            cursor: zoom-in;
        }


        /* This block of CSS adds opacity transition to background */
        .mfp-with-zoom .mfp-container,
        .mfp-with-zoom.mfp-bg {
            opacity: 0;
            -webkit-backface-visibility: hidden;
            -webkit-transition: all 0.1s ease-out;
            -moz-transition: all 0.1s ease-out;
            -o-transition: all 0.1s ease-out;
            transition: all 0.1s ease-out;
        }

        .mfp-with-zoom.mfp-ready .mfp-container {
            opacity: 1;
        }

        .mfp-with-zoom.mfp-ready.mfp-bg {
            opacity: 0.8;
        }

        .mfp-with-zoom.mfp-removing .mfp-container,
        .mfp-with-zoom.mfp-removing.mfp-bg {
            opacity: 0;
        }

        /* padding-bottom and top for image */
        .mfp-no-margins img.mfp-img {
            padding: 0;
        }
        /* position of shadow behind the image */
        .mfp-no-margins .mfp-figure:after {
            top: 0;
            bottom: 0;
        }
        /* padding for main container */
        .mfp-no-margins .mfp-container {
            padding: 0;
        }

        /* aligns caption to center */
        .mfp-title {
            padding: 10px 10px;
            font-size: 1em;
        }

        .image-source-link {
            color: #DDD;
            font-size: 1em;
            text-align: center;
        }
        .edit_btn{
            color:#fff;
            margin-left:20%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="clearfix"></div>
    <div class="right_col" role="main" style="margin-top: -10px; padding-bottom: 10px;">
        <div class="dropzone needsclick dz-clickable" id="WizardUpload">
            <div class="dz-message needsclick">
                <h1>Drop files here or click to upload.</h1>
                <h4 class="note needsclick">(Drag and drop <strong>folders</strong> to upload)</h4>
            </div>
        </div>
        <div class="clear" style="margin-top: 50px;"></div>
        <asp:Button ID="uploadall_button" runat="server" CssClass="btn btn-success" Visible="false" CommandArgument='<%#Eval("DirectoryName")%>' Text="Upload_All" OnClick="FTP_Upload_All" />
        <span class="btn btn-default" runat="server"><a href="#" id="mgSelectAll"><i class="fa fa-check-square"></i><span data-all-text="Select All" data-none-text="Select None">Select All</span></a></span>
        <asp:Button ID="butUpload" runat="server" Visible="false" CommandArgument='<%#Eval("OrderID")%>' CssClass="btn btn-primary" Text="Upload Selected Folders" OnClick="FTP_Upload" />
        <asp:Button ID="butCancel" runat="server" Visible="false" CommandArgument='<%#Eval("OrderID")%>' CssClass="btn btn-danger" Text="Cancel Selected Folders" OnClick="Delete_Folder"/>
        <div class="clear" style="margin-top: 20px;"></div>
        <table id="table_head" runat="server">
            <tr>
                <th>Order List</th>
                <th>Order Name</th>
                <th>No.of Files</th>
                <th>Order Priority</th>
                <th>Order Status</th>
                <th>Actions</th>
            </tr>
        </table>
        <asp:DataList ID="DataListContent" runat="server" RepeatDirection="Vertical" BorderStyle="None" Style="padding: 0px !important">
            <ItemTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><div class="mg-option checkbox-custom checkbox-inline">
                                 <asp:CheckBox ID="CheckBox1" runat="server" />
                                  <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("OrderID") %>' />
                                 </div>
                                <img src="folder.png" id="ImgIcon" width="60" /></td>
                            <td>
                                <asp:Label ID="lblFilePath" runat="server" Text='<%#Eval("DirectoryName")%>'></asp:Label></td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("FileCount")%>'></asp:Label></td>
                            <td>
                                <%--<asp:Label ID="Label2" runat="server" Text='<%#Eval("Priority")%>'></asp:Label></td>--%>
                                 <asp:DropDownList ID="EOrderPriority" runat="server" CssClass="form-control select2" Width="50%" AutoPostBack="true" DataTextField = '<%#Eval("OrderID")%>' SelectedValue ='<%#Eval("Priority")%>' OnSelectedIndexChanged="EOrderPriority_SelectedIndexChanged" >
                                        <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                         <asp:ListItem Value="Moderate">Moderate</asp:ListItem>
                                        <asp:ListItem Value="High">High</asp:ListItem>  
                                        <asp:ListItem Value="Express">Express</asp:ListItem>                     
                                    </asp:DropDownList>  
                            <td>
                                <asp:Label ID="lblUploadStatus" runat="server" Text='<%#Eval("UploadStatus")%>'></asp:Label>
                            </td>
                            <td>
                                <asp:Button ID="btn_edit" runat="server" CommandName='<%#Eval("UploadStatus")%>' CommandArgument='<%#Eval("OrderID")%>' CssClass="btn btn-default" OnClick="btnShowModal_Click" Text="Edit" />
                                <asp:Button ID="btn_open" runat="server" CommandName='<%#Eval("UploadStatus")%>' CommandArgument='<%#Eval("OrderID")%>' CssClass="btn btn-info" OnClick="display_Image" Text="Open" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <div id="overlay" class="web_dialog_overlay"></div>
        <div id="dialog1" class="web_dialog dialog">
            <asp:DataList ID="DataList2" runat="server" RepeatDirection="Vertical" BorderStyle="None" Style="padding: 0px!important">
                <ItemTemplate>
                    <div class="web_dialog_title col-md-6">
                        <h2><%=Session["folder"] %></h2>
                    </div>
                    <div class="web_dialog_title align_right col-md-6"><a href="#" id="btnClose">
                        <h2>Close</h2>
                    </a></div>
                    <div class="col-md-2"></div>
                    <div class="col-md-8" style="margin-top: 40px; margin-bottom: 50px;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Order Name</label>
                                    <asp:TextBox ID="TextBox1" Text='<%#Eval("DirectoryName")%>' CssClass="form-control" runat="server" Enabled="False"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>No of files</label>
                                    <input type="text" name="OrderDesc" id="EOrderDesc" class="form-control" placeholder="Order Desc" value="<%#Eval("FileCount")%>" readonly="readonly" />
                                </div>
                            </div>
                            <!-- /.col -->
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Select Priority</label>
                                    <asp:DropDownList ID="EOrderPriority" runat="server" CssClass="form-control select2" Width="100%" SelectedValue ='<%#Eval("Priority")%>' >
                                        <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                         <asp:ListItem Value="Moderate">Moderate</asp:ListItem>
                                        <asp:ListItem Value="High">High</asp:ListItem>  
                                        <asp:ListItem Value="Express">Express</asp:ListItem>                     
                                    </asp:DropDownList>  
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Editing Notes</label>
                                    <asp:TextBox ID="TextArea1" TextMode="multiline" class="form-control" Columns="50" Rows="5" runat="server" Text='<%#Eval("EditingNotes")%>' />
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div style="text-align: center;">
                                <asp:Button ID="submit" runat="server" CssClass="btn btn-success" CommandArgument ='<%#Eval("OrderID")%>'  OnClick="btnSubmit_Click" Text="Submit" />
                                 <asp:Button ID="close" runat="server" CssClass="btn btn-default" Text="Cancel" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"></div>
                </ItemTemplate>
            </asp:DataList>
            </div>
        
        <div id="dialog2" class="web_dialog_image dialog">
                <div class="web_dialog_title col-md-6">
                        <h2><%=Session["foldername"] %></h2>
                    </div>
                   <div class="web_dialog_title align_right col-md-6"><a href="#" id="close">
                        <h2>Close</h2>
                    </a></div>
                <section class="content-with-menu content-with-menu-has-toolbar media-gallery">
                    <div class="content-with-menu-container">
                        <div class="inner-body mg-main">
                            <div class="inner-toolbar clearfix">
                            </div>
                            <div class="row mg-files" data-sort-destination data-sort-id="media-gallery">
                                <asp:DataList ID="DataList1" runat="server" ExtractTemplateRows="false" RepeatColumns="4" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <div class="isotope-item col-sm-12 col-md-12 col-lg-12">
                                            <div class="thumbnail" style="height:auto; overflow: visible;">
                                                   <div class="thumb-preview">
                                                    <a class="thumb-image with-caption" href="<%# Eval("Image") %>" data-value="<%# Eval("Order_ID") %>" data-source="<%# Eval("Temp_Image") %>" title="<%# Eval("FileName") %>">
                                                        <asp:Image ID="Image1" ImageUrl='<%# Eval("Image") %>' runat="server" class="img-responsive" />
                                                    </a>
                                                    <div class="mg-thumb-options" style="">
                                                        <div class="mg-zoom"><i class="fa fa-search"></i></div>
                                                        <div class="mg-toolbar">
                                                            <div class="mg-option checkbox-custom checkbox-inline">
                                                             <%--<input type="checkbox" id="file_1" value="1">--%>
                                                                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Edit" CommandArgument='<%#Eval("Order_ID")+","+ Eval("FileName")+","+ Eval("Temp_Image")%>' OnClick="Edit_btn_ServerClick" /> 
                                                              <%--<a id="Edit_btn" class="edit_btn" onclick="Edit_btn_ServerClick" runat="server">Edit</a>--%>
                                                            </div>
                                                            <div class="mg-group pull-right open">
                                                                <asp:HiddenField ID="HF_imageurl" runat="Server" Value='<%# Eval("Temp_Image") %>' />
                                                                <asp:HiddenField ID="HF_orderid" runat="Server" Value='<%# Eval("Order_ID") %>' />
                                                                <asp:HiddenField ID="HF_filename" runat="Server" Value='<%# Eval("FileName") %>' />
                                                                <asp:DropDownList ID="EOrderPriority" runat="server" CssClass="form-control select2" Width="100%" SelectedValue ='<%#Eval("Priority")%>' BackColor="#336699">
                                                                    <asp:ListItem Value="Normal">Normal</asp:ListItem>
                                                                     <asp:ListItem Value="Moderate">Moderate</asp:ListItem>
                                                                    <asp:ListItem Value="High">High</asp:ListItem>  
                                                                    <asp:ListItem Value="Express">Express</asp:ListItem>                     
                                                                </asp:DropDownList>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <h5 class="mg-title text-weight-semibold"><%# Eval("FileName") %></h5>
                                                <h2 class="pull-right mg-title text-weight-semibold"><%# Eval("ISMarked") %></h2>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
                                <div style="text-align: center;">
                                <%--<input id="btnSubmit" type="button" class="btn btn-success" value="Submit" />--%>
                                <asp:Button ID="Button6" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Editing_Submit" />
                                <asp:Button ID="butClose" runat="server" CssClass="btn btn-default" Text="Cancel" />
                            </div>
                            </div>
                            
                        </div>
                    </div>
                </section>
           
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScript" runat="server">
    <script src="js/bootstrap.min.js"></script>
    <!-- gauge js -->
    <script type="text/javascript" src="js/gauge/gauge.min.js"></script>
    <script type="text/javascript" src="js/gauge/gauge_demo.js"></script>
    <!-- chart js -->
    <script src="js/chartjs/chart.min.js"></script>
    <!-- bootstrap progress js -->
    <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
    <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
    <!-- icheck -->
    <script src="js/icheck/icheck.min.js"></script>
    <!-- daterangepicker -->
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/datepicker/daterangepicker.js"></script>
    <script src="js/dropzone/dropzone.js"></script>
    <script src="js/custom.js"></script>
    <script src="assets/javascripts/theme.js"></script>

    <script src="assets/jquery.magnific-popup.js"></script>
    <script src="assets/examples.mediagallery.js"></script>
  
    <!-- Theme Base, Components and Settings -->

    <script type="text/javascript">

        $(document).ready(function () {
            //Simple Dropzonejs
            Dropzone.autoDiscover = false;
            $("#WizardUpload").dropzone({
                url: "Handler1.ashx",
                maxFiles: 200,
                addRemoveLinks: true,
                init: function () {
                    this.on("sending", function (file, xhr, formData) {
                        formData.append("foldername", file.fullPath);
                    }),
                    this.on("success", function (file, xhr, serverFileName) {
                        //alert("success");
                    }),
                    this.on("removedfile", function (file, xhr, serverFileName) {
                        alert(file.name);
                    }),
                    this.on("queuecomplete", function (file, xhr, serverFileName) {
                        location.reload();
                    });
                },
            });
        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {

           $("#btnClose").click(function (e) {
               HideFolderDialog();
               e.preventDefault();
           });
           $("#close").click(function (e) {
               HideImageDialog();
               e.preventDefault();
           });

           $("#btnSubmit").click(function (e) {
               HideFolderDialog();
               HideImageDialog();
               e.preventDefault();
               alert("Success");
           });
       });

             function foldermodal() {
                 ShowFolderDialog(true);
                 e.preventDefault();
             }

             function imagemodal() {
                 ShowImageDialog(true);
                 e.preventDefault();
             }

             function ShowFolderDialog(modal) {
                 $("#overlay").show();
                 $("#dialog1").fadeIn(300);

                 if (modal) {
                     $("#overlay").unbind("click");
                 }
                 else {
                     $("#overlay").click(function (e) {
                         HideFolderDialog();
                     });
                 }
             }
             function ShowImageDialog(modal) {
                 $("#overlay").show();
                 $("#dialog2").fadeIn(300);

                 if (modal) {
                     $("#overlay").unbind("click");
                 }
                 else {
                     $("#overlay").click(function (e) {
                         HideImageDialog();
                     });
                 }
             }
             function HideFolderDialog() {
                 $("#overlay").hide();
                 $("#dialog1").fadeOut(300);
             }
             function HideImageDialog() {
                 $("#overlay").hide();              
                 $("#dialog2").fadeOut(300);
             }
             </script>
    <script type="text/javascript">
        $('.with-caption').magnificPopup({
            type: 'image',
            closeOnContentClick: true,
            closeBtnInside: false,
            mainClass: 'mfp-with-zoom mfp-img-mobile',
            image: {
                verticalFit: true,
                titleSrc: function (item) {
                    return item.el.attr('title')
                        + '<br/><br/><label style="color: #fff;">Download</label>'
                        + '&MediumSpace;&MediumSpace; <a class="image-source-link" href="test.aspx?imageData=' + item.el.attr('data-source') + ' &orderid= ' + item.el.attr('data-value') + ' &file_name= ' + item.el.attr('title') + '">Edit Image</a>';
                }
            },
            zoom: {
                enabled: true   
            }
           
        });

    </script>
 
</asp:Content>
