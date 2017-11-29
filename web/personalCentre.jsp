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
    String username = (String)session.getAttribute("username");
    String name = (String) session.getAttribute("name");
%>

<div class="container">
    <div class="row topdiv">
        <div class="col-md-8"><img src="img/RiderTrackBan.png" alt="Rider Track"/></div>
        <div class="col-md-4">
            <%
                if (session.getAttribute("name") == null || session.getAttribute("name").equals("")) {
            %>
                <a href="IconLoginServlet"  style="text-align:right">
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
                <li><a href="createActivity.jsp">Create Activity</a></li>
                <li class="active"><a href="PersonalCentreServlet">Personal Centre</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </div>
    <br/>

    <!--Personal Centre 页面-->
    <div class="tab-pane" id="PersonalCentre">
        <div class="panel panel-default">
            <!--<div class="panel-heading">-->
            <!--<h3 class="panel-title">-->
            <!--Personal Centre-->
            <!--</h3>-->
            <!--</div>-->
            <div class="row details">
                <div class="col-md-4">
                    <img class="img-circle" src="img/sampleHeadshot.jpg"/>
                </div>
                <div class="col-md-8">
                    <h1> <%=request.getAttribute("name") != null ? request.getAttribute("name") : ""%></h1>  <!--当前用户name-->
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th scope="row">
                                User name
                            </th>
                            <td><%=username != null ? username : ""%></td>  <!--当前用户username-->
                        </tr>
                        <tr>
                            <th scope="row">
                                Email address
                            </th>
                            <td><%=request.getAttribute("email_address") != null ? request.getAttribute("email_address") : ""%></td>  <!--当前用户email address-->
                        </tr>
                        <tr>
                            <th scope="row">Introduce</th> <!--待定-->
                            <td>
                                <%=request.getAttribute("Introduction") != null ? request.getAttribute("Introduction") : "Sorry, I'm a lazy guy o.O"%>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="panel-default">
        <div class="panel-heading">
            <h4>You join the following activities</h4>
        </div>
        <div class="panel-body">

            <!--下面这个模块是当前用户所参加的活动信息,对于每一个活动，新建一个div如下-->
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 displayDiv">
                <a class="thumbnail" href="details.jsp"> <!--链接活动-->
                    <img src="img/RiderTrackLogo.jpg" alt="activity" class="img-responsive img-round"> <!--活动图片-->
                    <div class="caption">
                        <h4>Cycling around SUSTech</h4>  <!--活动名字-->
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
        <p>
            user: <%=username%>
        </p>
    </footer>

</div> <!-- /container -->

<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>

<script type="text/javascript">
    $('.form_date').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0,
        startDate: "18 11 2017"
    });
</script>
</body>
</html>