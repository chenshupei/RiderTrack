<%@ page import="java.util.LinkedList" %>
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
//        session.setAttribute("username", username);
%>
<div class="container">

    <div class="row topdiv">
        <div class="col-md-8"><img src="img/RiderTrackBan.png" alt="Rider Track"/></div>
        <div class="col-md-4">
            <%
                if (session.getAttribute("name") == null || session.getAttribute("name").equals("")) {
                    session.setAttribute("login_state", "false");
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
                <li class="active"><a href="home.jsp">Home</a></li>
                <li><a href="allActivity.jsp">All Activities</a></li>
                <li><a href="createActivity.jsp">Create Activity</a></li>
                <li><a href="PersonalCentreServlet">Personal Centre</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </div>
    <br/>


    <!--home 页面-->
    <div class="tab-pane fade in active" id="home">
        <!--登陆窗口-->
        <div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title">
                            Please log in here
                        </h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-signin" action="LoginServlet" method="get">
                            <label for="inputUsername" class="sr-only">User name</label>
                            <input type="text" id="inputUsername" class="form-control" placeholder="Username"
                                   name="username"
                                   value="<%=request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                                   required autofocus/>

                            <label for="inputPassword" class="sr-only">Password</label>
                            <input type="password" id="inputPassword" class="form-control" placeholder="Password"
                                   name="password"
                                   value="<%=request.getAttribute("password") != null ? request.getAttribute("password") : "" %>"
                                   required/>

                            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                            <%
                                if (request.getAttribute("msg") != null) {
                                    if (request.getAttribute("msg") == "Register is success, please login to the system") {
                            %>
                            <div class="alert alert-success" role="alert"><%=request.getAttribute("msg")%>
                            </div>

                            <%

                            } else {
                            %>
                            <div class="alert alert-danger" role="alert"><%=request.getAttribute("msg")%>
                            </div>

                            <%
                                    }
                                }
                            %>
                            <p align="right">or you can <a data-dismiss="modal" aria-hidden="true" data-toggle="modal"
                                                           data-target="#SignupModal">sign up</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--注册窗口-->
        <div class="modal fade" id="SignupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" id="myModalLabel">
                            Sign up
                        </h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-signin" action="RegisterServlet" method="post">
                            <%--<label for="inputEmail2" class="sr-only">E-mail</label>--%>
                            <%--<input type="email" id="inputEmail2" class="form-control" placeholder="E-mail"  required autofocus>--%>

                            <label for="inputUsername2" class="sr-only">Username</label>
                            <input type="text" id="inputUsername2" class="form-control" placeholder="User name"
                                   name="username"
                                   value="<%=request.getAttribute("username") != null ? request.getAttribute("username") : ""%>"
                                   required autofocus>

                            <label for="inputUsername2" class="sr-only">Name</label>
                            <input type="text" id="inputUsername2" class="form-control" placeholder="Real name"
                                   name="name"
                                   value="<%=request.getAttribute("name") != null ? request.getAttribute("name") : ""%>"
                                   required autofocus>

                            <label for="inputPassword" class="sr-only">Password</label>
                            <input type="password" id="inputPassword2" class="form-control" placeholder="Password"
                                   name="password"
                                   value="<%=request.getAttribute("password") != null ? request.getAttribute("password") : ""%>"
                                   required autofocus>

                            <input type="password" id="inputPassword2r" class="form-control"
                                   placeholder="Confirm password" name="con_password"
                                   value="<%=request.getAttribute("con_password") != null ? request.getAttribute("con_password") : ""%>"
                                   required>
                            <%if (request.getAttribute("msg_con_password") != null && !request.getAttribute("msg_con_password").equals("")) { %>

                            <div class="alert alert-success" role="alert"><%=request.getAttribute("msg_con_password")%>
                            </div>
                            <%
                                }
                            %>
                            <!--<div class="checkbox">-->
                            <!--<label>-->
                            <!--<input type="checkbox" value="remember-me"> Remember me-->
                            <!--</label>-->
                            <!--</div>-->

                            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                            <p align="right">If you have a account, you can <a data-dismiss="modal" aria-hidden="true"
                                                                               data-toggle="modal"
                                                                               data-target="#LoginModal">Log in</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Jumbotron超大屏幕 -->
        <%
            if (username == null || username.equals("")) {
        %>
        <div class="jumbotron">
            <h1>Rider Track</h1>
            <p class="lead">Ride Track is an online application that can allow multiple users to share their location
                and track at the same time. It would make your activity more attractive!</p>
            <p><a class="btn btn-lg btn-success" href="#" role="button" data-toggle="modal" data-target="#LoginModal">
                Get started now!</a></p>
        </div>
        <%
        } else {
        %>
        <div id="myCarousel" class="carousel slide">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="img/carousel1.jpg" alt="First slide">
                </div>
                <div class="item">
                    <img src="img/carousel2.jpg" alt="Second slide">
                </div>
                <div class="item">
                    <img src="img/carousel3.jpg" alt="Third slide">
                </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
            <a class="carousel-control left" href="#myCarousel"
               data-slide="prev">&lsaquo;
            </a>
            <a class="carousel-control right" href="#myCarousel"
               data-slide="next">&rsaquo;
            </a>
        </div>

        <%
            }
        %>

        <!-- 介绍三列 -->
        <div class="row">
            <div class="col-lg-4">
                <h2>View all the activities!</h2>
                <p> You can view all the created activities here. So you can choose the ones you interested in.
                    Welcome!</p>
                <p><a class="btn btn-primary" href="allActivity.jsp" role="button">Click here &raquo;</a></p>
            </div>
            <div class="col-lg-4">
                <h2>Create your own activity!</h2>
                <p>Just put the information of your activity here, and wait for others to join you!</p>
                <p><a class="btn btn-primary" href="createActivity.jsp" role="button">Click here &raquo;</a></p>
            </div>
            <div class="col-lg-4">
                <h2>About us</h2>
                <p>We are students from Southern University of Science and Technology. We build the website for a course
                    project.</p>
                <p><a class="btn btn-primary" href="about.jsp" role="button">Click here &raquo;</a></p>
            </div>
        </div>
    </div>


    <!-- Site footer -->
    <footer class="footer">
        <p><a target="_blank"
              href="//shang.qq.com/wpa/qunwpa?idkey=0933f259e682262e57fbd2ba45834b5e88d350a7690353ac8799f7b4cd312666">
            Contact us by QQ</a>
            &#169 2017 SUSTech OOAD Group 10.

            <%=request.getAttribute("msg_welcome") != null ? request.getAttribute("msg_welcome") : ""%>
        </p>
        <p>
            user: <%=username%>
        </p>
    </footer>
</div>
<%
    if ((request.getAttribute("msg_hide") != null) && (request.getAttribute("msg_hide").equals("show")) || (session.getAttribute("msg_hide") != null) && (session.getAttribute("msg_hide").equals("show"))) {
        session.setAttribute("msg_hide", "hide");
%>
<script type="text/javascript">
    $("#LoginModal").modal('show');
</script>
<%
    }
%>
</body>
</html>