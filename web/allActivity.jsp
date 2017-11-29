<%@ page import="bean.ActivityBean" %>
<%@ page import="service.ActivityService" %>
<%@ page import="service.ActivityServiceImpl" %>
<%@ page import="java.util.List" %>
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
                <li class="active"><a href="allActivity.jsp">All Activities</a></li>
                <li><a href="createActivity.jsp">Create Activity</a></li>
                <li><a href="PersonalCentreServlet">Personal Centre</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </div>
    <br/>


    <!--All activity 页面-->
    <div class="panel panel-default">

        <div class="panel-body">
            <div class="tab-pane" id="AllActivity">

                <div class="row">
                    <%
                        List<ActivityBean> activityBeanList = null;
                        if (request.getAttribute("activityList") != null) {
                            activityBeanList = (List<ActivityBean>) request.getAttribute("activityList");
                        }else {
                            ActivityService activityService = new ActivityServiceImpl();
                            activityBeanList = activityService.fetchActivityList();
                        }
                        if (activityBeanList != null && activityBeanList.size() > 0) {
                            for (int i=0;i<activityBeanList.size();i++) {
                                //session.setAttribute("activity_detail", activityBeanList.get(i));
                                System.out.println(activityBeanList.get(i).getId());
                    %>
                    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 displayDiv"><!-- 大屏幕放3张略缩图，pc端放4张，平板和手机放6张-->
                        <a class="thumbnail" href="ShowDetailServlet?id=<%=activityBeanList.get(i).getId()%>">
                            <img src="img/RiderTrack.png" alt="..." class="img-responsive"> <!--图片-->
                            <div class="caption">
                                <h4> <%=activityBeanList.get(i).getActivityName()%> </h4>   <!--活动名称-->
                                <p style="color:midnightblue">
                                    <span class="glyphicon glyphicon-flag" aria-hidden="true"></span> <%=activityBeanList.get(i).getLocation()%> <br/> <!--活动地点-->
                                    <span class="glyphicon glyphicon-time" aria-hidden="true"></span>  From <%=activityBeanList.get(i).getStartDate()%> to <%=activityBeanList.get(i).getStartDate()%> <!--活动开始结束时间-->
                                    <br/>
                                </p>
                            </div>
                        </a>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
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

</div>


</body>
</html>