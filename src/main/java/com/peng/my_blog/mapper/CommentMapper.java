package com.peng.my_blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.peng.my_blog.entity.Comment;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
public interface CommentMapper extends BaseMapper<Comment> {
    IPage<Comment> getComments(Page page, @Param("articleId") Integer articleId);

}
