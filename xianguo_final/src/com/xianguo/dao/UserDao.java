package com.xianguo.dao;

import com.xianguo.pojo.User;

public interface UserDao {
	
	public void save(User user);
	public boolean checkUserByAjax(String name,String pwd);
	public User getUser(User user);
}
