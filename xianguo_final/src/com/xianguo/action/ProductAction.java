package com.xianguo.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.xianguo.pojo.Product;
import com.xianguo.pojo.Seller;
import com.xianguo.pojo.User;
import com.xianguo.serviceImpl.ProductServiceImpl;
import com.xianguo.util.Cart;
import com.xianguo.util.CartItem;
import com.xianguo.util.PageUtil;

public class ProductAction extends ActionSupport {

	private PageUtil pageUtil;

	public PageUtil getPageUtil() {
		return pageUtil;
	}

	public void setPageUtil(PageUtil pageUtil) {
		this.pageUtil = pageUtil;
	}

	private ProductServiceImpl productServiceImpl;

	public ProductServiceImpl getProductServiceImpl() {
		return productServiceImpl;
	}

	public void setProductServiceImpl(ProductServiceImpl productServiceImpl) {
		this.productServiceImpl = productServiceImpl;
	}

	public String showProductByPage() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		HttpServletRequest request = ServletActionContext.getRequest();

		String pageType = request.getParameter("pageType");
		String action = request.getParameter("action");
		int totalCount = productServiceImpl.getTotalCount();
		if ("initial".equals(action)) {
			pageUtil.counter("first", totalCount);
			session.setAttribute("pageBean", pageUtil);
		} else {
			pageUtil = (PageUtil) session.getAttribute("pageBean");
			pageUtil.counter(pageType, pageUtil.getTotalRows());
		}
		List<Product> products = productServiceImpl.showProductByPage(pageUtil);
		session.setAttribute("products", products);
		session.setAttribute("pageBean", pageUtil);

		return "success";
	}

	public String showCategory() {

		HttpServletRequest request = ServletActionContext.getRequest();
		String pcategory = request.getParameter("pcategory");
		if ("berry".equals(pcategory)) {
			pcategory = "浆果类";
		} else if ("coreberry".equals(pcategory)) {
			pcategory = "核果类";
		} else if ("nut".equals(pcategory)) {
			pcategory = "仁果类";
		} else {
			pcategory = "瓜类";
		}
		List<Product> products = productServiceImpl.showCategory(pcategory);
		ActionContext context = ActionContext.getContext();
		if (products != null) {
			context.put("products", products);
		}

		return "showCategory";
	}
	
	//对应页面的添加购物车
	public void addCart() throws IOException{
		ServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
//		System.err.println(pid);
		Product product = productServiceImpl.getProductByPid(Long.valueOf(pid));
		
		String inOrder = request.getParameter("inOrder");

		//向购物车添加
		updateCart(product, 1,inOrder,writer);
		
		writer.flush();
		writer.close();
	}
	
	
	/**
	 * 从session范围获得购物车的代码
	 */
	public Cart getCart(HttpServletRequest request) {
		// 从session的范围获得Cart对象.
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		// 判断:
		if (cart == null) {
			// 创建购物车对象
			cart = new Cart();
			// 将购物车对象放入到session范围:
			request.getSession().setAttribute("cart", cart);
		}
		return cart;
	}

	/**
	 * 添加到购物车的方法:
	 */
	public String updateCart(Product product, Integer count, String inOrder,
			PrintWriter writer) {

		// 查询商品信息:
		// Product product = productServiceImpl.getProductByPid(pid);
		// 创建一个购物项对象:
		CartItem cartItem = new CartItem();
		cartItem.setCount(count);
		cartItem.setProduct(product);
		// 获取购物车 需要依赖request对象
		HttpServletRequest request = ServletActionContext.getRequest();
		Cart cart = getCart(request);
		cart.addCart(cartItem);
		testCart(cart);
		if (inOrder == null) {
			// 为传入前台的类设置
			Product p = new Product();
			p.setPid(product.getPid());
			p.setPname(product.getPname());
			p.setPsellingPrice(product.getPsellingPrice());
			p.setPpicLocation(product.getPpicLocation());
			p.setPnumber(product.getPnumber());

			// 将获取到的类传入前台
			JSONArray jsonArray = JSONArray.fromObject(p);
			System.out.println(jsonArray);
			writer.print(jsonArray.toString());
		} else {
			writer.print(cart.allSum(cart));
		}
		return "addCartSuccess";
	}
	
	
	//对应页面的减号
	public void cutCart() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
		Product product = productServiceImpl.getProductByPid(Long.valueOf(pid));
		System.err.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"+pid);

		CartItem cartItem = new CartItem();
		cartItem.setCount(1);
		cartItem.setProduct(product);
			
		Cart cart = getCart(request);
//		Cart cart = (Cart)request.getSession().getAttribute("cart");
		cart.minusCart(cartItem);
		testCart(cart);
			
		getSum(cart);

				
	}
	
	//对应页面的删除
	public void delCart() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
		System.err.println("proAction de  "+pid);
//		Cart cart = getCart(request);

		Cart cart = (Cart)request.getSession().getAttribute("cart");
		cart.removeCart(Long.valueOf(pid));
		testCart(cart);
		
		
		getSum(cart);
	}
	
	public void getSum(Cart cart) throws IOException{
		ServletResponse response = ServletActionContext.getResponse();
		PrintWriter writer = response.getWriter();
		writer.print(String.valueOf(cart.allSum(cart)));
		writer.flush();
		writer.close();
	}
	
	public String showProductInfo(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
//		System.err.println(pid);
		Product product = productServiceImpl.getProductByPid(Long.valueOf(pid));
		ActionContext context = ActionContext.getContext();
		context.put("SelProduct", product);
		return "showProductInfo";
	}
	
	public void delProduct(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
		productServiceImpl.delProduct(Long.valueOf(pid));
		
	}
	
	public String addProduct(){
		
		
		
		
		Product product = new Product();
		Seller seller = new Seller();
		seller.setSid(Long.valueOf("104"));
		product.setSeller(seller);
		
		return "addProduct";
	}
	
	public void testCart(Cart cart){
		Collection<CartItem> items=cart.getCartItems();
		Iterator<CartItem> iterable = items.iterator();
		for (CartItem cartItem : items) {
			System.err.println("yyyyyyyyyyyyyyyyyyyyyyyyyyy");
			System.err.println("yyyyyyyyyyyyyyyyyyyyyyyyyyy");
			System.err.println(cartItem.getProduct().getPname());
			System.err.println(cartItem.getProduct().getPid());
			System.err.println(cartItem.getCount());
			System.err.println(cartItem.getSubtotal());
			System.err.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
			System.err.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
			
		}
	}
	
	
	public static void main(String[] args) {
		
		Product product = new Product();
		product.setPid(new Long(10001));
		product.setPupDate(new Date());
		JSONArray jsonArray = JSONArray.fromObject(product);
		System.out.println(jsonArray.toString());
		
	}
}
