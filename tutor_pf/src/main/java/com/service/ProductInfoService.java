package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.ProductInfo;
import com.pojo.vo.ProductInfoVo;

import java.util.List;


public interface ProductInfoService {

    // 所有產品
    List<ProductInfo> listAll();

    // 分頁功能
    PageInfo splitPage(int pageNum, int pageSize);

    //檔案上傳
    int save(ProductInfo info);

    // 按照pk找產品
    ProductInfo getById(int pid);

    // 更新產品
    int update(ProductInfo info);

    // 刪除一個產品
    int delete(int pid);

    // 刪除多個
    int deleteBatch(String []ids);

    // 查詢多個條件
    List<ProductInfo> selectCondition(ProductInfoVo vo);

    // 查詢多個條件(分頁)
    public  PageInfo<ProductInfo> splitPageVo(ProductInfoVo vo,int pageSize);
}
