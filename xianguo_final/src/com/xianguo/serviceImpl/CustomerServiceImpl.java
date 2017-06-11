package com.xianguo.serviceImpl;

import com.xianguo.daoImpl.CustomerDaoImpl;
import com.xianguo.pojo.Customer;
import com.xianguo.service.CustomerService;

public class CustomerServiceImpl implements CustomerService {
	
	CustomerDaoImpl customerDaoImpl;
	
	

	public CustomerDaoImpl getCustomerDaoImpl() {
		return customerDaoImpl;
	}



	public void setCustomerDaoImpl(CustomerDaoImpl customerDaoImpl) {
		this.customerDaoImpl = customerDaoImpl;
	}



	@Override
	public boolean checkUserByAjax(String name, String pwd) {
		// TODO Auto-generated method stub
		return customerDaoImpl.checkUserByAjax(name, pwd);
	}



	@Override
	public Customer getCustomer(Customer customer) {
		// TODO Auto-generated method stub
		return customerDaoImpl.getCustomer(customer);
	}



	@Override
	public void saveUser(Customer customer) {
		// TODO Auto-generated method stub
		customerDaoImpl.saveUser(customer);
	}



	@Override
	public void updateUser(Customer customer) {
		// TODO Auto-generated method stub
		customerDaoImpl.updateUser(customer);
	}



	@Override
	public Customer getCustomerById(Long cid) {
		// TODO Auto-generated method stub
		return customerDaoImpl.getCustomerById(cid);
	}

}
