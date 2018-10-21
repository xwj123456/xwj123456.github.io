package com.peng.my_blog.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@Data
@ToString
@EqualsAndHashCode
public class CommentVO implements Serializable {
    private Integer id;

    private Integer articleId;

    private UserVO fromUser;

    private String content;

    private List<ReplyVO> children;

    private Integer starNum;
    private long floorNum;

    private String createTime;

    private String updateTime;
}
