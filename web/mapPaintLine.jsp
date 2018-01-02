<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <link href="css/my-css.css" rel="stylesheet">
    <meta name="viewport" comment="initial-scale=1.0, user-scalable=no"/>
    <meta http-equiv="Content-Type" comment="text/html; charset=utf-8"/>
    <title>Hello, World</title>
    <style type="text/css">
        html {
            height: 100%
        }

        body {
            height: 100%;
            margin: 0px;
            padding: 0px
        }

        #container {
            height: 100%;
            margin: 20px;
        }
    </style>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/map.css" rel="stylesheet">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=YWdGplhYjUGQ3GtpKNeuTM2S"></script>
</head>

<body>

<nav class="navbar navbar-default nav-justified navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="pull-right">
            <ul class="nav navbar-nav">
                <li><a href="#">close&nbsp;<span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a></li>
            </ul>
        </div>
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Activity name</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <%--<button class="btn btn-primary" data-toggle="onComment" data-target="#myModal"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>comment</button>--%>
                <%--<li><button class="btn btn-primary"  data-toggle="onComment" data-target="#myModal">comment&nbsp;<span class="glyphicon glyphicon-comment" aria-hidden="true"></span></button></li>--%>
                <li>
                    <button class="btn btn-primary" onclick='onComment()' style="position:absolute; margin-top:8px;">
                        comment&nbsp;<span class="glyphicon glyphicon-comment" aria-hidden="true"></span></button>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- 模态框（Modal） -->
<div id="modal-overlay">
    <div class="modal-data">
        <div class="modal-comment">
            <div class="modal-header">
                <button type="button" onclick='onComment()' class="close">
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    COMMENT
                </h4>
            </div>
            <div class="modal-body">
                <div class="row pre-scrollable">
                    <table class="table table-hover">
                        <tbody id="table">
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it! yeah!
                                hahaha!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <form id="ajax_form" class="ajax_form" name="ajax_form">
                    <div class="form-group"><input type="text" class="form-control" id="comment_text"
                                                   placeholder="What do you want to comment" name="comment"></div>
                    <input type="button" class="btn_submit" onclick="onSubmit()" value="submit"/>
                </form>
            </div>
        </div><!-- /.onComment-comment -->
    </div><!-- /.onComment -->
</div>


<div id="container"></div>
<script type="text/javascript">

    function onSubmit() {
        $.ajax({
            url:"GiveCommentsServlet",//提交地址
            data:$("#ajax_form").serialize(),//将表单数据序列化
            type:"POST",
            dataType:"json",
            success:function(result){
                if (result === 1) {
                    console.log(result);
                    document.getElementById('comment_text').value = "";
                } else {
                    alert("Comment failed!")
                }
                refresh();
            }
        });

    }


    function onComment() {
        var e1 = document.getElementById('modal-overlay');
        e1.style.visibility = (e1.style.visibility === "visible") ? "hidden" : "visible";
        refresh();
    }

    function refresh() {
        $.ajax({
            url: "DisplayCommentsServlet",//提交地址
            type: "GET",
            success: function (jsonString) {
                displayComments(jsonString)
            }
        });
    }

    function displayComments(jsonString) {
        var json = JSON.parse(jsonString);
        console.log(json);
        $("#table").text("");
        for (var i = 0; i <= json.length - 1; i++) {
            addRaw(json[i]);
        }
    }

    function addRaw(commentObj) {
        var string = commentObj.myName + ": " + commentObj.comment + "@" + commentObj.datetime;
        console.log(string);
        $("#table").append("<tr><td>" + string + "</td></tr>");
    }

    function getRandomColor() {
        return "#" + ("00000" + ((Math.random() * 16777215 + 0.5) >> 0).toString(16)).slice(-6);
    }

    function ajax() {

        console.log("Enter ajax");

        if (window.ActiveXObject) { //IE浏览器

            xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");

        }
        else if (window.XMLHttpRequest) { //非IE浏览器

            xmlHttpRequest = new XMLHttpRequest;
        }

        if (null !== xmlHttpRequest) {

            var v1 = x;
            var v2 = y;

            //采用POST提交
            xmlHttpRequest.open("POST", "AjaxServlet", true);

            //Ajax的回调函数
            xmlHttpRequest.onreadystatechange = ajaxCallBack;

            //采用POST提交要设置请求头参数
            xmlHttpRequest.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");
            xmlHttpRequest.send("v1=" + v1 + "&v2=" + v2 + "&lastUpdate=" + lastUpdate);//真正的发送请求
        }
    }


    //Ajax的回调函数
    function ajaxCallBack() {

        if (xmlHttpRequest.readyState === 4) { //Ajax引擎4个阶段，4为最后一个阶段

            if (xmlHttpRequest.status === 200) {

                // Download (x, y) as well as bean of each participant.
                var responseText = xmlHttpRequest.responseText;
                var json = JSON.parse(responseText);
                lastUpdate = getNowFormatDate();
                plotLines(json);
            }
            else {
                alert("Server error!");
            }

        }
    }


    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        return date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    }

    function plotLines(json) {
        for (var k in json) {
            console.log(json[k].username);
            var name = json[k].username;
            if (uName.indexOf(name) === -1) {
                uName.push(name);
                clName.push(getRandomColor());
                markers.push(null);
            }
            var points = json[k].positions;
            var pointsBD = [];
            for (var i = 0; i < points.length; i++) {
                pointsBD.push(new BMap.Point(points[i][0], points[i][1]));
            }

            var polyline = new BMap.Polyline(pointsBD, {
                enableEditing: false,//是否启用线编辑，默认为false
                enableClicking: true,//是否响应点击事件，默认为true
                strokeWeight: '2',//折线的宽度，以像素为单位
                strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
                strokeColor: clName[uName.indexOf(name)] //折线颜色
            });

            if (markers[uName.indexOf(name)] !== null) {
                map.removeOverlay(markers[uName.indexOf(name)]);
            }

            markers[uName.indexOf(name)] = new BMap.Marker(pointsBD[pointsBD.length - 1]);
            map.addOverlay(markers[uName.indexOf(name)]);
            markers[uName.indexOf(name)].setAnimation(BMAP_ANIMATION_BOUNCE);

            map.addOverlay(polyline);          //增加折线
        }

    }

    function location1() {
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function (r) {
            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
                x = r.point.lng;
                y = r.point.lat;
                ajax();
            }
            else {
                alert('failed' + this.getStatus());
            }
        }, {enableHighAccuracy: true});

        setTimeout(location1, 2000);
    }

    var map = new BMap.Map("container");
    map.centerAndZoom(new BMap.Point(103.388611, 35.563611), 5); //初始显示中国。
    map.enableScrollWheelZoom();//滚轮放大缩小

    var lastUpdate = "1000-00-00 00:00:00";

    var x;
    var y;

    var uName = [];
    var clName = [];

    var markers = [];

    setTimeout(location1, 1000);//动态生成新的点。
</script>
