<%--<!DOCTYPE html>--%>
<html>
<head>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>
    <link href="css/my-css.css" rel="stylesheet">
    <title>Map</title>
    <link href="css/map.css" rel="stylesheet">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
        <div class="navbar-right">
            <ul class="nav navbar-nav">
                <li><a href="#">close&nbsp;<span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a></li>
            </ul>
        </div>
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Activity name</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <%--<button class="btn btn-primary" data-toggle="onComment" data-target="#myModal"><span class="glyphicon glyphicon-content" aria-hidden="true"></span>content</button>--%>
                <%--<li><button class="btn btn-primary"  data-toggle="onComment" data-target="#myModal">content&nbsp;<span class="glyphicon glyphicon-content" aria-hidden="true"></span></button></li>--%>
                <li>
                    <button class="btn btn-primary" onclick='onComment()' style="position:absolute; margin-top:8px;">
                        comments&nbsp;<span class="glyphicon glyphicon-content" aria-hidden="true"></span></button>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- 模态框（Modal） -->
<div id="modal-overlay">
    <div class="modal-data">
        <div class="modal-content">
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
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it! yeah!
                                hahaha!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
                                Hahaha! Good activity! I love it!
                            </td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="content-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha!
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
                    <div class="form-group">
                        <input type="text" class="form-control" id="comment_text"
                                                   placeholder="What do you want to comment" name="comment"></div>

                    <button class="btn btn-default file-button" type="button"  onclick="document.getElementById('file-input').click();">Upload picture</button>
                    <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png" id="file-input" style="display:none" name="file">
                    <button type="button" class="btn btn-primary" onclick="onSubmit()">Submit</button>

                </form>
            </div>
        </div><!-- /.onComment-content -->
    </div><!-- /.onComment -->
</div>


<div id="container"></div>
<script type="text/javascript">

    function onSubmit() {
//        $.ajax({
//            url:"GiveCommentsServlet",//提交地址
//            data:$("#ajax_form").serialize(),//将表单数据序列化
//            type:"POST",
//            dataType:"json",
//            contentType:"application/x-www-form-urlencoded",
//            success:function(result){
//                if (result === 1) {
//                    console.log(result);
//                    document.getElementById('comment_text').value = "";
//                } else {
//                    alert("Comment failed!")
//                }
//                refresh();
//            }
//        });
        $("#ajax_form").ajaxSubmit(
            {
                url: "GiveCommentsServlet",
                type: "post",
                dataType: "json",
                contentType:"application/x-www-form-urlencoded",
                success : function (data) {
                    document.getElementById('comment_text').value = "";
                    refresh();
                }
            }
        );
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
        var string = commentObj.myName + ": " + commentObj.content + "@" + commentObj.datetime;
        console.log(string);
        $("#table").append("<tr><td align='left'><b>" + commentObj.myName + "</b>: " + commentObj.content + "</td><td align='right'>" + commentObj.datetime + "</td></tr>");
    }

    function getRandomColor() {
        return "#" + ("00000" + ((Math.random() * 16777215 + 0.5) >> 0).toString(16)).slice(-6);
    }

    function uploadLocation() {
        $.ajax(
            {
                url: "AjaxServlet",
                type: "POST",
                dataType: "json",
                data: {v1: x, v2: y, lastUpdate: lastUpdate},
                success: function (json) {
                    lastUpdate = getNowFormatDate();
                    plotLines(json);
                }
            }
        );
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

            if (markers[uName.indexOf(name)] === null) {
                markers[uName.indexOf(name)] = new BMap.Marker(pointsBD[pointsBD.length - 1]);
                map.addOverlay(markers[uName.indexOf(name)]);
                markers[uName.indexOf(name)].setAnimation(BMAP_ANIMATION_BOUNCE);
            } else {
                markers[uName.indexOf(name)].setPosition(pointsBD[pointsBD.length - 1]);
                markers[uName.indexOf(name)].setAnimation(BMAP_ANIMATION_BOUNCE);
            }

            map.addOverlay(polyline);          //增加折线
        }

    }

    function location1() {
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function (r) {
            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
                x = r.point.lng;
                y = r.point.lat;
                uploadLocation();
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
