package com.peng.my_blog.service;

import org.springframework.web.multipart.MultipartFile;

public interface IUploadService {
    public String upload(MultipartFile file,String filePath);
}
