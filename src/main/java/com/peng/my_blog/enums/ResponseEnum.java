package com.peng.my_blog.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ResponseEnum {
    NEED_LOGIN(1,"需要登录");

    private final int code;
    private final String desc;


}
