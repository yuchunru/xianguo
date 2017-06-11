package com.xianguo.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.xianguo.daoImpl.UserDaoImpl;
import com.xianguo.pojo.Customer;
import com.xianguo.pojo.User;
import com.xianguo.serviceImpl.ProductServiceImpl;
import com.xianguo.serviceImpl.UserServiceImpl;


public class UserAction extends ActionSupport{
	
	private User user;
	private UserServiceImpl userServiceImpl;
	private ProductServiceImpl productServiceImpl;
	
	public ProductServiceImpl getProductServiceImpl() {
		return productServiceImpl;
	}
	public void setProductServiceImpl(ProductServiceImpl productServiceImpl) {
		this.productServiceImpl = productServiceImpl;
	}
	public UserServiceImpl getUserServiceImpl() {
		return userServiceImpl;
	}
	public void setUserServiceImpl(UserServiceImpl userServiceImpl) {
		this.userServiceImpl = userServiceImpl;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}

	
	public String addUser() {
		
		this.userServiceImpl.save(this.user);
		return SUCCESS;
	}
	
	public void checkUserByAjax() throws IOException {

		PrintWriter out = ServletActionContext.getResponse().getWriter();
		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		if (userServiceImpl.checkUserByAjax(name, pwd)) {
			out.print("y");
			out.flush();
			out.close();
		} else {
			out.print("n");
			out.flush();
			out.close();
		}

	}
	public String login() throws UnsupportedEncodingException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String cusername = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
		String cpwd = new String(request.getParameter("pwd").getBytes("ISO-8859-1"),"UTF-8");
		this.user.setUsername(cusername);;
		this.user.setPassword(cpwd);
				
		User u = userServiceImpl.getUser(user);
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("user", u);
		System.err.println("action  de  "+user.getUsername());
		
		session.setAttribute("uproducts", productServiceImpl.getProducts());
		return "login";
	}

}
