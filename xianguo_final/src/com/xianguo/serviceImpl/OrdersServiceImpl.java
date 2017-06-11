package com.xianguo.serviceImpl;

import com.xianguo.daoImpl.OrdersDaoImpl;
import com.xianguo.pojo.Orders;
import com.xianguo.pojo.OrdersProduct;
import com.xianguo.service.OrdersService;

public class OrdersServiceImpl implements OrdersService{

	OrdersDaoImpl ordersDaoImpl;
	
	public OrdersDaoImpl getOrdersDaoImpl() {
		return ordersDaoImpl;
	}

	public void setOrdersDaoImpl(OrdersDaoImpl ordersDaoImpl) {
		this.ordersDaoImpl = ordersDaoImpl;
	}

	@Override
	public void saveOrders(Orders orders) {
		// TODO Auto-generated method stub
		ordersDaoImpl.saveOrders(orders);
	}

	@Override
	public void saveOrdersProduct(OrdersProduct ordersProduct) {
		// TODO Auto-generated method stub
		ordersDaoImpl.saveOrdersProduct(ordersProduct);
	}

}
