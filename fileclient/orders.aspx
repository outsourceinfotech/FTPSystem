<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="fileclient.orders" %>

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
            <!-- page content -->
            <div class="right_col" role="main">

                <div class="">
                <div class="clearfix"></div>

                <div class="row">

                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Daily active users <small>Sessions</small></h2>
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
                                   
                                 <table aria-describedby="example_info" id="orderlist" class="table table-striped responsive-utilities jambo_table dataTable">
                                        <thead>
                                            <tr role="row" class="headings">
                                                <th class="sorting">Order Id</th>
                                                <th class="sorting">Order Name</th>
                                                <th class="sorting">Order Priority</th>
                                                <th class="sorting">Status</th>
                                                <th class="sorting">Date </th>
                                                <th class="no-link last sorting"><span class="nobr">Action</span>
                                                </th></tr>
                                        </thead>

                                    <tbody aria-relevant="all" aria-live="polite" role="alert">
                                        <% for (var data = 0; data < TableData.Rows.Count; data++)
                                          { %>
                                            <a href="order_info.aspx?orderid=<%=TableData.Rows[data]["Order_ID"] %>"><tr>
                                            <td><%=TableData.Rows[data]["Order_ID"]%></td>
                                            <td><%=TableData.Rows[data]["Order_Name"]%></td>                                                 
                                            <td><%=TableData.Rows[data]["Order_Priority"]%></td>
                                            <td><%=TableData.Rows[data]["Order_Status"]%></td>
                                            <td><%=TableData.Rows[data]["Ordered_Date"]%></td>
                                            <td>
                                                <%--<a href="javascript:void(0);" class="edtordbtn" data-id="<%=TableData.Rows[data]["Order_ID"] %>" data-toggle="modal" data-target="#MyEdtOrdMod" id="EdtOrdBtn"></a>--%>
                                                <a href="order_info.aspx?orderid=<%=TableData.Rows[data]["Order_ID"] %>" class="vewordbtn" id="PlcOrdBtn">View</a>
                                            <%--<input type="button" class="btn btn-primary edtordbtn" data-id="<%=TableData.Rows[data]["Order_ID"] %>" data-toggle="modal" data-target="#MyEdtOrdMod" name="EdtOrdBtn" id="EdtOrdBtn" value="Edit" />                             
                                                 <input type="button" class="btn btn-primary cnlordbtn" data-id="<%=TableData.Rows[data]["Order_ID"] %>" name="CnlOrdBtn" id="CnlOrdBtn" value="Cancel" />--%>
                                           </td>
                                         </tr></a>
                                       <% } %>
                                    </tbody>
                                 </table>  
                            </div>
                        </div>

                        <br>
                        <br>
                        <br>

                    </div>
                </div>

                <div id="MyEdtOrdMod" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
   <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title" id="myModalLabel">Edit Order</h2>
                </div>
                <div class="modal-body">
                    <div class="panel-body">
                        <div class="row">

                <div class="col-md-12">
                  <div class="form-group">
                    <label>Order Name</label>
                     <input type="text" name="OrderName" id="EOrderName" class="form-control" placeholder="Order Name" required="" />
                  </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label>Order Description</label>
                          <input type="text" name="OrderDesc" id="EOrderDesc" class="form-control" placeholder="Order Desc" required="" />
                    </div>  
              </div>
               <div class="col-md-12">
                  <div class="form-group">
                    <label>Select Package</label>
                          <select name="OrderType" id="EOrderType" class="form-control select2" required="" style="width: 100%;">
                                <option value="Photos Only">Photo's Only</option>
                                <option value="Photo and Videos">Photo and Video's</option>
                                <option value="Digital Marketing">Digital Marketing</option>
                                <option value="Realtor.com">Realtor.com</option>
                                <option value="Video Tour">Video Tour</option>
                            </select>                
                  </div><!-- /.form-group -->
                </div><!-- /.col -->
                  <div class="col-md-12">
                  <div class="form-group">
                    <label>Select Priority</label>
                      <select name="OrderPriority" id="EOrderPriority" class="form-control select2" required="" style="width: 100%;">
                                <option value="Normal">Normal</option>
                                <option value="Moderate">Moderate</option>
                                <option value="High">High</option>
                                <option value="Express">Express</option>
                      </select>
                  </div><!-- /.form-group -->
                </div><!-- /.col -->
              </div>
                   </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default pull-left" data-dismiss="modal" value="Close" />
                    <button type="button" id="UpdOrdBtn" class="btn btn-primary" data-eid="" data-dismiss="modal">Save changes</button>
                </div>
            </div>

  </div>
</div>
                
          
            <!-- /footer content -->
                
            </div>
         </div>
            <!-- /page content -->

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
    
    <script src="js/dropzone/dropzone.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            
            //Simple Dropzonejs
            Dropzone.autoDiscover = false;

            $("#WizardUpload").dropzone({
                url: "dropzone.ashx",
                maxFiles: 50,
                uploadMultiple: true,
                parallelUploads: 10,
                addRemoveLinks: true,
                init: function () {
                    this.on("sendingmultiple", function (file, xhr, formData) {
                        console.log(file);
                        for (var i = 0; i < file.length; i++) {
                            var pathElements = file[i].fullPath.replace(/\/$/, '').split('/');
                            var lastFolder = pathElements[pathElements.length - 2];
                            formData.append("foldername", lastFolder);
                        }
                    }),

                    this.on("successmultiple", function (file, xhr, serverFileName) {
                        this.removeAllFiles(true);
                        location.reload();
                    })

                    //this.on("removedfile", function (file, xhr, serverFileName) {
                    //    alert(file.name);
                    //}),
                   
                },
            });



            $(".select2").select2();

        });
    </script>
     <script>
         $(document).ready(function () {
             $('input.tableflat').iCheck({
                 checkboxClass: 'icheckbox_flat-green',
                 radioClass: 'iradio_flat-green'
             });
         });

         var asInitVals = new Array();
         $(document).ready(function () {
             var oTable = $('#orderlist').dataTable({
                 "oLanguage": {
                     "sSearch": "Search all columns:"
                 },
                 "aoColumnDefs": [
                     {
                         'bSortable': false,
                         'aTargets': [0]
                     } //disables sorting for column one
                 ],
                 'iDisplayLength': 12,
                 "sPaginationType": "full_numbers",
                 
             });
             $("tfoot input").keyup(function () {
                 /* Filter on the column based on the index of this element's parent <th> */
                 oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
             });
             $("tfoot input").each(function (i) {
                 asInitVals[i] = this.value;
             });
             $("tfoot input").focus(function () {
                 if (this.className == "search_init") {
                     this.className = "";
                     this.value = "";
                 }
             });
             $("tfoot input").blur(function (i) {
                 if (this.value == "") {
                     this.className = "search_init";
                     this.value = asInitVals[$("tfoot input").index(this)];
                 }
             });
         });
        </script>
</asp:Content>
