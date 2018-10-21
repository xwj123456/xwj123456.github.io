package com.peng.my_blog.service.impl;

import com.peng.my_blog.service.IUploadService;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
@Service
public class UploadServiceImpl implements IUploadService {

    public String upload(@RequestParam("file") MultipartFile file,String filePath){

        // 文件名
        String fileName = file.getOriginalFilename();
//        System.out.println("文件名： " + fileName);

        // 文件后缀
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
//        System.out.println("文件后缀名： " + suffixName);

        // 重新生成唯一文件名，用于存储数据库
        String newFileName = UUID.randomUUID().toString()+suffixName;
//        System.out.println("新的文件名： " + newFileName);

        //创建文件
        File dest = new File(filePath + newFileName);
        dest.setWritable(true);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }


        try {
            file.transferTo(dest);
            return newFileName;
        } catch (IOException e) {
            e.printStackTrace();
            return "上传错误";
        }


    }

}
