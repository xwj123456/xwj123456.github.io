<#import "../common/layout.ftl" as myLayout />
<@myLayout.layout titleName="首页">
<style>
    /* Make the image fully responsive */
    .carousel-inner img {
        width: 100%;
    }
    .lunbo{
        margin-top: 30px;
    }
    .one_box{
        box-shadow: 0 0 7px rgba(33,33,33,.12), 0 3px 5px rgba(33,33,33,.12);
    }
    }
</style>
<link rel="stylesheet" href="/css/paging.css">
<script src="/js/paging.js"></script>
<section class="container lunbo">
    <div id="demo" class="carousel slide" data-ride="carousel">
        <!-- 指示符 -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
        </ul>
        <!-- 轮播图片 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://static.runoob.com/images/mix/img_fjords_wide.jpg">
            </div>
            <div class="carousel-item">
                <img src="https://static.runoob.com/images/mix/img_nature_wide.jpg">
            </div>
            <div class="carousel-item">
                <img src="https://static.runoob.com/images/mix/img_mountains_wide.jpg">
            </div>
        </div>
        <!-- 左右切换按钮 -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>

    </div>
</section>
<#--${}-->
<div class="container content">
        <#list list as item>
            <div class="media border p-3 position-relative one_box" data-article_id="${item.id}">
                <div class="media-body">
                    <h4>${item.title}</h4>
                    <p>${item.description}</p>
                    <span>发布日期：${formatter.format(item.createTime)}</span>
                </div>
                <div class="ml-3 mt-3 "style="width: 160px;">
                    <img src="/image/${item.coverImg}" alt="蜜汁碎图" class="img-thumbnail" >
                </div>
                <a href="/article/edit_page/${item.id}"class="btn btn-secondary position-absolute btn-sm" style="right: 0;bottom: 0">编辑</a>
            </div>
        </#list>


            <#--<ul class="pagination center-block" id >-->
                <#--<li class="page-item"><a class="page-link" href="/article/list?page=1&size=${pageSize}">首页</a></li>-->
                <#--<li class="page-item ${(1==currentPage)?string('disabled','')}"><a class="page-link" href="/article/list?page=${prePage}&size=${pageSize}">上一页</a></li>-->

                <#--&lt;#&ndash;<#assign pageSize=${pageSize.}/>&ndash;&gt;-->
                <#--<#list 1..pageAllCount as num>-->
                <#--<li class="page-item ${(num==currentPage)?string('active','')}"><a class="page-link " href="/article/list?page=${num}&size=${pageSize}">${num}</a></li>-->
                <#--</#list>-->
                <#--<li class="page-item"><a class="page-link" href="/article/list?page=${nextPage}&size=${pageSize}">下一页</a></li>-->
                <#--<li class="page-item"><a class="page-link" href="/article/list?page=${pageAllCount}&size=${pageSize}">尾页</a></li>-->
            <#--</ul>-->

    <div id="pagger" class="pagger"></div>

</div>
</@myLayout.layout>

<script>

    $(function () {
        $(".one_box").click(function () {
           location.href="/article/detail/"+$(this).attr("data-article_id");
        });
        let isFirst = true;
        $('#pagger').paging({
            initPageNo: ${currentPage}, // 初始页码
            totalPages: ${pageAllCount}, //总页数
            totalCount: '共${pageAllCount}条数据', // 条目总数
            slideSpeed: 600, // 缓动速度。单位毫秒
            jump: true, //是否支持跳转
            callback: function(page) { // 回调函数
                if(!isFirst){
                location.href="/article/list?page="+page+"&size=${pageSize}";
                }
                isFirst=false;
            }
        });


    });
</script>


