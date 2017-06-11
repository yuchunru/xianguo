package com.xianguo.daoImpl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.xianguo.dao.UserDao;
import com.xianguo.pojo.Customer;
import com.xianguo.pojo.User;

public class UserDaoImpl implements UserDao{
	
	HibernateTemplate hibernateTemplate;
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Override
	public void save(User user) {
		// TODO Auto-generated method stub
		hibernateTemplate.save(user);
	
		
	}

	@Override
	public boolean checkUserByAjax(String name, String pwd) {
		// TODO Auto-generated method stub
		Session session = hibernateTemplate.getSessionFactory().openSession();
		String sql = "from User where username = ? and password = ?";
		Query query = session.createQuery(sql);
		query.setString(0, name);
		query.setString(1, pwd);
		List<User> users = (List<User>)query.list();
		session.close();
		if (users.size()>0) {
			return true;
		}else{
			return false;
		}
	}

	@Override
	public User getUser(User user) {
		// TODO Auto-generated method stub
		User u = (User)(hibernateTemplate.findByExample(user).get(0));
		return u;
	}

}
