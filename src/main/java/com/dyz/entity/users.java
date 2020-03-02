package com.dyz.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class users {
    private String username;
    private String password;
    private String name;
    private int isadmin;
}
