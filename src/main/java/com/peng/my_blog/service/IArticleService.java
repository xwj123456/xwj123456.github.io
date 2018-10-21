package com.peng.my_blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.peng.my_blog.entity.Article;
import com.peng.my_blog.vo.DetailVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
public interface IArticleService extends IService<Article> {

    DetailVO getDetail(Integer articleId);


}
