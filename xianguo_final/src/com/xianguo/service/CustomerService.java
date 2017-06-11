package com.xianguo.service;

import com.xianguo.pojo.Customer;

public interface CustomerService {

	public boolean checkUserByAjax(String name,String pwd);
	public Customer getCustomer(Customer customer);
	public void saveUser(Customer customer);
	public void updateUser(Customer customer);
	public Customer getCustomerById(Long cid);

}
