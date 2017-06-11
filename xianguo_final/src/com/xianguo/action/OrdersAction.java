package com.xianguo.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.xianguo.pojo.Customer;
import com.xianguo.pojo.Orders;
import com.xianguo.pojo.OrdersProduct;
import com.xianguo.pojo.OrdersProductId;
import com.xianguo.pojo.Product;
import com.xianguo.serviceImpl.CustomerServiceImpl;
import com.xianguo.serviceImpl.OrdersServiceImpl;
import com.xianguo.util.Cart;
import com.xianguo.util.CartItem;

public class OrdersAction extends ActionSupport{
	
	
	private OrdersServiceImpl ordersServiceImpl;
	private CustomerServiceImpl customerServiceImpl;
	
	
	
	public CustomerServiceImpl getCustomerServiceImpl() {
		return customerServiceImpl;
	}


	public void setCustomerServiceImpl(CustomerServiceImpl customerServiceImpl) {
		this.customerServiceImpl = customerServiceImpl;
	}


	public OrdersServiceImpl getOrdersServiceImpl() {
		return ordersServiceImpl;
	}


	public void setOrdersServiceImpl(OrdersServiceImpl ordersServiceImpl) {
		this.ordersServiceImpl = ordersServiceImpl;
	}




	public String subOrders(){
	
		HttpSession session = ServletActionContext.getRequest().getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		Customer customer=(Customer)session.getAttribute("customer");
		Orders orders = new Orders();
		orders.setOphone(customer.getCphone());
		orders.setOaddress(customer.getCaddress());
		orders.setCustomer(customer);
		Set<OrdersProduct> set =orders.getOrdersProducts();

		for (CartItem cartItem : cart.getCartItems()) {
			OrdersProduct ordersProduct =new OrdersProduct();
			OrdersProductId ordersProductId = new OrdersProductId();

			ordersProductId.setPid(cartItem.getProduct().getPid());
			ordersProductId.setOpnumber(Long.valueOf( String.valueOf(cartItem.getCount())));
			ordersProductId.setOid(orders.getOid());
			
			ordersProduct.setProduct(cartItem.getProduct());
			ordersProduct.setId(ordersProductId);
			ordersProduct.setOrders(orders);
			
			ordersServiceImpl.saveOrdersProduct(ordersProduct);
			set.add(ordersProduct);
		}
		ordersServiceImpl.saveOrders(orders);
		return "subOrders";
	}
	
	
	
	public String showOrders(){
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		Customer customer=(Customer)session.getAttribute("customer");
		
		Set<Orders> set = customerServiceImpl.getCustomerById(customer.getCid()).getOrderses();
//		System.err.println("dddddddddddddddddddd" + customer.getCid());
		List<Product> products = new ArrayList<Product>();
		Double total=0d;
		for (Orders orders : set) {

			Set<OrdersProduct> ordersProducts = orders.getOrdersProducts();
			for (OrdersProduct ordersProduct : ordersProducts) {
//				System.out.println("dddddddddddddddddddd"
//						+ ordersProduct.getProduct().getPname());
				Product p = ordersProduct.getProduct();
				p.setPnumber(ordersProduct.getId().getOpnumber());
				total = total+p.getPsellingPrice()*(ordersProduct.getId().getOpnumber());
				products.add(p);
			}
		}
		if (session.getAttribute("oproducts") != null) {
			session.removeAttribute("oproducts");
		}
		session.setAttribute("oproducts", products);
		session.setAttribute("total", total);
		return "showOrders";
	}
	
	
	
	
}
