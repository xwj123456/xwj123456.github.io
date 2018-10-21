package com.peng.my_blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Data
@ToString
public class CommentStar {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    @NotNull(message = "commentId不能为空")
    private Integer commentId;
    @NotNull(message = "commentType不能为空")
    private Integer commentType;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
