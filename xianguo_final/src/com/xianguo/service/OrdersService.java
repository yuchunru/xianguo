package com.xianguo.service;

import com.xianguo.pojo.Orders;
import com.xianguo.pojo.OrdersProduct;

public interface OrdersService {
	public void saveOrders(Orders orders);
	
	public void saveOrdersProduct(OrdersProduct ordersProduct);
}
