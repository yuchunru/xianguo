package com.xianguo.serviceImpl;

import java.util.List;

import com.xianguo.daoImpl.ProductDaoImpl;
import com.xianguo.pojo.Product;
import com.xianguo.service.ProductService;
import com.xianguo.util.PageUtil;

public class ProductServiceImpl implements ProductService{
	
	private ProductDaoImpl productDaoImpl;
	

	public ProductDaoImpl getProductDaoImpl() {
		return productDaoImpl;
	}


	public void setProductDaoImpl(ProductDaoImpl productDaoImpl) {
		this.productDaoImpl = productDaoImpl;
	}


	@Override
	public List<Product> showProductByPage(PageUtil pageUtil) {
		// TODO Auto-generated method stub
		return productDaoImpl.showProductByPage(pageUtil);
	}


	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return productDaoImpl.getTotalCount();
	}


	@Override
	public List<Product> showCategory(String pcategory) {
		// TODO Auto-generated method stub
		
		return productDaoImpl.showCategory(pcategory);
	}


	@Override
	public Product getProductByPid(Long pid) {
		// TODO Auto-generated method stub
		return productDaoImpl.getProductByPid(pid);
	}


	@Override
	public void delProduct(Long pid) {
		// TODO Auto-generated method stub
		productDaoImpl.delProduct(pid);
	}


	@Override
	public List<Product> getProducts() {
		// TODO Auto-generated method stub
		return productDaoImpl.getProducts();
	}

}
