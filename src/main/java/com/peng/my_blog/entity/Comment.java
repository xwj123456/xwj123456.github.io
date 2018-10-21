package com.peng.my_blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 *
 * </p>
 *
 * @author peng
 * @since 2018-09-25
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@NotNull(message = "参数有误")
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(type = IdType.AUTO)
    private Integer id;

    @NotNull(message = "articleId不能为空!")
    private Integer articleId;

    private Integer userId;
    private String userFace;
    private String userNickname;


    @NotBlank(message = "评论内容不能为空")
    private String content;

    private Integer starNum;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;


}
