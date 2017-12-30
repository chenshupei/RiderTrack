<%--
  Created by IntelliJ IDEA.
  User: computer
  Date: 2017/12/20
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
    </style>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/map.css" rel="stylesheet">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=0mxjSf6gGLHKmRoyuRCVl9OEklpcITq6"></script>
    <script type="text/javascript" src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
    <title>折线上添加方向箭头</title>
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
                <%--<button class="btn btn-primary" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>comment</button>--%>
                <%--<li><button class="btn btn-primary"  data-toggle="modal" data-target="#myModal">comment&nbsp;<span class="glyphicon glyphicon-comment" aria-hidden="true"></span></button></li>--%>
                <li><button class="btn btn-primary" onclick='modal(this.id)' style="position:absolute; margin-top:8px;">comment&nbsp;<span class="glyphicon glyphicon-comment" aria-hidden="true"></span></button></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 模态框（Modal） -->
<div id="modal-overlay">
    <div class="modal-data">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" onclick='modal(this.id)' class="close">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    COMMENT
                </h4>
            </div>
            <div class="modal-body">
                <div class="row pre-scrollable">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it! yeah! hahaha!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        <tr>
                            <td class="comment-td"><b>LiuSitong:</b> Hahaha! Good activity! I love it! yeah! hahaha! Hahaha! Good activity! I love it!</td>
                            <td><span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span></td>
                        </tr>
                        </tbody>
                    </table>
                    <%--<ul class="list-group">--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                        <%--<li class="list-group-item">LiuSitong: haha!,good good good</li>--%>
                    <%--</ul>--%>
                </div>
            </div>
            <div class="modal-footer">
                <form><div class="form-group"><input type="text" class="form-control" id="comment_text" placeholder="What do you want to comment"></div>
                    <button type="submit" class="btn btn-default">Submit</button></form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">


    function modal(id) {
        var e1 = document.getElementById('modal-overlay');
        e1.style.visibility = (e1.style.visibility == "visible") ? "hidden" : "visible";
        var car_index = parseInt(id.substr(1));

        obj_id = carData[car_index].obj_id;
        obj_name = carData[car_index].obj_name;
        sessionStorage.obj_name = obj_name;
        sessionStorage.obj_id = obj_id;
    }

    // 百度地图API功能
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 14);  // 初始化地图,设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    var sy = new BMap.Symbol(BMap_Symbol_SHAPE_BACKWARD_OPEN_ARROW, {
        scale: 0.6,//图标缩放大小
        strokeColor:'#fff',//设置矢量图标的线填充颜色
        strokeWeight: '2',//设置线宽
    });
    var icons = new BMap.IconSequence(sy, '10', '30');
    // 创建polyline对象
    var pois = [
        new BMap.Point(116.350658,39.938285),
        new BMap.Point(116.386446,39.939281),
        new BMap.Point(116.389034,39.913828),
        new BMap.Point(116.442501,39.914603)
    ];
    var polyline =new BMap.Polyline(pois, {
        enableEditing: false,//是否启用线编辑，默认为false
        enableClicking: true,//是否响应点击事件，默认为true
        icons:[icons],
        strokeWeight:'8',//折线的宽度，以像素为单位
        strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
        strokeColor:"#18a45b" //折线颜色
    });

    map.addOverlay(polyline);          //增加折线
    var marker = new BMap.Marker(new BMap.Point(116.442501,39.914603));
    map.addOverlay(marker);

</script>
