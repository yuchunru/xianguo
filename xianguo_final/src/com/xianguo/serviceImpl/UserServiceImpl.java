package com.xianguo.serviceImpl;

import com.xianguo.daoImpl.UserDaoImpl;
import com.xianguo.pojo.User;
import com.xianguo.service.UserService;

public class UserServiceImpl implements UserService{
	
	UserDaoImpl userDaoImpl;
	
	

	public UserDaoImpl getUserDaoImpl() {
		return userDaoImpl;
	}



	public void setUserDaoImpl(UserDaoImpl userDaoImpl) {
		this.userDaoImpl = userDaoImpl;
	}



	@Override
	public void save(User user) {
		// TODO Auto-generated method stub
		userDaoImpl.save(user);
	}



	@Override
	public boolean checkUserByAjax(String name, String pwd) {
		// TODO Auto-generated method stub
		return userDaoImpl.checkUserByAjax(name, pwd);
	}



	@Override
	public User getUser(User user) {
		// TODO Auto-generated method stub
		return userDaoImpl.getUser(user);
	}

}
