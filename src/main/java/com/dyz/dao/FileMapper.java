package com.dyz.dao;

import com.dyz.entity.files;
import com.dyz.entity.filetype;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface FileMapper {
    //查找全部文档
    List<files> queryAllFile();

    //返回文档数目
    int fileCount();

    //查询所有文档类型
    List<filetype> queryAllFiletype();

    //增加文档
    int addfile(@Param("filename") String filename,
                @Param("filetype") String filetype,
                @Param("filesize") BigDecimal filesize,
                @Param("filedescribe") String filedescribe,
                @Param("filelocation") String filelocation,
                @Param("uploadtime") Date uploadtime,
                @Param("uploaduser") String uploaduser);

    //根据fileid查询files
    files queryFileByFileid (@Param("fileid") int fileid);

    //根据fileid修改downloadtimes+1
    int updateDownloadtimesByFileid(@Param("fileid") int fileid);

    //根据fileid删除files
    int deleteFileByFileid(@Param("fileid") int fileid);

    //根据filetype查询文档
    List<files> queryFileByFiletype(@Param("filetype") String filetype);

    //根据filetype返回文档数目
    int fileCountByFiletype(@Param("filetype") String filetype);

    //根据typeid查询filetype
    String queryFiletypeByTypeid(@Param("typeid") int typeid);

    //根据uploaduser查询文档
    List<files> queryFileByUploaduser(@Param("uploaduser") String uploaduser);

    //根据uploaduser返回文档数目
    int fileCountByUploaduser(@Param("uploaduser") String uploaduser);

    //根据typeid删除filetype
    int deleteFiletypeByTypeid(@Param("typeid") int typeid);

    //根据typeid查询全部Filelocation
    List<String> queryFilelocationByFiletype(@Param("filetype") String filetype);

    //修改文档类型
    int updateFiletypeByTypeid(filetype filetype);

    //添加文档类型
    int addFiletype(@Param("filetype")String filetype);
}
