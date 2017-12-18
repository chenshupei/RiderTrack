<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "宋体", serif;
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=0mxjSf6gGLHKmRoyuRCVl9OEklpcITq6"></script>
    <title>浏览器定位</title>
</head>
<body>
<div unselectable="on" class=" BMap_stdMpCtrl BMap_stdMpType0 BMap_noprint anchorTL"
     style="width: 62px; height: 192px; bottom: auto; right: auto; top: 10px; left: 10px; position: absolute; z-index: 1100; text-size-adjust: none;">
    <a type="button" class="btn btn-default" href="#" onClick="history.back(-1);"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>Back</a>
</div>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(116.331398, 39.897445);
    map.centerAndZoom(point, 12);
    var x = 116.331398;
    var y = 39.897445;

    var geolocation = new BMap.Geolocation();
    window.setInterval(location1, 5000);
    //    while (++i <= 10) {
    //        geolocation.getCurrentPosition(function (r) {
    //            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
    //                var mk = new BMap.Marker(r.point);
    //                map.addOverlay(mk);
    //                map.panTo(r.point);
    //                x = r.point.lng;
    //                y = r.point.lat;
    //                ajax();
    //            }
    //            else {
    //                alert('failed' + this.getStatus());
    //            }
    //            var xmlHttpRequest = null;
    //        }, {enableHighAccuracy: true})
    //
    //    }
    //关于状态码
    //BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
    //BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
    //BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
    //BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
    //BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
    //BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
    //BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
    //BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
    //BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)

    function ajax() {

        if (window.ActiveXObject) { //IE浏览器

            xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");

        }
        else if (window.XMLHttpRequest) { //非IE浏览器

            xmlHttpRequest = new XMLHttpRequest;
        }

        if (null !== xmlHttpRequest) {

            var v1 = x;
            var v2 = y;

            //设置好ajax的 请求方式、地址、是否异步
            //xmlHttpRequest.open("GET", "AjaxServlet?v1=" + v1 + "&v2=" + v2, true);
            //xmlHttpRequest.send(); //真正的发送请求


            //采用POST提交
            xmlHttpRequest.open("POST", "AjaxServlet", true);

            //Ajax的回调函数
            xmlHttpRequest.onreadystatechange = ajaxCallBack;

            //采用POST提交要设置请求头参数
            xmlHttpRequest.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");
            xmlHttpRequest.send("v1=" + v1 + "&v2=" + v2);//真正的发送请求
        }
    }

    //    setTimeout("ajax()", 5000);

    //Ajax的回调函数
    function ajaxCallBack() {

        if (xmlHttpRequest.readyState === 4) { //Ajax引擎4个阶段，4为最后一个阶段

            if (xmlHttpRequest.status === 200) {

                //XMLHttpReques对象取得服务器相应信息(文本、XML)
                var responseText = xmlHttpRequest.responseText;

                //将结果写入div中
                //document.getElementById("div").innerHTML = responseText;

                //ajax解析json第一种方法
                eval("var json=" + responseText);
                document.getElementById("div").innerHTML = json.name;

                //ajax解析json第二种方法
                //var json =eval("[" + responseText + "]");
                //document.getElementById("div").innerHTML = json[0].name;
            }
            else {

                document.getElementById("div").innerHTML = "服务器错误";
            }

        }
    }

    function location1() {
//        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function (r) {
            if (this.getStatus() === BMAP_STATUS_SUCCESS) {
                var mk = new BMap.Marker(r.point);
                map.addOverlay(mk);
                map.panTo(r.point);
                x = r.point.lng;
                y = r.point.lat;
                ajax();
            }
            else {
                alert('failed' + this.getStatus());
            }
        }, {enableHighAccuracy: true});
        console.log(x + "," + y + "");
    }
</script>

