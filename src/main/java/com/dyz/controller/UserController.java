package com.dyz.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dyz.entity.files;
import com.dyz.entity.filetype;
import com.dyz.entity.users;
import com.dyz.service.FileService;
import com.dyz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    //controller 调 service
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("fileServiceImpl")
    private FileService fileService;

    @RequestMapping("/toIndex")
    public String toIndex (Model model) {
        List<filetype> list = fileService.queryAllFiletype();
        model.addAttribute("list",list);
        return "index";
    }


    @RequestMapping("/checkUser")
    @ResponseBody
    public String checkUser (HttpSession session,@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("isadmin") String isadmin){
        int Isadmin = Integer.parseInt(isadmin);

        String checkUser = userService.checkUser(username, password,Isadmin);
        if(checkUser.equals("PASSWORD_ERROR")){ //密码错误
            return "passwordError";
        }else if(checkUser.equals("USERNAME_ERROR")){  //用户不存在
            return "userNotFound";
        }else{
            users users = userService.queryUserByUsername(username, Isadmin);

            session.setAttribute("USER_SESSION",users);
            return "success";//登录成功
        }
    }

    @RequestMapping("/register")
    @ResponseBody
    public String register (@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("name") String name){

        String repeat = userService.checkUserRepeat(username,name);
        System.out.println(repeat);
        if(repeat.equals("USERNAME_EXIST")){
            return "USERNAME_EXIST";
        }else if(repeat.equals("NAME_EXIST")){
            return "NAME_EXIST";
        }

        userService.addUser(username,password,name,0);
        return "SUCCESS";
    }


    @RequestMapping("/logout")
    public String logout (HttpSession session) {
        session.removeAttribute("USER_SESSION");
        return "redirect:../welcomeLogin.jsp";
    }

    @RequestMapping("/toUserInfo")
    public String toUserInfo () {
        return "userinfo";
    }



    @RequestMapping("/toUpdatePassword")
    public String toUpdatePassword () {
        return "updatepassword";
    }

    @RequestMapping("/toUpdateName")
    public String toUpdateName () {
        return "updatename";
    }

    @RequestMapping("/toAllUser")
    public String toAllUser () {
        return "alluser";
    }

    @RequestMapping("/toregister")
    public String toregister () {
        return "redirect:../register.jsp";
    }


    @RequestMapping("/updatePassword")
    @ResponseBody
    public String updatePassword (HttpSession session,@RequestParam("username") String username, @RequestParam("password1") String password1,@RequestParam("password2") String password2, @RequestParam("isadmin") String isadmin) {
        int Isadmin = Integer.parseInt(isadmin);

        String res = "";
        String checkUser = userService.checkUser(username,password1,Isadmin);
        if(checkUser.equals("PASSWORD_ERROR")) { //密码错误
            res = "passwordError";
        }else {
            int i = userService.updatePasswordByUsername(username, password2);

            users users = userService.queryUserByUsername(username, Isadmin);
            session.setAttribute("USER_SESSION",users);

            res = "SUCCESS";
        }
        return res;
    }

    @RequestMapping("/updateName")
    @ResponseBody
    public String updateName (HttpSession session,@RequestParam("name") String name,@RequestParam("username") String username, @RequestParam("isadmin") String isadmin) {
        int Isadmin = Integer.parseInt(isadmin);
        System.out.println(Isadmin);
        if(userService.checkNameRepeat(name).equals("NAME_EXIST")){
            System.out.println(userService.checkNameRepeat(name));
            return "NAME_EXIST";
        }else {
            if(userService.updateNameByUsername(username, name)>0){
                System.out.println(userService.updateNameByUsername(username, name));

                users users = userService.queryUserByUsername(username, Isadmin);

                System.out.println(users);

                session.setAttribute("USER_SESSION",users);
                return "SUCCESS";
            }else {
                return "ERROR";
            }

        }
    }

        @RequestMapping("/queryAllUser/{isadmin}")
    @ResponseBody
    public Map<String, Object> queryAllUser(@PathVariable("isadmin") int isadmin) {
        List<users> users = userService.queryUserByIsadmin(isadmin);
        int count = userService.userCountByIsadmin(isadmin);


        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray userarray = JSONArray.parseArray(JSON.toJSONString(users));

        map.put("msg", "");
        map.put("code", 0);
        map.put("count", count);
        map.put("data", userarray);
        return map;
    }

    @RequestMapping("/deleteUser")
    @ResponseBody
    public String deleteUser(String username) {
        String res = "";
//      不能删除自己
        if(username.equals("admin")){
            res="sessionError";
            return res;
        }
        if (userService.deleteUserByUsername(username) > 0) {
            res = "success";
        } else {
            res = "error";
        }
        return res;
    }

    @RequestMapping("/updateUserIsadmin")
    @ResponseBody
    public String updateUserIsadmin(String username,int isadmin) {
        String res = "";

        if(isadmin == 1){
            if(username.equals("admin")){
                res="sessionError";
                return res;
            }
            if(userService.updateIsadminByUsername(username,0)>0){
                res="downgrade";
            }
        }else {
            if(userService.updateIsadminByUsername(username,1)>0) {
                res = "upgrade";
            }
        }
        return res;
    }
}