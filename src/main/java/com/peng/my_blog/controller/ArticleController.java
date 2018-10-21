package com.peng.my_blog.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.peng.my_blog.common.BaseResponse;
import com.peng.my_blog.common.Const;
import com.peng.my_blog.entity.*;
import com.peng.my_blog.enums.ResponseEnum;
import com.peng.my_blog.exception.MyBlogException;
import com.peng.my_blog.service.IArticleService;
import com.peng.my_blog.service.ICommentService;
import com.peng.my_blog.service.IReplyService;
import com.peng.my_blog.service.IUploadService;
import com.peng.my_blog.vo.CommentVO;
import com.peng.my_blog.vo.DetailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
@Controller
@RequestMapping("/article")
public class ArticleController {

    @Autowired
    private IArticleService articleService;

    @Autowired
    private IUploadService uploadService;

    @Autowired
    private ICommentService commentService;

    @Autowired
    private IReplyService replyService;


    /**
     * 列表页
     * @param model
     * @return
     */
    @GetMapping("/list")
    public String list(Model model,@RequestParam(value = "page",defaultValue = "1",required = false)Integer page,
                       @RequestParam(value = "size",defaultValue = "5",required = false)Integer size) {
        QueryWrapper<Article> queryWrapper = new QueryWrapper();
        queryWrapper.orderByDesc("create_time");
        IPage<Article> thePage = articleService.page(new Page<>(page,size),queryWrapper);
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        System.out.println(thePage.getPages());
        model.addAttribute("list", thePage.getRecords());
        model.addAttribute("currentPage", thePage.getCurrent());
        model.addAttribute("pageAllCount", thePage.getPages());
        long prePage = thePage.getCurrent()-1>0?thePage.getCurrent()-1:1;
        long nextPage = thePage.getCurrent()+1>thePage.getPages()?thePage.getPages():thePage.getCurrent()+1;
        model.addAttribute("prePage",prePage);
        model.addAttribute("nextPage",nextPage);
        model.addAttribute("pageSize", size);
        model.addAttribute("formatter", df);
        return "article/list";
    }

    /**
     * 编辑文章页
     * @param model
     * @param id
     * @return
     * @throws Exception
     */
    @GetMapping({"/edit_page/{id}","/edit_page"})
    public String editPage(Model model,@PathVariable(value = "id",required = false) String id){

        if (StringUtils.isNotEmpty(id)) {
            //更新页面
            Article article = articleService.getById(id);
            if(article==null){
                throw new MyBlogException("无效文章id");
            }
            model.addAttribute("article",article);
        }
        return "article/edit_page";

    }

    /**
     * <p>添加/修改文章</p>
     *
     * @param article 参数实体
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public BaseResponse edit(@Validated  Article article, BindingResult result, HttpServletRequest request) {
        System.out.println(article);
        if(result.hasErrors()){
            return BaseResponse.error(result.getFieldError().getDefaultMessage());
        }
        HttpSession session = request.getSession();
        //todo 将来完成登录注册将会把此模拟部分 theUser删除
        User theUser = new User();
        theUser.setId(666);
        session.setAttribute("user",theUser);
        //模拟结束

        User user = (User)session.getAttribute("user");
        if(user==null){
            return BaseResponse.error("需要登录",BaseResponse.CODE_NO_LOGIN);
        }
        article.setPublisherId(user.getId());

        boolean isSuccess = articleService.saveOrUpdate(article);
        if(isSuccess){
            return BaseResponse.success();
        }
        return BaseResponse.error("添加失败");

    }

    /**
     * 文章详情页
     * @param articleId
     * @return
     * @throws Exception
     */
    @GetMapping("/detail/{article_id}")
    public String detail(Model model,@PathVariable("article_id") Integer articleId) {
        if(articleId==null){
            throw new MyBlogException("无效详情页");
        }

        DetailVO article = articleService.getDetail(articleId);
        if(article==null){
            throw new MyBlogException("该文章没有详情页");
        }
        model.addAttribute("article",article);
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        model.addAttribute("formatter", df);
        return "article/detail";

    }


