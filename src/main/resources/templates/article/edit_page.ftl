<#import "../common/layout.ftl" as myLayout />
<link rel="stylesheet" type="text/css" href="/css/jquery.fileupload.css">
<link rel="stylesheet" type="text/css" href="/css/edit_page.css">
<link rel="stylesheet" type="text/css" href="/css/wangEditor-fullscreen-plugin.css">

<@myLayout.layout titleName="${(article??)?string('编辑文章','新增文章')}">

<div class="container content">
    <h3 class="text-center" style="margin-bottom: 30px;"><#if article??>编辑文章<#else>新增文章</#if></h3>
    <form>
        <input type="hidden" id="article_id" value="${(article.id)!''}">
        <div class="form-group row">
            <label for="title" class="col-sm-2 col-form-label">文章标题:</label>
            <div class="col-sm-10">
                <input type="title" class="form-control" id="title" value="${(article.title)!''}">
            </div>
        </div>
        <div class="form-group row">
            <label for="desc" class="col-sm-2 col-form-label">文章简介:</label>
            <div class="col-sm-10">
                <input type="desc" class="form-control" id="desc" value="${(article.description)!''}">
            </div>
        </div>
        <div class="form-group row">
            <label for="cover_img" class="col-sm-2 col-form-label">文章配图:</label>
            <div class="col-sm-2">
                <span class="btn btn-success fileinput-button">
        <i class="glyphicon glyphicon-plus"></i>
        <span>上传封面</span>
        <input id="fileupload" type="file" name="myFileName" multiple>
                    <input type="hidden" id="upload_img_url" value="${(article.coverImg)!''}">
    </span>
            </div>
            <div class="col-sm-8 upload_img_thumbnail">
            </div>
        </div>
        <div class="form-group">
            <label for="cover_img" class="col-form-label">文章内容:</label>
            <div id="editor"></div>
        </div>
        <button type="button" class="btn btn-primary submit_btn">提交</button>
    </form>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog big_img"></div>
</div>
</@myLayout.layout>
 <script type="text/javascript" src="/js/wangEditor.min.js"></script>
 <script type="text/javascript" src="/js/jquery.ui.widget.js"></script>
 <script type="text/javascript" src="/js/jquery.fileupload.js"></script>
 <script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
 <script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
 <script type="text/javascript" src="/js/wangEditor-fullscreen-plugin.js"></script>

<script src="//cdn.bootcss.com/blueimp-load-image/2.12.2/load-image.all.min.js"></script>
<script src="//cdn.bootcss.com/blueimp-file-upload/9.17.0/js/jquery.fileupload-process.min.js"></script>
<script src="//cdn.bootcss.com/blueimp-file-upload/9.17.0/js/jquery.fileupload-image.min.js"></script>
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
    //如果是更新，将之前的富文本填充上
    editor.txt.html(`${(article.content)!''}`);
    E.fullscreen.init('#editor');
    let isFull = false;
    $("._wangEditor_btn_fullscreen").click(function () {
        isFull = !isFull;
       $(".top-nav").css("z-index",isFull?"0":"10002");

    });

</script>
<#--上传图片-->
<script type="text/javascript">
    $(function () {
        $('#fileupload').fileupload({
            url: '/article/upload_img',//请求发送的目标地址
            Type: 'POST',//请求方式 ，可以选择POST，PUT或者PATCH,默认POST
            acceptFileTypes: /(gif|jpe?g|png)$/i,//验证图片格式
            maxNumberOfFiles: 1,//最大上传文件数目
            maxFileSize: 1000000, // 文件上限1MB
            minFileSize: 100,//文件下限  100b
            messages: {//文件错误信息
                acceptFileTypes: '文件类型不匹配',
                maxFileSize: '文件过大',
                minFileSize: '文件过小'
            },
            done: function (e, data) {
                insertImg("/image/" + data.result.data[0]);
                $("#upload_img_url").val(data.result.data[0]);
            }
        });
        //如果是有id，则将图片在加载时就进行展示
        if ($("#article_id").val().length > 0) {
            insertImg("/image/" +$("#upload_img_url").val());
        }

        function insertImg(src) {
            let img = $("<img />").attr({
                "src": src,
                "data-toggle": "modal",
                "data-target": "#myModal",
                "width": 200,
                "height": 200
            }).addClass("img-thumbnail");
            $(".upload_img_thumbnail").html(img);
        }
    });

</script>

<script type="text/javascript">
    $(function () {
        // 点击图片放大
        $(".upload_img_thumbnail").on("click", "img", function () {
            let img = $("<img/>").prop("src", $(this).prop("src"));
            $(".big_img").html(img);

        });
        //提交
        $(".submit_btn").click(function () {
            let title = $("#title").val();
            let desc = $('#desc').val();
            let cover_img_url = $("#upload_img_url").val();
            let content = editor.txt.html();
            if (title.length == 0 || desc.length == 0 || cover_img_url.length == 0 || editor.txt.text().length == 0) {
                alert("任何一项都不能为空！");
                return;
            }
            let url = "/article/edit";
            $.post(url, {
                "id": $("#article_id").val(),
                "title": title,
                "description": desc,
                "coverImg": cover_img_url,
                "content":content
            }, function (res) {
                console.log(res);
                if(res.code===200){
                    alert("操作成功！");
                    location.href="/article/list";
                }

            })
        });

    });
</script>
