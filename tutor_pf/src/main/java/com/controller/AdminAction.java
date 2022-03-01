package com.controller;

import com.pojo.Admin;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminAction {

    @Autowired
    AdminService adminService;

    // 做登入判斷，跳轉
    @RequestMapping("/login")
    public ModelAndView login(String name, String pwd){
        ModelAndView mv = new ModelAndView();
        Admin admin = adminService.login(name,pwd);
        System.out.println(name);
        if(null != admin){
            //登入成功
            mv.addObject("admin",admin);

            mv.setViewName("main1");
        }else{
            //登入失敗\
            mv.addObject("errmsg","用戶名或密碼錯誤 ！");
            mv.setViewName("login1");
        }
        return mv;
    }

}
