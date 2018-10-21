<#import "../common/layout.ftl" as myLayout />
<@myLayout.layout titleName="文章详情">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<link rel="stylesheet" type="text/css" href="/css/wangEditor-fullscreen-plugin.css">
<link rel="stylesheet" href="/css/bootstrap-table.min.css">
<link rel="stylesheet" href="/css/paging.css">
<script src="/js/paging.js"></script>
<div class="content container">
    <div class="page-header">
        <h1 class="text-center"><b>${article.title}</b></h1>
        <div class="text-right">
            <span class="text-left">发布人:${article.publisher.nickname}</span>
            <span class="text-left">阅览数:${article.lookNum}</span>
            <span class="text-left">发布时间:${formatter.format(article.createTime)}</span>
        </div>
    </div>
    <div class="article_before">
        <p>${article.description}</p>
    </div>
    <div class="article_image text-center my-5">
        <img src="/image/${article.coverImg}" alt="" class="img-responsive" style="width: 100%;">
    </div>
    <div class="article_content">
        ${article.content}
    </div>

    <div class="comment_section">
        <h4>评论区</h4>
        <div id="editor">
        </div>
        <div class="btn btn-primary" id="submit_btn">biu!</div>
        <h5 class="comment_title">评论列表</h5>
        <div class="comment_div">
            <ul class="list-unstyled comment_list">
            </ul>
        </div>
        <div id="pagger" class="pagger"></div>
    </div>

</div>
</@myLayout.layout>
<script type="text/javascript" src="/js/wangEditor.min.js"></script>
 <script type="text/javascript" src="/js/jquery.ui.widget.js"></script>
 <script type="text/javascript" src="/js/jquery.fileupload.js"></script>
 <script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
 <script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
 <script type="text/javascript" src="/js/wangEditor-fullscreen-plugin.js"></script>
<#--富文本-->
<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#editor');
    editor.customConfig.uploadImgServer = "/article/upload_img";  // 上传图片到服务器
    editor.customConfig.uploadFileName = 'myFileName';
    editor.customConfig.uploadImgHooks = {
        success: function (xhr, editor, result) {
        },
        customInsert: function (insertImg, result, editor) {
            // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

            // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
            result.data.forEach(function (e) {
                insertImg("/image/" + e);
            });

            // result 必须是一个 JSON 格式字符串！！！否则报错
        }
    };
    editor.create();
    let input = $("<input placeholder='说点什么吧'/ >").css({
        "position": "absolute",
        "left": 10,
        "top": 10,
        "border": 0,
    });
    $(".w-e-text").append(input);
    $("input").focus(function () {
        $(this).remove();
        $(".w-e-text").focus();
    });
    $(".w-e-text").click(function () {
        $("input").remove();
    });
    E.fullscreen.init('#editor');
    let isFull = false;
    $("._wangEditor_btn_fullscreen").click(function () {
        isFull = !isFull;
        $(".top-nav").css("z-index", isFull ? "0" : "10002");

    });

</script>

