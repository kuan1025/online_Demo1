package com.controller;


import com.github.pagehelper.PageInfo;
import com.pojo.ProductInfo;
import com.pojo.vo.ProductInfoVo;
import com.service.ProductInfoService;


import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/prod")
public class ProductionInfoAction {

    // 每頁顯示的筆數
    public static final int PAGE_SIZE = 5;

    @Autowired
    ProductInfoService productInfoService;

    // 照片非同步返回網站的參數 作為全域可以重複給上傳用
    String fileName = "";

    // 所有產品
    @RequestMapping("/getAll")
    public String getAll(Model model) {
        List<ProductInfo> list = productInfoService.listAll();
        model.addAttribute("list", list);
        return "product";
    }


    // 分頁 一次5筆資料
    @RequestMapping("/split.action")
    public ModelAndView split(HttpServletRequest request) {
        PageInfo info = null;
        Object vo = request.getSession().getAttribute("proVo");
        if(vo!=null){
            info = productInfoService.splitPageVo((ProductInfoVo)vo,PAGE_SIZE);
            request.getSession().setAttribute("vo", vo);
//            request.getSession().removeAttribute("proVo");
        }else{
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        System.out.println("進入");
        ModelAndView modelAndView = new ModelAndView();
        // 第一頁產品
        modelAndView.addObject("info", info);
        modelAndView.setViewName("product");
        return modelAndView;
    }

    // ajax 處理分頁
    @ResponseBody
    @RequestMapping("/ajaxSplit.action")
    public void ajaxSplit(ProductInfoVo vo, HttpSession session) {
//        只能用session 因為request已經被用
        PageInfo info = productInfoService.splitPageVo(vo, PAGE_SIZE);
        session.setAttribute("info", info);
    }

    //非同步ajax檔案上傳
    @ResponseBody
    @RequestMapping("/ajaxImg")
    public Object ajaxImg(MultipartFile pimage, HttpServletRequest request) throws IOException {
        // 取得檔案名稱
        String originalFilename = pimage.getOriginalFilename();
        // 取得檔案類型
        String substring = originalFilename.substring(originalFilename.lastIndexOf("."));
        // 用現在時間命名
        fileName = System.currentTimeMillis() + substring;

        // 得到圖片存放位址
        String path = request.getServletContext().getRealPath("/image_big");
        // 連接
        pimage.transferTo(new File(path + "/" + fileName));


        // 返回json
        JSONObject object = new JSONObject();
        object.put("imgurl", fileName);
        // json返回記得toString
        return object.toString();
    }

    @RequestMapping("/save")
    public ModelAndView save(ProductInfo info) {
        info.setpImage(fileName);
        info.setpDate(new Date());
        ModelAndView mv = new ModelAndView();
        // info中有有表單submit的5個資料
        int num = -1;
        try {
            num = productInfoService.save(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0) {
            mv.addObject("msg", "新增成功!!");
            // 成功要跳到分頁
        } else {
            mv.addObject("msg", "新增失敗!!");

        }
        // 請空fileName裡面的內容 避免下次非同步上傳或修改
        fileName = null;
        mv.setViewName("forward:/prod/split.action");
        return mv;
    }

    @RequestMapping("/one")
    public ModelAndView one(int pid,ProductInfoVo vo, ModelAndView mv,HttpSession session) {
        ProductInfo info = productInfoService.getById(pid);
        mv.addObject("prod", info);
        mv.setViewName("update");
        // 將多條件頁碼放進session，更新完後會回到該頁
        session.setAttribute("proVo",vo);
        return mv;
    }

    @RequestMapping("/update")
    public String update(ProductInfo info, HttpServletRequest request) {
        // 如果有上傳過照片，不會是null， 因為在save已經處理過，
        if (!fileName.equals("")) {
            info.setpImage(fileName);
        }
        int num = -1;
        try {
            num = productInfoService.update(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num > 0) {
            request.setAttribute("msg", "更新成功");
        } else {
            request.setAttribute("msg", "更新失敗");
        }
        fileName = "";
        return "forward:/prod/split.action";
    }

    //@requestBody 這裡不能用 還要轉發
    @RequestMapping("/delete")
    public String delete(int pid,ProductInfoVo vo, HttpServletRequest request) {
        int num = -1;
        try {
            num = productInfoService.delete(pid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(num>0){
            request.setAttribute("msg","刪除成功");
            request.getSession().setAttribute("deleteProvo",vo);
        }else{
            request.setAttribute("msg","刪除失敗");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }

    @ResponseBody //顯示中文要用charset = utf-8
    @RequestMapping(value = "/deleteAjaxSplit",produces = "text/html;charset=UTF-8")
    public Object deleteAjaxSplit(HttpServletRequest request){
        // 取得第一頁的資料
        PageInfo info = null;
        Object vo  = request.getSession().getAttribute("deleteProvo");
        if(vo!=null){
            info = productInfoService.splitPageVo((ProductInfoVo)vo,PAGE_SIZE);
        }else {
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        // 放session 既使load 還存在
        request.getSession().setAttribute("info",info);
        return request.getAttribute("msg");
    }

    //勾選移除
    @RequestMapping("/deleteBatch")
    public String deleteBatch(String pids,ProductInfoVo vo,HttpServletRequest request){
        // 將傳來的String 轉成商品id String[]
        String[] ps = pids.split("," );
        try {
            int num = productInfoService.deleteBatch(ps);

            if(num>0){
                request.setAttribute("msg","移除成功");
                request.getSession().setAttribute("deleteProvo",vo);
            }else{
                request.setAttribute("msg","移除失敗");
            }
        } catch (Exception e) {
            request.setAttribute("msg","商品不能刪除");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }
    // 多條件查詢
    @ResponseBody
    @RequestMapping("/condition")
    public void condition(ProductInfoVo vo,HttpSession session){
        List<ProductInfo> list = productInfoService.selectCondition(vo);
        session.setAttribute("list",list);
    }


}
