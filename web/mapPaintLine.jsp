<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Hello, World</title>
    <style type="text/css">
        html{height:100%}
        body{height:100%;margin:0px;padding:0px}
        #container{height:100%;margin: 20px;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=YWdGplhYjUGQ3GtpKNeuTM2S"></script>

</head>

<body>
<div id="container"></div>
<script type="text/javascript">


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
            var points = json[k].positions;
            var pointsBD = [];
            for (var i = 0; i < points.length; i++) {
                pointsBD.push(new BMap.Point(points[i][0], points[i][1]));
            }
            var pois = [
                new BMap.Point(116.350658, 39.938285),
                new BMap.Point(116.386446, 39.939281),
                new BMap.Point(116.389034, 39.913828),
                new BMap.Point(116.442501, 39.914603)
            ];
            console.log(pois);
            console.log(pointsBD);

            var polyline = new BMap.Polyline(pointsBD, {
                enableEditing: false,//是否启用线编辑，默认为false
                enableClicking: true,//是否响应点击事件，默认为true
                strokeWeight: '8',//折线的宽度，以像素为单位
                strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
                strokeColor: "#18a45b" //折线颜色
            });


            map.addOverlay(polyline);          //增加折线
            var marker = new BMap.Marker(pointsBD[pointsBD.length - 1]);
            map.addOverlay(marker);
        }
    }

    function location1() {
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

        setTimeout(location1, 5000);
    }

    var map = new BMap.Map("container");
    map.centerAndZoom(new BMap.Point(103.388611,35.563611), 5); //初始显示中国。
    map.enableScrollWheelZoom();//滚轮放大缩小

    var geolocation = new BMap.Geolocation();
    var lastUpdate = "1000-00-00 00:00:00";

    var x;
    var y;

    setTimeout(location1, 1000);//动态生成新的点。
</script>
