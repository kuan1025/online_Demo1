package com.service.Imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.ProductInfoMapper;
import com.pojo.ProductInfo;
import com.pojo.ProductInfoExample;
import com.pojo.vo.ProductInfoVo;
import com.service.ProductInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {

    @Autowired
    ProductInfoMapper productInfoMapper;

    // 所有產品
    @Override
    public List<ProductInfo> listAll() {
        // 想要加入條件判斷 做example 沒有直接就放進去
      return productInfoMapper.selectByExample(new ProductInfoExample());
    }

    // 分頁處理
    @Override
    public PageInfo<ProductInfo> splitPage(int pageNum, int pageSize) {
        // 用pageHelper
        PageHelper.startPage(pageNum,pageSize);
        ProductInfoExample example = new ProductInfoExample();
        // 按照pk desc 查productInfoMapper
        example.setOrderByClause("p_id desc");
        // 設定排序後，取得collection

        // 1. 把example塞回去
        List<ProductInfo> list = productInfoMapper.selectByExample(example);

        // 2. 封裝pageInfo 3. 並把list給pageInfo管理
        PageInfo<ProductInfo> productInfoPageInfo = new PageInfo<>(list);
        return  productInfoPageInfo;
    }

    @Override
    public int save(ProductInfo info) {
        return productInfoMapper.insert(info);
    }

    @Override
    public ProductInfo getById(int pid) {
        return productInfoMapper.selectByPrimaryKey(pid);
    }

    @Override
    public int update(ProductInfo info) {
        return productInfoMapper.updateByPrimaryKey(info);
    }

    @Override
    public int delete(int pid) {
        return productInfoMapper.deleteByPrimaryKey(pid);
    }

    @Override
    public int deleteBatch(String[] ids) {
        return productInfoMapper.deleteBatch(ids);
    }

    @Override
    public List<ProductInfo> selectCondition(ProductInfoVo vo) {
        return  productInfoMapper.selectCondition(vo);
    }

    @Override
    public PageInfo<ProductInfo>  splitPageVo(ProductInfoVo vo, int pageSize) {
        // 取集合前，先配置pageHelper
        PageHelper.startPage(vo.getPage(),pageSize);
        List<ProductInfo> list = productInfoMapper.selectCondition(vo);
        return  new PageInfo<>(list);

    }
}
