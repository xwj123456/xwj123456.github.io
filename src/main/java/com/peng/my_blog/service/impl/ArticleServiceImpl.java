package com.peng.my_blog.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.peng.my_blog.entity.Article;
import com.peng.my_blog.mapper.ArticleMapper;
import com.peng.my_blog.service.IArticleService;
import com.peng.my_blog.vo.DetailVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public DetailVO getDetail(Integer articleId) {
        DetailVO article = articleMapper.getArticleById(articleId);
        Article updateArticle = new Article();
        BeanUtils.copyProperties(article,updateArticle);
        updateArticle.setLookNum(updateArticle.getLookNum()+1);
        articleMapper.updateById(updateArticle);
        return article;
    }
}
