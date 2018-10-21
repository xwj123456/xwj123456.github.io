package com.peng.my_blog.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.peng.my_blog.entity.CommentStar;
import com.peng.my_blog.mapper.CommentStarMapper;
import com.peng.my_blog.service.ICommentStarService;
import org.springframework.stereotype.Service;

@Service
public class CommentStarServiceImpl extends ServiceImpl<CommentStarMapper, CommentStar> implements ICommentStarService {
}
