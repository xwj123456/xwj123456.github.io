package com.peng.my_blog.vo;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class ReplyVO {
    private Integer id;

    private Integer replyId;
    private Integer replyType;
    private UserVO fromUser;
    private UserVO toUser;

    private String content;

    private List<ReplyVO> children;

    private Integer starNum;

    private String createTime;

    private String updateTime;
}
