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
            <a href="LoginServlet"  style="text-align:right">
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
                <li class="active"><a href="allActivity.jsp">All Activities</a></li>
                <li><a href="createActivity.jsp">Create Activity</a></li>
                <li><a href="PersonalCentreServlet">Personal Centre</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </div>
    <br/>


    <div class="panel-default">
        <div class="panel-heading">
            <a type="button" class="btn btn-default" href="#" onClick="history.back(-1);">Back</a>
        </div>
        <div class="panel-body">
            <div class="row details">
                <div class="col-md-4">
                    <img class="img-rounded" src="img/RiderTrack.png"/>
                    <h3><%=request.getAttribute("activity_detail_name") != null ? request.getAttribute("activity_detail_name") : "" %></h3> <!--该活动名称-->
                </div>
                <div class="col-md-8">
                    <table class="table table-hover">
                        <h1> Details</h1>
                        <tbody>
                        <tr>
                            <th scope="row">Location</th>
                            <td><%=request.getAttribute("activity_detail_location") != null ? request.getAttribute("activity_detail_location") : "" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Start date</th>
                            <td><%=request.getAttribute("activity_detail_start_date") != null ? request.getAttribute("activity_detail_start_date") : "" %></td>
                        </tr>
                        <tr>
                            <th scope="row">End date</th>
                            <td><%=request.getAttribute("activity_detail_end_date") != null ? request.getAttribute("activity_detail_end_date") : "" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Activity description</th>
                            <td><%=request.getAttribute("activity_detail_description") != null ? request.getAttribute("activity_detail_description") : "" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Type</th>
                            <td><%=request.getAttribute("activity_detail_type") != null ? request.getAttribute("activity_detail_type") : "" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Sponsor</th>
                            <td><%=request.getAttribute("activity_detail_sponsor") != null ? request.getAttribute("activity_detail_sponsor") : "" %></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="buttons">
                    <button type="button" class="btn btn-default btn-lg btn-block">Join in</button>
                    <button type="button" class="btn btn-default btn-lg btn-block">Observe</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel-default">
        <div class="panel-heading">
            <h4>Users who join in this activity</h4>
        </div>
        <!--下面这个模块是该活动的参与者,对于每一个活动，新建一个div如下-->
        <div class="panel-body">
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 displayDiv">
                <a class="thumbnail" href="personalCentre.jsp"> <!--链接到用户资料页？待定-->
                    <img src="img/sampleHeadshot.jpg" alt="activity" class="img-responsive img-circle"> <!--用户头像-->
                    <div class="caption">
                        <h4>Liu Sitong</h4>  <!--用户名字-->
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Site footer -->
    <footer class="footer">
        <p><a target="_blank"
              href="//shang.qq.com/wpa/qunwpa?idkey=0933f259e682262e57fbd2ba45834b5e88d350a7690353ac8799f7b4cd312666">
            Contact us by QQ</a>
            © 2017 SUSTech OOAD Group 10.</p>
    </footer>

</div>

</body>
</html>