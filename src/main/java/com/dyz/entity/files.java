package com.dyz.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class files {
    private int fileid;             //id
    private String filename;        //文档名称
    private String filetype;        //文档类型
    private BigDecimal filesize;    //文档大小
    private String filedescribe;    //文档描述
    private String filelocation;    //保存路径
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date uploadtime;        //上传时间
    private String uploaduser;      //上传人
    private int downloadtimes;      //下载次数
}
