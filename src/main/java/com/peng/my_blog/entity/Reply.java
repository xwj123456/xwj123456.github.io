package com.peng.my_blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDateTime;

@Data
@ToString
public class Reply {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer commentId;
    private Integer replyId;
    private Integer replyType;
    private String content;
    private Integer fromUid;
    private String fromFace;
    private String fromNickname;
    private Integer toUid;
    private String toFace;
    private String toNickname;
    private Integer starNum;
    private LocalDateTime createTime;

    private LocalDateTime updateTime;


}
