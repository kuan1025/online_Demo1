package com.service.Imp;

import com.mapper.AdminMapper;
import com.pojo.Admin;
import com.pojo.AdminExample;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    @Override
    public Admin login(String name, String pwd) {

        //根據傳入的用戶名查詢相對應的用戶
        // 如果有條件 必須建立AdminExample的物件，用來封裝
        AdminExample example = new AdminExample();
        /** 加入條件方式
            select * from admin where a_name = 'admin'
         */
        //加入用戶名字條件
        example.createCriteria().andANameEqualTo(name);

        List<Admin> list = adminMapper.selectByExample(example);
        if(list.size()>0){
            Admin admin = list.get(0);
//            做密碼比對
            if(admin.getaPass().equals(pwd)){
                return admin;
            }
        }

        //如果找到就做比對

        return null;
    }
}
