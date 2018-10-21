package com.peng.my_blog.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.peng.my_blog.common.BaseResponse;
import com.peng.my_blog.entity.Comment;
import com.peng.my_blog.entity.CommentStar;
import com.peng.my_blog.vo.CommentVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
public interface ICommentService extends IService<Comment> {

    IPage<CommentVO> getComments(Integer page, Integer size, Integer articleId);


    BaseResponse doStar(CommentStar commentStar);
}
