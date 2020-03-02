package com.dyz.service;

import com.dyz.entity.users;

import java.util.List;


public interface UserService {
    //登录判定
    String checkUser(String username, String password, int isadmin);

    users queryUserByUsername(String username, int isadmin);

    //通过name查询username
    String queryUserNameByName(String name);

    //更新password
    int updatePasswordByUsername(String username,String password);

    //查询全部普通用户
    List<users> queryUserByIsadmin(int isadmin);

    //根据isadmin返回user总数
    int userCountByIsadmin(int isadmin);

    //根据username删除user
    int deleteUserByUsername(String username);

    //根据username更改isadmin
    int updateIsadminByUsername(String username,int isadmin);

    //增加user
    int addUser(String username,String password,String name,int isadmin);

    //注册查重
    String checkUserRepeat(String username,String name);

    //name查重
    String checkNameRepeat(String name);

    //更改name
    int updateNameByUsername(String username,String name);
}
