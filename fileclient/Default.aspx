<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="fileclient.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="Head" runat="server">
    <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/maps/jquery-jvectormap-2.0.1.css" />
    <link href="css/icheck/flat/green.css" rel="stylesheet" />
    <link href="css/floatexamples.css" rel="stylesheet" type="text/css" />

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
    
    <script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.0/jquery-ui.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/3.5.0/lodash.min.js"></script>
   
    <link href="gridstack.css" rel="stylesheet" />
    <script src="gridstack.js"></script>
    <style>
        .upload_img{
            width:100%;
            height:auto;
            max-width:500px;
            max-height:450px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
                <div class="clearfix"></div>
        <div class="right_col" role="main" style="margin-top:-10px; padding-bottom:10px;">
            <div class="row title_count">
            <div class="grid-stack">
                <div class="grid-stack-item" data-gs-x="0" data-gs-y="0" data-gs-width="12" data-gs-height="3" data-gs-no-move="true" data-gs-no-resize="true">
                  <div class="grid-stack-item-content">
                   <div class="row tile_count" style="width: 100%;">
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Total Folders Count</span>
                            <div class="count blue"><%=Total_Folder_Count%></div>
                            <span class="count_bottom"><b class="green">Folders </b> From last Month</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Total Files Count</span>
                            <div class="count blue"><%=Total_File_Count%></div>
                            <span class="count_bottom"><b class="green">Files</b> From last Month</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Closed Order Count</span>
                            <div class="count blue"><%=Completed_Order_Count%></div>
                            <span class="count_bottom"><b class="green">Folders </b> From last Month</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Cancel Order Count</span>
                            <div class="count blue"><%=Cancel_Order_Count%></div>
                            <span class="count_bottom"><b class="green">Folders </b> From last Month</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Editing Order count</span>
                            <div class="count blue"><%=Editing_Order_Count%></div>
                            <span class="count_bottom"><b class="green">Folders </b> From last day</span>
                        </div>
                    </div>
                    <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                        <div class="left"></div>
                        <div class="right">
                            <span class="count_top"><i class="fa fa-clock-o"></i> Uploaded Order count</span>
                            <div class="count blue"><%=Uploaded_Order_Count %></div>
                            <span class="count_bottom"><b class="green">Folders </b> From last day</span>
                        </div>
                    </div>

                </div>
                        </div>
                </div>
                 <div class="grid-stack-item" data-gs-x="0" data-gs-y="3" data-gs-width="2" data-gs-height="0" data-gs-no-resize="true">
                    <div class=" grid-stack-item-content">
                        </div>
                </div> 
                <div class="grid-stack-item" data-gs-x="2" data-gs-y="3" data-gs-width="3" data-gs-height="auto" data-gs-no-resize="true">
                    <div class="x_panel tile grid-stack-item-content">
                        <div>
                            <a href="upload.aspx"><img src="images/Button-Upload-icon.png" class="upload_img" /></a>
                            <a href="upload.aspx"><h1  style="text-align: center;">Upload Folder</h1></a>
                            </div>
                        </div>
            </div> 
                <div class="grid-stack-item" data-gs-x="6" data-gs-y="3" data-gs-width="3" data-gs-height="auto" data-gs-no-resize="true">
                    <div class="x_panel tile grid-stack-item-content">
                          <div>
                            <a href="orders.aspx"><img src="images/Button-Download-icon.png" class="upload_img" /></a>
                            <a href="orders.aspx"><h1  style="text-align: center;">Download Folder</h1></a>
                            </div>
                        </div>
                </div> 
                 <div class="grid-stack-item" data-gs-x="9" data-gs-y="3" data-gs-width="2" data-gs-height="0" data-gs-no-resize="true">
                    <div class=" grid-stack-item-content">
                        </div>
                </div> 
                <%--<div class="grid-stack-item" data-gs-x="0" data-gs-y="9" data-gs-width="4" data-gs-height="5" data-gs-no-resize="true">
                       <div class="x_panel tile  grid-stack-item-content">
                            <div class="x_title">
                                <h2>Quick Settings</h2>
                                <ul class="nav navbar-right panel_toolbox">                                 
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="#">Settings 1</a>
                                            </li>
                                            <li><a href="#">Settings 2</a>
                                            </li>
                                        </ul>
                                    </li>                                   
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="dashboard-widget-content">
                                    <ul class="quick-list">
                                        <li><i class="fa fa-calendar-o"></i><a href="#">Settings</a>
                                        </li>
                                        <li><i class="fa fa-bars"></i><a href="#">Subscription</a>
                                        </li>
                                        <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                                        <li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                                        </li>
                                        <li><i class="fa fa-line-chart"></i><a href="#">profile</a>
                                        </li>
                                        <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                                        <li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                                        </li>
                                        <li><i class="fa fa-area-chart"></i><a href="#">Logout</a>
                                        </li>
                                    </ul>

                                    <div class="sidebar-widget">
                                        <h4>Profile Completion</h4>
                                        <canvas width="150" height="80" id="foo" class="" style="width: 160px; height: 100px;"></canvas>
                                        <div class="goal-wrapper">
                                            <span class="gauge-value pull-left">$</span>
                                            <span id="gauge-text" class="gauge-value pull-left">3,200</span>
                                            <span id="goal-text" class="goal-value pull-right">$5,000</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>--%>
             <%--   <div class="grid-stack-item" data-gs-x="0" data-gs-y="7" data-gs-width="4" data-gs-height="5" data-gs-no-resize="true">
                       <div class="x_panel grid-stack-item-content">
                            <div class="x_title">
                                <h2>Recent Activities <small>Sessions</small></h2>
                                <ul class="nav navbar-right panel_toolbox">                                 
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="#">Settings 1</a>
                                            </li>
                                            <li><a href="#">Settings 2</a>
                                            </li>
                                        </ul>
                                    </li>                                   
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="dashboard-widget-content">

                                    <ul class="list-unstyled timeline widget">
                                        <li>
                                            <div class="block">
                                                <div class="block_content">
                                                    <h2 class="title">
                                            <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                        </h2>
                                                    <div class="byline">
                                                        <span>13 hours ago</span> by <a>Jane Smith</a>
                                                    </div>
                                                    <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="block">
                                                <div class="block_content">
                                                    <h2 class="title">
                                            <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                        </h2>
                                                    <div class="byline">
                                                        <span>13 hours ago</span> by <a>Jane Smith</a>
                                                    </div>
                                                    <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </li>
                                       
                                       
                                        
                                    </ul>
                                </div>
                            </div>
                        </div>
                 </div>
                <div class="grid-stack-item" data-gs-x="4" data-gs-y="8" data-gs-width="4" data-gs-height="5" data-gs-no-resize="true">
                      <div class="x_panel grid-stack-item-content">
                                    <div class="x_title">
                                        <h2>To Do List <small>Sample tasks</small></h2>
                                        <ul class="nav navbar-right panel_toolbox">                                 
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="#">Settings 1</a>
                                            </li>
                                            <li><a href="#">Settings 2</a>
                                            </li>
                                        </ul>
                                    </li>                                   
                                </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">

                                        <div class="">
                                            <ul class="to_do">
                                                <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Schedule meeting with new client </p>
                                                </li>
                                                <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Create email address for new intern</p>
                                                </li>
                                                <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Have IT fix the network printer</p>
                                                </li>
                                                <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Copy backups to offsite location</p>
                                                </li>
                                                <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Food truck fixie locavors mcsweeney</p>
                                                </li>
                                                 <li>
                                                    <p>
                                                        <input type="checkbox" class="flat"> Have IT fix the network printer</p>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                 </div>     --%>    
                
                </div>         
                </div>
        </div>
     <div class="clearfix"></div>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="FooterScript" runat="server">
    
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

    <script src="js/custom.js"></script>
     
    <script type="text/javascript">
        $(function () {
            var options = {
                animate: true
            };
            $('.grid-stack').gridstack(options);
        });
    </script>
    <!-- flot js -->
    <!--[if lte IE 8]><script type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->
    <script type="text/javascript" src="js/flot/jquery.flot.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.pie.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.orderBars.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.time.min.js"></script>
    <script type="text/javascript" src="js/flot/date.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.spline.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.stack.js"></script>
    <script type="text/javascript" src="js/flot/curvedLines.js"></script>
    <script type="text/javascript" src="js/flot/jquery.flot.resize.js"></script>
    <script>
        $(document).ready(function () {
            // [17, 74, 6, 39, 20, 85, 7]
            //[82, 23, 66, 9, 99, 6, 2]
            var data1 = [[gd(2012, 1, 1), 17], [gd(2012, 1, 2), 74], [gd(2012, 1, 3), 6], [gd(2012, 1, 4), 39], [gd(2012, 1, 5), 20], [gd(2012, 1, 6), 85], [gd(2012, 1, 7), 7]];

            var data2 = [[gd(2012, 1, 1), 82], [gd(2012, 1, 2), 23], [gd(2012, 1, 3), 66], [gd(2012, 1, 4), 9], [gd(2012, 1, 5), 119], [gd(2012, 1, 6), 6], [gd(2012, 1, 7), 9]];
            $("#canvas_dahs").length && $.plot($("#canvas_dahs"), [
                data1, data2
            ], {
                series: {
                    lines: {
                        show: false,
                        fill: true
                    },
                    splines: {
                        show: true,
                        tension: 0.4,
                        lineWidth: 1,
                        fill: 0.4
                    },
                    points: {
                        radius: 0,
                        show: true
                    },
                    shadowSize: 2
                },
                grid: {
                    verticalLines: true,
                    hoverable: true,
                    clickable: true,
                    tickColor: "#d5d5d5",
                    borderWidth: 1,
                    color: '#fff'
                },
                colors: ["rgba(38, 185, 154, 0.38)", "rgba(3, 88, 106, 0.38)"],
                xaxis: {
                    tickColor: "rgba(51, 51, 51, 0.06)",
                    mode: "time",
                    tickSize: [1, "day"],
                    //tickLength: 10,
                    axisLabel: "Date",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 10
                    //mode: "time", timeformat: "%m/%d/%y", minTickSize: [1, "day"]
                },
                yaxis: {
                    ticks: 8,
                    tickColor: "rgba(51, 51, 51, 0.06)",
                },
                tooltip: false
            });

            function gd(year, month, day) {
                return new Date(year, month - 1, day).getTime();
            }
        });
    </script>

    <!-- worldmap -->
    <script type="text/javascript" src="js/maps/jquery-jvectormap-2.0.1.min.js"></script>
    <script type="text/javascript" src="js/maps/gdp-data.js"></script>
    <script type="text/javascript" src="js/maps/jquery-jvectormap-world-mill-en.js"></script>
    <script type="text/javascript" src="js/maps/jquery-jvectormap-us-aea-en.js"></script>
    <script>
        $(function () {
            $('#world-map-gdp').vectorMap({
                map: 'world_mill_en',
                backgroundColor: 'transparent',
                zoomOnScroll: false,
                series: {
                    regions: [{
                        values: gdpData,
                        scale: ['#E6F2F0', '#149B7E'],
                        normalizeFunction: 'polynomial'
                    }]
                },
                onRegionTipShow: function (e, el, code) {
                    el.html(el.html() + ' (GDP - ' + gdpData[code] + ')');
                }
            });
        });
    </script>
    <!-- skycons -->
    <script src="js/skycons/skycons.js"></script>
    <script>
        var icons = new Skycons({
            "color": "#73879C"
        }),
            list = [
                "clear-day", "clear-night", "partly-cloudy-day",
                "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
                "fog"
            ],
            i;

        for (i = list.length; i--;)
            icons.set(list[i], list[i]);

        icons.play();
    </script>

    <!-- dashbord linegraph -->
    <script>
        var doughnutData = [
            {
                value: 30,
                color: "#455C73"
            },
            {
                value: 30,
                color: "#9B59B6"
            },
            {
                value: 60,
                color: "#BDC3C7"
            },
            {
                value: 100,
                color: "#26B99A"
            },
            {
                value: 120,
                color: "#3498DB"
            }
        ];
        var myDoughnut = new Chart(document.getElementById("canvas1").getContext("2d")).Doughnut(doughnutData);
    </script>
    <!-- /dashbord linegraph -->
    <!-- datepicker -->
    <script type="text/javascript">
        $(document).ready(function () {

            var cb = function (start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                //alert("Callback has fired: [" + start.format('MMMM D, YYYY') + " to " + end.format('MMMM D, YYYY') + ", label = " + label + "]");
            }

            var optionSet1 = {
                startDate: moment().subtract(29, 'days'),
                endDate: moment(),
                minDate: '01/01/2012',
                maxDate: '12/31/2015',
                dateLimit: {
                    days: 60
                },
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                opens: 'left',
                buttonClasses: ['btn btn-default'],
                applyClass: 'btn-small btn-primary',
                cancelClass: 'btn-small',
                format: 'MM/DD/YYYY',
                separator: ' to ',
                locale: {
                    applyLabel: 'Submit',
                    cancelLabel: 'Clear',
                    fromLabel: 'From',
                    toLabel: 'To',
                    customRangeLabel: 'Custom',
                    daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    firstDay: 1
                }
            };
            $('#reportrange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
            $('#reportrange').daterangepicker(optionSet1, cb);
            $('#reportrange').on('show.daterangepicker', function () {
                console.log("show event fired");
            });
            $('#reportrange').on('hide.daterangepicker', function () {
                console.log("hide event fired");
            });
            $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
                console.log("apply event fired, start/end dates are " + picker.startDate.format('MMMM D, YYYY') + " to " + picker.endDate.format('MMMM D, YYYY'));
            });
            $('#reportrange').on('cancel.daterangepicker', function (ev, picker) {
                console.log("cancel event fired");
            });
            $('#options1').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
            });
            $('#options2').click(function () {
                $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
            });
            $('#destroy').click(function () {
                $('#reportrange').data('daterangepicker').remove();
            });
        });
    </script>
    <script>
        NProgress.done();
    </script>
    <!-- /datepicker -->
</asp:Content>

    