<html>
<meta charset="utf-8">
<head>
    <title> ${titleName}</title>
    <link href="/css/reset.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/js/bootstrap.min.js"
            type="text/javascript"></script>
</head>
<style>
    body {
        background: #f0eef5;
    }

    .top-nav {
        background-color: #343a40 !important;
    }

    .content {
        margin-top: 50px;
    }

    .media {
        margin-bottom: 30px;
        cursor: pointer;
        background: #fff !important;
    }

    .search {
        margin-right: 148px;
    }

    footer {
        margin-top: 100px;
    }


    .new_blog_btn{
        margin-right: 20px;
    }
    .top-nav{
        z-index: 10002;
    }


</style>
<body>

<#--导航栏-->
<div class="top-nav fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark container ">
        <a class="navbar-brand" href="/article/list">暖窝</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/article/list">Home </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">文章</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">相册</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">留言区</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">关于</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0 search">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Search</button>
            </form>
            <a href="/article/edit_page" type="button" class="btn btn-primary new_blog_btn">
                <span>新博客</span>
            </a>
            <div class="dropdown">
                <a href="javascript:;" data-toggle="dropdown">
                    <img class="rounded"
                         src="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=141991798,3480003694&fm=27&gp=0.jpg,"
                         alt="" width="50">
                </a>
                <span class="badge badge-info">7</span>

                <div class="dropdown-menu">
                    <a class="dropdown-item disabled" href="#">多年雨</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">用户中心</a>
                    <a class="dropdown-item" href="#">我的关注</a>
                    <a class="dropdown-item" href="#">退出登录</a>
                </div>
            </div>
        </div>
    </nav>
</div>
<div style="height: 66px;width: 100%;"></div>