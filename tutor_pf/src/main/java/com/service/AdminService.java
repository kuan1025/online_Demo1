package com.service;

import com.pojo.Admin;

public interface AdminService {
    // 登入判斷
    Admin login(String name, String pwd);
}
