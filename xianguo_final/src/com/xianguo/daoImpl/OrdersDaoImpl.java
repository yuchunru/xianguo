package com.xianguo.daoImpl;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.xianguo.dao.OrdersDao;
import com.xianguo.pojo.Orders;
import com.xianguo.pojo.OrdersProduct;

public class OrdersDaoImpl implements OrdersDao{

	HibernateTemplate hibernateTemplate;
	
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}


	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}


	@Override
	public void saveOrders(Orders orders) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.save(orders);
	}


	@Override
	public void saveOrdersProduct(OrdersProduct ordersProduct) {
		// TODO Auto-generated method stub
		this.hibernateTemplate.save(ordersProduct);
	}

}