<script type="text/javascript">
    $(function () {
        let floorNum;
        getComments();

        //获取评论
        function getComments(currentPage, size) {
            $.get("/article/get_comments", {articleId: "${article.id}", page: currentPage, size: size}, function (res) {
                if (res.records.length == 0) {
                    return;
                }
                floorNum = 1;
                let content = make(res.records);
                $(".comment_list").html(content);
                //分页
                let isFirst = true;
                $('#pagger').paging({
                    initPageNo: res.current, // 初始页码
                    totalPages: res.pages, //总页数
                    totalCount: '共' + res.total + '条数据', // 条目总数
                    slideSpeed: 600, // 缓动速度。单位毫秒
                    jump: true, //是否支持跳转
                    callback: function (page) { // 回调函数
                        if (!isFirst) {
                            getComments(page, 5);
                        } else {
                            isFirst = false;
                        }
                        let textarea = $(`<div class="form-group reply_text my-5">

                                                  <textarea class="form-control" rows="5" id="comment"></textarea>
                                                  <button class="btn btn-primary my-3 reply_submit_btn" >提交</button>
                                                </div>`).hide();
                        $(".reply_text").remove();
                        $("body").append(textarea);


                    }
                });
            });
        }

        function make(result) {
            let content = "";
            if (result != undefined && result.length > 0) {
                result.forEach(function (e) {
                    let str = "";
                    let tofaceStr = "";
                    if (e.toUser !== undefined && e.toUser.id !== undefined && e.replyType === 1) {
                        str = `<a href='/user/info/${"$"}{e.toUser.id}'>@` + e.toUser.nickname + "</a>";

                    }
                    if (e.toUser !== undefined) {
                        tofaceStr = `to_face="${'$'}{e.fromUser.faceImg}" to_nickname="${'$'}{e.fromUser.nickname}" to_id="${'$'}{e.fromUser.id}"`;
                    }
                    let floorStr = "";
                    let commentIdStr = "";
                    let commentTypeStr = "comment_type=1";
                    if (e.floorNum != undefined) {
                        floorStr = `·<b class="text-left">${'$'}{e.floorNum}楼</b>`;
                        commentIdStr = `comment_id="${'$'}{e.id}"`;
                        commentTypeStr = `comment_type=0`;
                    }
                    content += `<div class="media" ${'$'}{commentIdStr}> <img class="mr-3 face" src="http://pic34.photophoto.cn/20150105/0005018358919011_b.jpg" alt="Generic placeholder image">
                    <div class="media-body">
                        <h5 class="mt-0 mb-1">${'$'}{e.fromUser.nickname}</h5>
                        <p>${'$'}{str}   ${'$'}{e.content}</p>
                        <p class="text-right"><span class="text-left"><span class="fa fa-star" ${'$'}{commentTypeStr}></span><span class="star_num">${'$'}{e.starNum}</span></span>  发布时间:<span class="text-left">${'$'}{e.createTime}</span>${'$'}{floorStr}</p>
                        <p class="text-right"><button class="btn btn-primary reply_btn" reply_type="${'$'}{e.replyType}" reply_id="${'$'}{e.id}"  ${'$'}{tofaceStr}>回复</button></p>
                    `;
                    content += make(e.children);
                    content += `</div></div>`;
                });
            }


            return content;

        }

        //提交主题
        $("#submit_btn").click(function () {
            let content = editor.txt;
            if (content.text().length == 0) {
                alert("啥都不说就想骗我发射？");
                return;
            }
            let data = {
                articleId: "${article.id}",
                content: content.html()
            };
            //todo 还需要验证用户登录状态，如果未登录，提示登录
            $.post("/article/publish_comment", data, function (res) {
                if (res.code === 200) {
                    alert(res.msg);
                    //重新获取评论
                    getComments();
                    editor.txt.clear();
                    return;
                }
                alert(res.msg);

            });

        });

        //回复评论(打开评论文本框,预存储数据）
        $(".comment_list").on("click", ".reply_btn", function () {
            let reply_type = $(this).attr("reply_type");
            let reply_id = $(this).attr("reply_id");
            let comment_id = null;
            let to_user_id;
            let to_nickname;
            let to_face;

            $(this).parents(".media").each(function () {
                if ($(this).attr("comment_id") != undefined) {
                    comment_id = $(this).attr("comment_id");
                    return;
                }
            });

            if (reply_type == "undefined") {//说明回复主题
                reply_type = 0;
                console.log("回复主题");
            } else { //回复回复
                reply_type = 1;
                to_user_id = $(this).attr("to_id");
                to_nickname = $(this).attr("to_nickname");
                to_face = $(this).attr("to_face");
                console.log("回复回复");
                console.log("to_user_id:" + to_user_id + "," + "to_nickname:" + to_nickname + ",to_face:" + to_face);
            }
            let data = {
                replyType: reply_type,
                replyId: reply_id,
                commentId: comment_id,
                toUid: to_user_id,
                toFace: to_face,
                toNickname: to_nickname
            };
            localStorage.setItem("data", JSON.stringify(data));
            $(".reply_text").show();
            $(this).parent().append($(".reply_text"));

        });

        //提交评论到后台
        $(".comment_list").on("click", ".reply_submit_btn", function () {
            let content = $(this).siblings("textarea").val();
            let data = JSON.parse(localStorage.getItem("data"));
            data.content = content;
            $.post("/article/publish_comment_reply", data, function (res) {
                if (res.code === 200) {
                    alert(res.msg);
                    //重新获取评论
                    getComments();
                    editor.txt.clear();
                    return;
                }
                alert(res.msg);
            })
        });

        //点赞功能

        $(".comment_list").on("click", ".fa-star", function () {
            let comment_type = $(this).attr("comment_type");
            let comment_id = $(this).parent().parent().siblings(".text-right").find("button").attr("reply_id");
            console.log("comment_type=" + comment_type);
            console.log("comment_id=" + comment_id);
            let self = $(this);
            $.post("/article/do_star", {commentType: comment_type, commentId: comment_id}, function (res) {
                self.siblings(".star_num").text(res.data.starNum);
            });
        });




    });
</script>


