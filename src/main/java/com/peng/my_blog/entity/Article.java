package com.peng.my_blog.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
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
@ToString
public class Article {

    @TableId(type = IdType.AUTO)
    private Integer id;
    @NotBlank(message = "标题不能为空")
    private String title;

    private Integer publisherId;

    @NotBlank(message = "描述不能为空")
    private String description;
    @NotBlank(message = "内容不能为空")
    private String content;
    @NotBlank(message = "封面路径不能为空")
    private String coverImg;

    private Integer lookNum;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;


}
