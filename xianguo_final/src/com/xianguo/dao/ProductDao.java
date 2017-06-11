package com.xianguo.dao;

import java.util.List;

import com.xianguo.pojo.Product;
import com.xianguo.util.PageUtil;

public interface ProductDao {
	
	public List<Product> showProductByPage(PageUtil pageUtil);
	
	public List<Product> showCategory(String pcategory);
	
	public List<Product> getProducts();
	
	public int getTotalCount();
	
	public Product getProductByPid(Long pid);
	
	public void delProduct(Long pid);
	
}
