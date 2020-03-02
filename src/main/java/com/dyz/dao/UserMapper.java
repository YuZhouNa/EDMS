package com.dyz.dao;

import com.dyz.entity.users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    //通过username查找user字段
    users queryUserByUsername(@Param("username") String username,@Param("isadmin") int isadmin);

    //通过name查找user字段
    users queryUserByName(@Param("name") String name);

    //通过name查询username字段
    String queryUserNameByName(@Param("name")String name);

    //更新password
    int updatePasswordByUsername(@Param("username")String username,@Param("password")String password);

    //查询全部普通用户
    List<users> queryUserByIsadmin(@Param("isadmin") int isadmin);

    //根据isadmin返回user总数
    int userCountByIsadmin(@Param("isadmin") int isadmin);

    //根据username删除user
    int deleteUserByUsername(@Param("username") String username);

    //根据username更改isadmin
    int updateIsadminByUsername(@Param("username") String username,@Param("isadmin") int isadmin);

    //增加user
    int addUser(users users);

    //更改name
    int updateNameByUsername(@Param("username")String username,@Param("name")String name);

}
