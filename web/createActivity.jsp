<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="img/RiderTrack.png">

    <title>Rider Track</title>

    <!-- bootstrap和jquery -->
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/rider-track-stylesheet.css" rel="stylesheet">
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    String name = (String) session.getAttribute("name");
%>
<div class="container">


    <div class="row topdiv">
        <div class="col-md-8"><img src="img/RiderTrackBan.png" alt="Rider Track"/></div>
        <div class="col-md-4">
            <%
                if (session.getAttribute("name") == null || session.getAttribute("name").equals("")) {
            %>
            <a href="IconLoginServlet" style="text-align:right">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                Log in
            </a>
            <%
            } else {
            %>
            <a href="PersonalCentreServlet">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                <%=name%>
            </a>
            <%
                }
            %>

        </div>
    </div>
    <!--导航栏-->
    <div class="masthead">
        <nav>
            <ul class="nav nav-justified">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="allActivity.jsp">All Activities</a></li>
                <li class="active"><a href="createActivity.jsp">Create Activity</a></li>
                <li><a href="PersonalCentreServlet">Personal Centre</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </div>
    <br/>

    <!--Create Activity 页面-->
    <div class="tab-pane" id="CreateActivity">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                    New Activity
                </h3>
            </div>

            <div class="panel-body">
                <form class="form-activity" action="CreateActivityServlet" method="get">
                    <div class="form-group">
                        <label class="form-label" for="ActivityName">Activity name</label>
                        <input type="text" class="form-control" id="ActivityName" name="activityName"
                               placeholder="give your activity a proper name">
                        <%
                            if (request.getAttribute("msg_activityName") != null) {
                        %>
                        <div class="alert alert-danger"
                             role="alert"><%=request.getAttribute("msg_activityName") != null ? request.getAttribute("msg_activityName") : ""%>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="form-group">
                        <label class="form-label" for="ActivityLocation">Location</label>
                        <input type="text" class="form-control" id="ActivityLocation" name="location"
                               placeholder="where will your activity be held">
                        <%
                            if (request.getAttribute("msg_location") != null) {
                        %>
                        <div class="alert alert-danger"
                             role="alert"><%=request.getAttribute("msg_location") != null ? request.getAttribute("msg_location") : ""%>
                        </div>
                        <%
                            }
                        %>
                    </div>


                    <div class="form-group">
                        <label for="start_date">Start date</label>
                        <div class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy"
                             data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                            <input class="form-control" size="16" type="text" value="" name="startDate" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                        <input type="hidden" id="start_date" value="" name="startDate1"/><br/>
                        <%
                            if (request.getAttribute("msg_startDate") != null) {
                        %>
                        <div class="alert alert-danger"
                             role="alert"><%=request.getAttribute("msg_startDate") != null ? request.getAttribute("msg_startDate") : ""%>
                        </div>
                        <%
                            }
                        %>

                        <label for="end_date">End date</label>
                        <div class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy"
                             data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                            <input class="form-control" size="16" type="text" value="" name="endDate" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>

                        </div>
                        <input type="hidden" id="end_date" value="" name="endDate1"/><br/>
                        <%
                            if (request.getAttribute("msg_endDate") != null) {
                        %>
                        <div class="alert alert-danger"
                             role="alert"><%=request.getAttribute("msg_endDate") != null ? request.getAttribute("msg_endDate") : ""%>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <div class="form-group">
                        <label for="ActivityDescription">Activity description</label>
                        <textarea id="ActivityDescription" class="form-control" name="description" rows="3"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="ActivityType">Activity type</label>
                        <select id="ActivityType" class="form-control" name="type">
                            <option>Running</option>
                            <option>Cycling</option>
                            <option>Hiking</option>
                            <option>Mountaineering</option>
                            <option>Other</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-default">Submit</button>
                    <%
                        if (request.getAttribute("msg_submit") != null) {
                    %>
                    <div class="alert alert-danger"
                         role="alert"><%=request.getAttribute("msg_submit") != null ? request.getAttribute("msg_submit") : ""%>
                    </div>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>

    <!-- Site footer -->
    <footer class="footer">
        <p><a target="_blank"
              href="//shang.qq.com/wpa/qunwpa?idkey=0933f259e682262e57fbd2ba45834b5e88d350a7690353ac8799f7b4cd312666">
            Contact us by QQ</a>
            © 2017 SUSTech OOAD Group 10.</p>
        <p>
            user: <%=username%>
        </p>
    </footer>

</div> <!-- /container -->

<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>

<script type="text/javascript">
    $('.form_date').datetimepicker({
        format: "yyyy-mm-dd",
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
</script>
</body>
</html>