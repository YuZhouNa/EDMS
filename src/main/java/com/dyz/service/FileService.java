package com.dyz.service;

import com.dyz.entity.files;
import com.dyz.entity.filetype;
import org.apache.ibatis.annotations.Param;


import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface FileService {
    //查找全部文档
    List<files> queryAllFile();

    //文档数量
    int fileCount();

    //查询全部文档类型
    List<filetype> queryAllFiletype();

    //增加文档
    int addfile(String filename, String filetype, BigDecimal filesize, String filedescribe, String filelocation, Date uploadtime, String uploaduser);

    //下载次数增加1
    int updateDownloadtimesByFileid(int fileid);

    //根据fileid删除files
    int deleteFileByFileid(int fileid);

    //根据fileid查询filelocation
    String queryFilelocationByFileid(int fileid);

    //根据filetype查询文档
    List<files> queryFileByFiletype(String filetype);

    //根据filetype返回文档数目
    int fileCountByFiletype(String filetype);

    //根据typeid查询filetype
    String queryFiletypeByTypeid(int typeid);

    //根据filetype查询文档
    List<files> queryFileByUploaduser(String uploaduser);

    //根据uploaduser返回文档数目
    int fileCountByUploaduser(String uploaduser);

    //根据typeid删除filetype
    int deleteFiletypeByTypeid(int typeid);

    //根据typeid查询全部Filelocation
    List<String> queryFilelocationByTypeid(int typeid);

    //修改文档类型
    int updateFiletypeByTypeid(int typeid,String filetype);

    //添加文档类型
    int addFiletype(String filetype);
}
