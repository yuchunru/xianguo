package com.xianguo.util;

import com.xianguo.pojo.Product;

public class CartItem {

	// ��Ʒ����
	private Product product;
		// ����
	private Integer count;
		// С��
	private Double subtotal;
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	public Double getSubtotal() {
		return count * product.getPsellingPrice();
	}
	
	
	
}
