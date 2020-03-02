package com.dyz.service;

import com.dyz.dao.UserMapper;
import com.dyz.entity.users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    //Service 调用 Dao 层
    @Autowired
    @Qualifier("userMapper")
    private UserMapper userMapper;

    public String checkUser(String username,String password,int isadmin) {
        users checkuser = userMapper.queryUserByUsername(username,isadmin);

        if(checkuser == null){
            return "USERNAME_ERROR";   //用户不存在
        }
        if(!checkuser.getPassword().equals(password)){
            return "PASSWORD_ERROR";    //密码错误
        }else {
            String name = checkuser.getName();
            return name;   //登录成功
        }
    }

    public users queryUserByUsername(String username, int isadmin) {
        return userMapper.queryUserByUsername(username,isadmin);
    }

    public String queryUserNameByName(String name) {
        return userMapper.queryUserNameByName(name);
    }

    public int updatePasswordByUsername(String username, String password) {
        return userMapper.updatePasswordByUsername(username,password);
    }

    public List<users> queryUserByIsadmin(int isadmin) {
        return userMapper.queryUserByIsadmin(isadmin);
    }

    public int userCountByIsadmin(int isadmin) {
        return userMapper.userCountByIsadmin(isadmin);
    }

    public int deleteUserByUsername(String username) {
        return userMapper.deleteUserByUsername(username);
    }

    public int updateIsadminByUsername(String username, int isadmin) {
        return userMapper.updateIsadminByUsername(username,isadmin);
    }

    public int addUser(String username,String password,String name,int isadmin) {
        return userMapper.addUser(new users(username,password,name,isadmin));
    }

    public String checkUserRepeat(String username, String name) {
        if(userMapper.queryUserByUsername(username,0)!=null || userMapper.queryUserByUsername(username,1)!=null){
            return "USERNAME_EXIST";
        }
        if(userMapper.queryUserByName(name) != null){
            return "NAME_EXIST";
        }
        return "NO_REPEAT";
    }

    public String checkNameRepeat(String name) {
        if(userMapper.queryUserByName(name) != null){
            return "NAME_EXIST";
        }
        return "NO_REPEAT";
    }

    public int updateNameByUsername(String username, String name) {
        return userMapper.updateNameByUsername(username,name);
    }


}
