package com.xianguo.service;

import com.xianguo.pojo.User;

public interface UserService {
	public void save(User user);
	public boolean checkUserByAjax(String name,String pwd);
	public User getUser(User user);
}
