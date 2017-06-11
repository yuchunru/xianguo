package com.xianguo.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.xianguo.pojo.Customer;
import com.xianguo.serviceImpl.CustomerServiceImpl;

@SuppressWarnings("serial")
public class CustomerAction extends ActionSupport{
	
	CustomerServiceImpl customerServiceImpl;
	Customer customer;
	



	public Customer getCustomer() {
		return customer;
	}



	public void setCustomer(Customer customer) {
		this.customer = customer;
	}



	public CustomerServiceImpl getCustomerServiceImpl() {
		return customerServiceImpl;
	}



	public void setCustomerServiceImpl(CustomerServiceImpl customerServiceImpl) {
		this.customerServiceImpl = customerServiceImpl;
	}



	public void checkUserByAjax() throws IOException{
		
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		HttpServletRequest request = ServletActionContext.getRequest();
		String name =request.getParameter("name");
		String pwd = request.getParameter("pwd");
		if (customerServiceImpl.checkUserByAjax(name, pwd)) {
			out.print("y");
			out.flush();
			out.close();
		}else {
			out.print("n");
			out.flush();
			out.close();
		}
			
	}
	
	public String login() throws UnsupportedEncodingException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String cusername = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
		String cpwd = new String(request.getParameter("pwd").getBytes("ISO-8859-1"),"UTF-8");
		this.customer.setCusername(cusername);
		this.customer.setCpwd(cpwd);
				
		Customer cuser = customerServiceImpl.getCustomer(this.customer);
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("customer", cuser);
		System.err.println("action  de  "+cuser.getCusername());

		return "login";
	}
	
	public String showUserInfo(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String cid = request.getParameter("cid");
		System.err.println(cid);
		
		Customer customer=customerServiceImpl.getCustomerById(Long.valueOf(cid));
		
		request.getSession().setAttribute("cuser", customer);
		
		System.err.println("sssssssssssssssssssss"+customer.getCaddress());
		
		return "showUserInfo";
	}
	
	public String updateUserInfo(){
		//System.err.println(customer.getCbirthday());
//		System.err.println(customer.getCsex());
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = ServletActionContext.getRequest().getSession();
//		System.err.println(request.getParameter("s_province"));
		
		Customer cuser= (Customer)session.getAttribute("customer");
		cuser.setCname(customer.getCname());
		cuser.setCsex(customer.getCsex());
		cuser.setCbirthday(customer.getCbirthday());
		cuser.setCphone(customer.getCphone());
		
		String s_province = request.getParameter("s_province");
		String s_city = request.getParameter("s_city");
		String s_county = request.getParameter("s_county");
		
		String address = s_province+s_city+s_county+customer.getCaddress();
		
		cuser.setCaddress(address);
		customerServiceImpl.updateUser(cuser);
//		System.err.println("upppppppppppp"+cuser.getCid());

		return "updateUserInfo";
	}
	
	public String register() throws UnsupportedEncodingException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setCharacterEncoding("UTF-8");

		String cusername = request.getParameter("cusername");
		String cpwd = request.getParameter("cpwd");
		System.err.println(cusername);
		
		Customer customer = new Customer();
		customer.setCusername(cusername);
		customer.setCpwd(cpwd);
		
		customerServiceImpl.saveUser(customer);
		return "register";
	} 
	
	
}
