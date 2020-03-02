package com.dyz.service;

import com.dyz.dao.FileMapper;
import com.dyz.entity.files;
import com.dyz.entity.filetype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {

    //Service 调用 Dao 层 file
    @Autowired
    @Qualifier("fileMapper")
    private FileMapper fileMapper;

    public List<files> queryAllFile() {
        List<files> list = fileMapper.queryAllFile();
        return list;
    }

    public int fileCount() {
        int count = fileMapper.fileCount();
        return count;
    }

    public List<filetype> queryAllFiletype() {

        return fileMapper.queryAllFiletype();
    }

    public int addfile(String filename, String filetype, BigDecimal filesize, String filedescribe, String filelocation, Date uploadtime, String uploaduser) {
        return fileMapper.addfile(filename,filetype,filesize,filedescribe,filelocation,uploadtime,uploaduser);
    }

    public int updateDownloadtimesByFileid(int fileid) {
        return fileMapper.updateDownloadtimesByFileid(fileid);
    }

    public int deleteFileByFileid(int fileid) {
        return fileMapper.deleteFileByFileid(fileid);
    }

    public String queryFilelocationByFileid(int fileid) {
        files files = fileMapper.queryFileByFileid(fileid);
        return files.getFilelocation();
    }

    public List<files> queryFileByFiletype(String filetype) {
        List<files> list = fileMapper.queryFileByFiletype(filetype);
        return list;
    }

    public int fileCountByFiletype(String filetype) {
        return fileMapper.fileCountByFiletype(filetype);
    }

    public String queryFiletypeByTypeid(int typeid){
        return fileMapper.queryFiletypeByTypeid(typeid);
    }

    public List<files> queryFileByUploaduser(String uploaduser) {
        return fileMapper.queryFileByUploaduser(uploaduser);
    }

    public int fileCountByUploaduser(String uploaduser) {
        return fileMapper.fileCountByUploaduser(uploaduser);
    }

    public int deleteFiletypeByTypeid(int typeid) {
        return fileMapper.deleteFiletypeByTypeid(typeid);
    }

    public List<String> queryFilelocationByTypeid(int typeid) {
        String type = fileMapper.queryFiletypeByTypeid(typeid);
        List<String> paths = fileMapper.queryFilelocationByFiletype(type);
        return paths;
    }

    public int updateFiletypeByTypeid(int typeid,String filetype) {
        return fileMapper.updateFiletypeByTypeid(new filetype(typeid,filetype));
    }

    public int addFiletype(String filetype) {
        return fileMapper.addFiletype(filetype);
    }


}
