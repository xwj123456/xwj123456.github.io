package com.peng.my_blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.peng.my_blog.common.BaseResponse;
import com.peng.my_blog.common.Const;
import com.peng.my_blog.entity.Comment;
import com.peng.my_blog.entity.CommentStar;
import com.peng.my_blog.entity.Reply;
import com.peng.my_blog.mapper.CommentMapper;
import com.peng.my_blog.mapper.ReplyMapper;
import com.peng.my_blog.service.ICommentService;
import com.peng.my_blog.service.ICommentStarService;
import com.peng.my_blog.service.IReplyService;
import com.peng.my_blog.vo.CommentVO;
import com.peng.my_blog.vo.ReplyVO;
import com.peng.my_blog.vo.UserVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {
    private static long floorNum;
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private ReplyMapper replyMapper;
    @Autowired
    private IReplyService replyService;
    @Autowired
    private ICommentStarService starService;


    public static List<CommentVO> assembleCommentVO(List<Comment> dataList) {
        List<CommentVO> commentVOList = new ArrayList<>();
        for (Comment item : dataList) {
            CommentVO commentVO = new CommentVO();
            BeanUtils.copyProperties(item, commentVO);
            UserVO fromUserVO = new UserVO();
            fromUserVO.setFaceImg(item.getUserFace());
            fromUserVO.setNickname(item.getUserNickname());
            fromUserVO.setId(item.getId());
            commentVO.setFromUser(fromUserVO);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            commentVO.setCreateTime(df.format(item.getCreateTime()));
            commentVO.setUpdateTime(df.format(item.getUpdateTime()));
            commentVOList.add(commentVO);
        }
        return commentVOList;
    }

    public static CommentVO assembleCommentVO(Comment comment) {


        CommentVO commentVO = new CommentVO();
        BeanUtils.copyProperties(comment, commentVO);
        UserVO fromUserVO = new UserVO();
        fromUserVO.setFaceImg(comment.getUserFace());
        fromUserVO.setNickname(comment.getUserNickname());
        fromUserVO.setId(comment.getId());
        commentVO.setFromUser(fromUserVO);
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        commentVO.setCreateTime(df.format(comment.getCreateTime()));
        commentVO.setUpdateTime(df.format(comment.getUpdateTime()));
        commentVO.setFloorNum(comment.getId());

        return commentVO;
    }

    public static void make(List<ReplyVO> replyList, ReplyVO reply) {

        for (ReplyVO item : replyList) {
            if (reply.getId().equals(item.getReplyId()) && item.getReplyType() == 1 && !reply.getId().equals(item.getId())) {
                if (reply.getChildren() == null) {
                    reply.setChildren(new ArrayList<>());
                }
                reply.getChildren().add(item);

                make(replyList, item);
            }
        }
    }

    public static List<ReplyVO> assembleReplyVO(List<Reply> replyList) {
        List<ReplyVO> list = new ArrayList<>();
        for (Reply item : replyList) {
            ReplyVO replyVO = new ReplyVO();
            BeanUtils.copyProperties(item, replyVO);
            UserVO fromUserVO = new UserVO();
            fromUserVO.setFaceImg(item.getFromFace());
            fromUserVO.setNickname(item.getFromNickname());
            fromUserVO.setId(item.getFromUid());
            replyVO.setFromUser(fromUserVO);
            UserVO toUserVO = new UserVO();
            toUserVO.setFaceImg(item.getToFace());
            toUserVO.setNickname(item.getToNickname());
            toUserVO.setId(item.getToUid());
            replyVO.setToUser(toUserVO);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            replyVO.setCreateTime(df.format(item.getCreateTime()));
            replyVO.setUpdateTime(df.format(item.getUpdateTime()));
            list.add(replyVO);
        }
        return list;

    }

    @Override
    public IPage<CommentVO> getComments(Integer currentPage, Integer size, Integer articleId) {
        IPage<Comment> comments = commentMapper.getComments(new Page<>(currentPage, size), articleId);
        List<Comment> dataList = comments.getRecords();
        floorNum = comments.getTotal();
        List<CommentVO> commentVOList = new ArrayList<>();
        for (Comment item : dataList) {
            List<ReplyVO> parentList = new ArrayList<>();
            QueryWrapper<Reply> wrapper = new QueryWrapper<>();
            wrapper.eq("comment_id", item.getId()).orderByDesc("create_time");
            List<Reply> replyList = replyMapper.selectList(wrapper);
            List<ReplyVO> replyVOList = assembleReplyVO(replyList);
            for (ReplyVO reply : replyVOList) {
                if (reply.getReplyType() == 0) {
                    make(replyVOList, reply);
                    parentList.add(reply);
                }
            }
            CommentVO commentVO = assembleCommentVO(item);
            commentVO.setChildren(parentList);
            commentVOList.add(commentVO);
        }

        Page<CommentVO> page = new Page<>(currentPage, size);
        BeanUtils.copyProperties(comments, page);
        page.setRecords(commentVOList);

        return page;

    }

    @Override
    public BaseResponse doStar(@Validated CommentStar commentStar) {
        //先获取点赞表是否有 有则删除并减少对应评论的点赞数
        QueryWrapper<CommentStar> queryWrapper = new QueryWrapper<CommentStar>();
        Integer userId = commentStar.getUserId();
        Integer commentId = commentStar.getCommentId();
        Integer commentType = commentStar.getCommentType();
        queryWrapper.eq("user_id", commentStar.getUserId());
        queryWrapper.eq("comment_id", commentStar.getCommentId());
        queryWrapper.eq("comment_type", commentStar.getCommentType());
        CommentStar one = starService.getOne(queryWrapper);
        if (one == null) {
            boolean saved = starService.save(commentStar);
            if (!saved) {
                return BaseResponse.error("点赞失败");
            }
            //判断是评论还是回复  0为评论 1为回复
            if (commentType == Const.CommentTypeConst.COMMENT_TYPE) {
                Comment comment = commentMapper.selectById(commentId);
                if (comment == null) {
                    return BaseResponse.error("无效评论id");
                }
                comment.setStarNum(comment.getStarNum() + 1);
                int updateCount = commentMapper.updateById(comment);
                if (updateCount > 0) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("starNum", comment.getStarNum());
                    return BaseResponse.success("点赞成功", map);
                }
                return BaseResponse.error("点赞失败");

            } else {
                Reply reply = replyService.getById(commentId);
                if (reply == null) {
                    return BaseResponse.error("无效回复id");
                }
                reply.setStarNum(reply.getStarNum() + 1);
                boolean updated = replyService.updateById(reply);
                if (updated) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("starNum", reply.getStarNum());
                    return BaseResponse.success("点赞成功", map);
                }
                return BaseResponse.error("点赞失败");

            }

        } else {
            boolean removed = starService.removeById(one.getId());
            if (!removed) {
                return BaseResponse.error("取消点赞失败");
            }
            if (commentType == Const.CommentTypeConst.COMMENT_TYPE) {
                Comment comment = commentMapper.selectById(commentId);
                if (comment == null) {
                    return BaseResponse.error("无效评论id");
                }
                comment.setStarNum(comment.getStarNum() - 1);
                int updateCount = commentMapper.updateById(comment);
                if (updateCount > 0) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("starNum", comment.getStarNum());
                    return BaseResponse.success("取消点赞成功", map);
                }
                return BaseResponse.error("取消点赞失败");

            } else {
                Reply reply = replyService.getById(commentId);
                if (reply == null) {
                    return BaseResponse.error("无效回复id");
                }
                reply.setStarNum(reply.getStarNum() - 1);
                boolean updated = replyService.updateById(reply);
                if (updated) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("starNum", reply.getStarNum());
                    return BaseResponse.success("取消点赞成功", map);
                }
                return BaseResponse.error("取消点赞失败");

            }

        }


    }


}
