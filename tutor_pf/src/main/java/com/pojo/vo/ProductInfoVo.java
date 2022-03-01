package com.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.Resource;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductInfoVo {

    // 商品名稱
    private  String pname;
    // 商品類型
    private Integer typeid;
    // 商品價格
    private Integer lprice;
    // 最高價格
    private Integer hprice;
    // 頁碼
    private Integer page =1;

}