    /**
     * 上传图片
     * @param files
     * @return
     */
    @PostMapping("/upload_img")
    @ResponseBody
    public Map<String,Object> uploadImg(@RequestParam("myFileName") MultipartFile[] files){
        Map<String,Object> map = new HashMap<>();
        List<String> img_urls = new ArrayList<>();
        for (MultipartFile file: files) {
            String imgUrl = uploadService.upload(file,"E:/upload/");
            img_urls.add(imgUrl);
        }
        map.put("errno",0);
        map.put("data",img_urls);
        return map;



    }


    /**
     * 获取一篇文章中的评论
     * @param articleId
     * @return
     * @throws ParseException
     */
    @GetMapping("/get_comments")
    @ResponseBody
    public IPage getComments(@RequestParam("articleId") Integer articleId,
                             @RequestParam(value = "page",defaultValue = "1",required = false)Integer page,
                             @RequestParam(value = "size",defaultValue = "5",required = false)Integer size) throws ParseException {
        IPage<CommentVO> iPage = commentService.getComments(page, size, articleId);
        return iPage;
    }

    /**
     * 发布主题
     *
     * @param comment
     * @param result
     * @param request
     * @return
     */
    @PostMapping("publish_comment")
    @ResponseBody
    public BaseResponse publishComment(@Validated Comment comment, BindingResult result,
                                       HttpServletRequest request) {
        if (result.hasErrors()) {
            return BaseResponse.error(result.getFieldError().getDefaultMessage());
        }


        //todo 模拟从已登录用户拿取账户信息
        HttpSession session = request.getSession();
        User user = new User();
        user.setId(666);
        user.setFaceImg("图片1");
        user.setNickname("游客1");
        session.setAttribute(Const.USER_INFO,user);
        User theUser = (User)session.getAttribute(Const.USER_INFO);
        if(theUser==null){
            return BaseResponse.error(ResponseEnum.NEED_LOGIN.getDesc());
        }
        comment.setUserId(theUser.getId());
        comment.setUserNickname(theUser.getNickname());
        comment.setUserFace(theUser.getFaceImg());


        boolean saved = commentService.save(comment);
        if(saved) {
            return BaseResponse.success("发布主题成功");
        }
        return BaseResponse.error("发布主题失败");
    }

    @PostMapping("publish_comment_reply")
    @ResponseBody
    public BaseResponse publishCommentReply(@Validated Reply reply, BindingResult result,
                                            HttpServletRequest request) {
        if (result.hasErrors()) {
            return BaseResponse.error(result.getFieldError().getDefaultMessage());
        }

        //todo 模拟从已登录用户拿取账户信息
        HttpSession session = request.getSession();
        User user = new User();
        user.setId(666);
        user.setFaceImg("图片1");
        user.setNickname("游客1");
        session.setAttribute(Const.USER_INFO, user);
        User theUser = (User) session.getAttribute(Const.USER_INFO);
        if (theUser == null) {
            return BaseResponse.error(ResponseEnum.NEED_LOGIN.getDesc());
        }
        reply.setFromUid(user.getId());
        reply.setFromFace(user.getFaceImg());
        reply.setFromNickname(user.getNickname());
        boolean saved = replyService.save(reply);
        if (saved) {
            return BaseResponse.success("回复成功");
        }
        return BaseResponse.error("回复失败");

    }

    //评论点赞
    @PostMapping("/do_star")
    @ResponseBody
    public BaseResponse doStar(CommentStar commentStar, BindingResult result,
                               HttpServletRequest request) {
        if (result.hasErrors()) {
            return BaseResponse.error(result.getFieldError().getDefaultMessage());
        }
        //todo 模拟从已登录用户拿取账户信息
        HttpSession session = request.getSession();
        User user = new User();
        user.setId(666);
        user.setFaceImg("图片1");
        user.setNickname("游客1");
        session.setAttribute(Const.USER_INFO, user);
        User theUser = (User) session.getAttribute(Const.USER_INFO);
        if (theUser == null) {
            return BaseResponse.error(ResponseEnum.NEED_LOGIN.getDesc());
        }
        commentStar.setUserId(theUser.getId());
        return commentService.doStar(commentStar);


    }
}
