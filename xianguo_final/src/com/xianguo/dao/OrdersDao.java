package com.xianguo.dao;

import com.xianguo.pojo.Orders;
import com.xianguo.pojo.OrdersProduct;

public interface OrdersDao {

	public void saveOrders(Orders orders);
	public void saveOrdersProduct(OrdersProduct ordersProduct);
}
