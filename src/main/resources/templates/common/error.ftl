<html>
<meta charset="utf-8">
<head>
    <title>错误信息页</title>
    <link href="/css/reset.css" rel="stylesheet">
    <link href="/css/font.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.1.1/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>

<div id="myAlert" class="alert alert-warning">
    <strong>出错了呀！</strong>${e!''}错误原因：${msg!''}
    <a href="/article/list" id="go">3秒后进行自动跳转</a>
</div>

<script>
    $(function(){
        let num = 3;
        setInterval(function () {
            $("#go").html(--num+"秒后进行自动跳转");

        },1000);
        setTimeout(function () {
            location.href="/article/list";
        },3000);
    });
</script>

</body>
</html>