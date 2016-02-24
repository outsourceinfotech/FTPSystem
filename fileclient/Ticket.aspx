<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="fileclient.Ticket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
     <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="css/animate.min.css" rel="stylesheet"/>
    <link href="css/custom.css" rel="stylesheet"/>
    <link href="css/icheck/flat/green.css" rel="stylesheet"/>
    <link href="css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet"/>

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
                 <!-- top tiles -->
                <div class="row tile_count">
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Total Users</span>
                            <div class="count">2500</div>
                            <span class="count_bottom"><i class="green">4% </i> From last Week</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Average Time</span>
                            <div class="count">123.50</div>
                            <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>3% </i> From last Week</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Total Males</span>
                            <div class="count green">2,500</div>
                            <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Total Females</span>
                            <div class="count">4,567</div>
                            <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Total Collections</span>
                            <div class="count">2,315</div>
                            <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-user"></i> Total Connections</span>
                            <div class="count">7,325</div>
                            <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                        </div>
                    </div>

                </div>
                <!-- /top tiles -->
                <div class="">
                    <%--<div class="page-title">
                        <div class="title_left">
                            <h3>Invoice<small>Some examples to get you started</small></h3>
                        </div>
                        <div class="title_right">
                            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search for..."/>
                                    <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Go!</button>
                        </span>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <div class="clearfix"></div>

                    <div class="row">

                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Tickets <small></small></h2>
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
                                   <div class="row">
                                        <div class="col-xs-12">
                                          <!-- /.box -->
                                            <div class="box-header">
                                            </div><!-- /.box-header -->
                                            <div class="box-body">
                                                 <table id="ticketlist" class="table table-striped responsive-utilities jambo_table bulk_action">
                                        <thead>
                                            <tr class="headings">
                                                <th class="column-title" style="display: table-cell;">Date</th>
                                                <th class="column-title" style="display: table-cell;">Title</th>
                                                <th class="column-title" style="display: table-cell;">Queue</th>
                                                <th class="column-title" style="display: table-cell;">Reason </th>
                                                <th class="column-title" style="display: table-cell;">Status</th>
                                                <th class="column-title" style="display: table-cell;">Actions</th>
                                                <th class="bulk-actions" colspan="7" style="display: none;">
                                                  <a class="antoo" style="color:#fff; font-weight:500;">
                                                      Bulk Actions ( <span class="action-cnt">1 Records Selected</span> )
                                                      <i class="fa fa-chevron-down"></i>
                                                  </a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="odd pointer">
                                               <td class=" ">Jan. 20, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Amendment</td>
                                                <td class=" last">Closed</td>
                                                 <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                            <tr class="even pointer">
                                               <td class=" ">Jan. 19, 2016, 2:13 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Amendment</td>
                                                <td class=" last">Closed</td>
                                                 <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                            <tr class="odd pointer">
                                               <td class=" ">Jan. 18, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Incorrect Asset</td>
                                                <td class=" last">Closed</td>
                                                  <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                            <tr class="even pointer">
                                               <td class=" ">Jan. 17, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Amendment</td>
                                                <td class=" last">Closed</td>
                                                  <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                            <tr class="odd pointer">
                                               <td class=" ">Jan. 16, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Incorrect Asset</td>
                                                <td class=" last">Closed</td>
                                                  <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                            <tr class="even pointer">
                                               <td class=" ">Jan. 15, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Amendment</td>
                                                <td class=" last">Closed</td>
                                                  <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                          <tr class="odd pointer">
                                               <td class=" ">Jan. 15, 2016, 2:23 p.m.</td>
                                                <td class=" ">Ticket for Job: 731000017 for asset: 03.jpg</td>
                                                <td class=" ">File Queue <i class="success fa fa-long-arrow-up"></i></td>
                                                <td class=" ">Amendment</td>
                                                <td class=" last">Closed</td>
                                                <td class=" last"><a href="Ticket_view.aspx">View</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                            </div><!-- /.box-body -->
                                        </div><!-- /.col -->
                                      </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />

                    </div>
                </div>
                    <!-- footer content -->
                </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScript" runat="server">
     <!-- Datatables -->

        <script src="js/datatables/js/jquery.dataTables.js"></script>
        <script src="js/datatables/tools/js/dataTables.tableTools.js"></script>
      <script src="js/bootstrap.min.js"></script>
    <script src="js/chartjs/chart.min.js"></script>
    <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
    <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
    <script src="js/icheck/icheck.min.js"></script>
    <script src="js/select/select2.full.js"></script>
    <script src="js/dropzone/dropzone.js"></script>
    <script src="js/custom.js"></script>
      <script>
          $(document).ready(function () {
              $('input.tableflat').iCheck({
                  checkboxClass: 'icheckbox_flat-green',
                  radioClass: 'iradio_flat-green'
              });
          });

          var asInitVals = new Array();
          $(document).ready(function () {
              var oTable = $('#ticketlist').dataTable({
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
                  "dom": 'T<"clear">lfrtip',
                  "tableTools": {
                      "sSwfPath": "<?php echo base_url('assets2/js/Datatables/tools/swf/copy_csv_xls_pdf.swf'); ?>"
                  }
              });
              $(row).children("button").attr("disabled", "disabled");
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
