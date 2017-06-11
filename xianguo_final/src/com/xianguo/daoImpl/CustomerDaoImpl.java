package com.xianguo.daoImpl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.xianguo.dao.CustomerDao;
import com.xianguo.pojo.Customer;
import com.xianguo.pojo.Product;

public class CustomerDaoImpl implements CustomerDao {

	HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	@Override
	public boolean checkUserByAjax(String name, String pwd) {
		// TODO Auto-generated method stub
		Session session = hibernateTemplate.getSessionFactory().openSession();
		String sql = "from Customer where cusername = ? and cpwd = ?";
		Query query = session.createQuery(sql);
		query.setString(0, name);
		query.setString(1, pwd);
		List<Customer> customers = (List<Customer>)query.list();
		session.close();
		if (customers.size()>0) {
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Customer getCustomer(Customer customer) {
		// TODO Auto-generated method stub
		
		
		Customer cuser = (Customer)(hibernateTemplate.findByExample(customer).get(0));
		return cuser;
	}

	@Override
	public void saveUser(Customer customer) {
		// TODO Auto-generated method stub
		
		hibernateTemplate.save(customer);
	}

	@Override
	public void updateUser(Customer customer) {
		// TODO Auto-generated method stub
		hibernateTemplate.update(customer);
	}

	@Override
	public Customer getCustomerById(Long cid) {
		// TODO Auto-generated method stub
		
		return hibernateTemplate.get(Customer.class, cid);
		 
	}

}
