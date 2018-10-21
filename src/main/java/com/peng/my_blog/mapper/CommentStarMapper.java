package com.peng.my_blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.peng.my_blog.entity.CommentStar;
import com.peng.my_blog.vo.DetailVO;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
public interface CommentStarMapper extends BaseMapper<CommentStar> {
    DetailVO getArticleById(Integer articleId);

}
