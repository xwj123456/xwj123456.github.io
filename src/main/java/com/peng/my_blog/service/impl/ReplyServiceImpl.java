package com.peng.my_blog.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.peng.my_blog.entity.Reply;
import com.peng.my_blog.mapper.ReplyMapper;
import com.peng.my_blog.service.IReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
@Service
public class ReplyServiceImpl extends ServiceImpl<ReplyMapper, Reply> implements IReplyService {
    @Autowired
    private ReplyMapper replyMapper;


}
