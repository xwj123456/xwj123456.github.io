package com.peng.my_blog.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ErrorController {
    @ExceptionHandler
    public String handleError(Model model, Throwable e) {
        e.printStackTrace();
        model.addAttribute("msg",e.getMessage());
        model.addAttribute("e", e);
        return "common/error";
    }
}
