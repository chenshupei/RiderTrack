<%--
  Created by IntelliJ IDEA.
  User: computer
  Date: 2017/12/13
  Time: 21:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript">
    var xmlHttpRequest = null; //声明一个空的 xmlHttpRequest对象

    function ajax()
    {

        if (window.ActiveXObject)
        { //IE浏览器

            xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");

        }
        else if (window.XMLHttpRequest)
        { //非IE浏览器

            xmlHttpRequest = new XMLHttpRequest;
        }

        if (null != xmlHttpRequest)
        {

            //获取HTML中的文本输入域值。
            var v1 = document.getElementById("value1").value;
            var v2 = document.getElementById("value2").value;

            //设置好ajax的 请求方式、地址、是否异步
            //xmlHttpRequest.open("GET", "AjaxServlet?v1=" + v1 + "&v2=" + v2, true);
            //xmlHttpRequest.send(); //真正的发送请求

            xmlHttpRequest.open("POST", "AjaxServlet", true);

            //Ajax的回调函数
            xmlHttpRequest.onreadystatechange = ajaxCallBack;

            //采用POST提交要设置请求头参数
            xmlHttpRequest.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");

            //采用POST提交
            xmlHttpRequest.send("v1=" + v1 + "&v2=" + v2);//真正的发送请求
        }
    }

    //Ajax的回调函数
    function ajaxCallBack()
    {

        if (xmlHttpRequest.readyState == 4)
        { //Ajax引擎4个阶段，4为最后一个阶段

            if (xmlHttpRequest.status == 200)
            {

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
            else
            {

                document.getElementById("div").innerHTML = "服务器错误";
            }

        }
    }
</script>
<body>

<input type="button" value="click here" onclick="ajax();" />
<br>

<input type="text" id="value1" />
<input type="text" id="value2" />

<div id="div"></div>
</body>
</html>