package com.dyz.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dyz.entity.files;
import com.dyz.entity.filetype;
import com.dyz.service.FileService;
import com.dyz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/file")
public class FileController {
    //controller 调 service
    @Autowired
    @Qualifier("fileServiceImpl")
    private FileService fileService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;


    //显示 allfile.jsp
    @RequestMapping("/toAllFile")
    public String toAllFile() {
        return "allfile";
    }

    //显示 allfiletype.jsp
    @RequestMapping("/toAllFiletype")
    public String toAllFiletype() {
        return "allfiletype";
    }

    //显示 addfile.jsp
    @RequestMapping("/toAddFile")
    public String toAddFile() {
        return "addfile";
    }

    //显示 myindex.jsp
    @RequestMapping("/toMyIndex")
    public String toMyIndex() {
        return "myindex";
    }

    //显示 typefile.jsp
    @RequestMapping("/toTypefile/{typeid}")
    public String toTypefile(@PathVariable int typeid, Model model) {
        String filetype = fileService.queryFiletypeByTypeid(typeid);
        model.addAttribute("filetype", filetype);
        return "typefile";
    }

    //显示 myfile.jsp
    @RequestMapping("/toMyFile")
    public String toMyFile() {
        return "myfile";
    }

    //显示updatefiletype.jsp
    @RequestMapping("/toUpdatefiletype/{typeid}")
    public String toUpdatefiletype (@PathVariable int typeid,Model model){
        model.addAttribute("typeid", typeid);
        return "updatefiletype";
    }

    //显示addfiletype.jsp
    @RequestMapping("/toAddfiletype")
    public String toAddfiletype (){
        return "addfiletype";
    }


    //查询全部文档
    @RequestMapping("/queryAllFile")
    @ResponseBody
    public Map<String, Object> queryAllFile() {
        List<files> files = fileService.queryAllFile();
        int count = fileService.fileCount();

        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray filearray = JSONArray.parseArray(JSON.toJSONString(files));

        map.put("msg", "");
        map.put("code", 0);
        map.put("count", count);
        map.put("data", filearray);
        return map;
    }

    //查询全部文档类型
    @RequestMapping("/queryAllFiletype")
    @ResponseBody
    public Map<String, Object> queryAllFiletype() {
        List<filetype> files = fileService.queryAllFiletype();


        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray filearray = JSONArray.parseArray(JSON.toJSONString(files));

        map.put("msg", "");
        map.put("code", 0);
        map.put("count", 0);
        map.put("data", filearray);
        return map;
    }

    //查询所有 文档类型List
    @RequestMapping(value = "/queryAllFiletypeList")
    @ResponseBody
    public List<filetype> queryAllFiletypeList() {
        List<filetype> filetypes = fileService.queryAllFiletype();
        return filetypes;
    }

    //文件上传
    @RequestMapping(value = "/addFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addFile(HttpServletRequest servletRequest, @RequestParam("file") MultipartFile file,
                                       String uploaduser, Date uploadtime, String filedescribe, String uploadusername, String filetype) throws IOException {

        Map<String, Object> res = new HashMap<String, Object>();
        //判断文件是否存在，如果存在则不允许上传
        if (filetype.equals("")) {
            res.put("msg", "TYPEERROR");
            return res;
        }


        //step:  封装方法
        //上传路径保存设置   /upload/username
        String path = servletRequest.getServletContext().getRealPath("/upload/" + uploadusername);
        //上传文件名
        String filename = file.getOriginalFilename();
        File filepath = new File(path, filename);


        //判断文件是否存在，如果存在则不允许上传
        if (filepath.exists()) {
            res.put("msg", "EXIST");
            return res;
        }

        //判断路径是否存在，没有就创建一个
        if (!filepath.getParentFile().exists()) {
            filepath.getParentFile().mkdirs();
        }

        //将上传文件保存到一个目标文档中
        File filetarget = new File(path + File.separator + filename);
        file.transferTo(filetarget);


        Float size = Float.parseFloat(String.valueOf(file.getSize())) / (float) 1024; // 单位kb


        int addfile = fileService.addfile(filename, filetype, new BigDecimal(size), filedescribe, path + File.separator + filename, uploadtime, uploaduser);
        if (addfile > 0) {
            //测试
            System.out.println("addfile - nice");
        }

        //返回的是一个map对象
        res.put("msg", "SUCCESS");
        return res;

    }

