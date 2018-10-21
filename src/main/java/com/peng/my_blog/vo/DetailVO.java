package com.peng.my_blog.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.experimental.Accessors;

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
public class DetailVO {

    private Integer id;

    private String title;

    /*发布人*/
    private UserVO publisher;


    private String description;

    private String content;

    private String coverImg;

    private Integer lookNum;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;


}