    //文件下载
    @RequestMapping(value = "/download/{filename}/{uploaduser}/{fileid}")
    public String download(@PathVariable String filename, @PathVariable String uploaduser, @PathVariable int fileid,
                           HttpServletRequest request, HttpServletResponse response) throws IOException {

        //获得上传者的username
        String uploaduserid = userService.queryUserNameByName(uploaduser);
        String filelocation = request.getServletContext().getRealPath("/upload/" + uploaduserid);


        response.reset(); //设置页面不缓存,清空buffer
        response.setCharacterEncoding("UTF-8"); //字符编码
        response.setContentType("multipart/form-data"); //二进制传输数据
        //设置响应头
        response.setHeader("Content-Disposition",
                "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));

        File file = new File(filelocation, filename);
        //2、 读取文件--输入流
        InputStream input = new FileInputStream(file);
        //3、 写出文件--输出流
        OutputStream out = response.getOutputStream();

        byte[] buff = new byte[1024];
        int index = 0;
        //4、执行 写出操作
        while ((index = input.read(buff)) != -1) {
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();

        int i = fileService.updateDownloadtimesByFileid(fileid);
        if (i != 0) {
            System.out.println("下载次数+1");
        }

        return null;
    }

    //    文档删除
    @RequestMapping("/deletefile")
    @ResponseBody
    public String deletefile(int fileid) {
        String res = "";
        String path = fileService.queryFilelocationByFileid(fileid);
        File file = new File(path);
        if (file.delete()) {
            if (fileService.deleteFileByFileid(fileid) > 0) {
                res = "success";
            } else {
                res = "error1";
            }

        } else {
            res = "error2";
        }
        return res;
    }


    //根据类型查询全部文档
    @RequestMapping("/queryFileByType")
    @ResponseBody
    public Map<String, Object> queryFileByType(String filetype) {
        List<files> files = fileService.queryFileByFiletype(filetype);
        int count = fileService.fileCountByFiletype(filetype);

        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray filearray = JSONArray.parseArray(JSON.toJSONString(files));

        map.put("msg", "");
        map.put("code", 0);
        map.put("count", count);
        map.put("data", filearray);
        return map;
    }

    //根据uploaduser查询文档
    @RequestMapping("/queryFileByUploaduser")
    @ResponseBody
    public Map<String, Object> queryFileByUploaduser(String uploaduser) {
        List<files> files = fileService.queryFileByUploaduser(uploaduser);
        int count = fileService.fileCountByUploaduser(uploaduser);

        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray filearray = JSONArray.parseArray(JSON.toJSONString(files));

        map.put("msg", "");
        map.put("code", 0);
        map.put("count", count);
        map.put("data", filearray);
        return map;
    }


    //文档类型删除 同时删除全部文档
    @RequestMapping("/deletefiletype")
    @ResponseBody
    public String deletefiletype(int typeid) {
        String res = "";
            List<String> paths = fileService.queryFilelocationByTypeid(typeid);
            if(paths.size()>0) {
                for (String path : paths) {
                    new File(path).delete();
                }
            }
        if (fileService.deleteFiletypeByTypeid(typeid) > 0) {
            res = "success";
        } else {
            res = "error";
        }
        return res;
    }

    //修改文档类型
    @RequestMapping("/updateFiletype")
    @ResponseBody
    public String updateFiletype (@RequestParam("typeid") String typeid, @RequestParam("filetype") String filetype){
        int id =Integer.parseInt(typeid);
        String res = "";
        int result = fileService.updateFiletypeByTypeid(id, filetype);
        if(result >0){
            res="SUCCESS";
        }
        return res;
    }

    //添加文档类型
    @RequestMapping("/addFiletype")
    @ResponseBody
    public String addFiletype (@RequestParam("filetype") String filetype){
        String res = "";
        int result = fileService.addFiletype(filetype);
        if(result >0){
            res="SUCCESS";
        }
        return res;
    }
}