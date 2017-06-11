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
			pcategory = "������";
		} else if ("coreberry".equals(pcategory)) {
			pcategory = "�˹���";
		} else if ("nut".equals(pcategory)) {
			pcategory = "�ʹ���";
		} else {
			pcategory = "����";
		}
		List<Product> products = productServiceImpl.showCategory(pcategory);
		ActionContext context = ActionContext.getContext();
		if (products != null) {
			context.put("products", products);
		}

		return "showCategory";
	}
	
	//��Ӧҳ�����ӹ��ﳵ
	public void addCart() throws IOException{
		ServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
//		System.err.println(pid);
		Product product = productServiceImpl.getProductByPid(Long.valueOf(pid));
		
		String inOrder = request.getParameter("inOrder");

		//���ﳵ���
		updateCart(product, 1,inOrder,writer);
		
		writer.flush();
		writer.close();
	}
	
	
	/**
	 * ��session��Χ��ù��ﳵ�Ĵ���
	 */
	public Cart getCart(HttpServletRequest request) {
		// ��session�ķ�Χ���Cart����.
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		// �ж�:
		if (cart == null) {
			// �������ﳵ����
			cart = new Cart();
			// �����ﳵ������뵽session��Χ:
			request.getSession().setAttribute("cart", cart);
		}
		return cart;
	}

	/**
	 * ��ӵ����ﳵ�ķ���:
	 */
	public String updateCart(Product product, Integer count, String inOrder,
			PrintWriter writer) {

		// ��ѯ��Ʒ��Ϣ:
		// Product product = productServiceImpl.getProductByPid(pid);
		// ����һ�����������:
		CartItem cartItem = new CartItem();
		cartItem.setCount(count);
		cartItem.setProduct(product);
		// ��ȡ���ﳵ ��Ҫ����request����
		HttpServletRequest request = ServletActionContext.getRequest();
		Cart cart = getCart(request);
		cart.addCart(cartItem);
		testCart(cart);
		if (inOrder == null) {
			// Ϊ����ǰ̨��������
			Product p = new Product();
			p.setPid(product.getPid());
			p.setPname(product.getPname());
			p.setPsellingPrice(product.getPsellingPrice());
			p.setPpicLocation(product.getPpicLocation());
			p.setPnumber(product.getPnumber());

			// ����ȡ�����ഫ��ǰ̨
			JSONArray jsonArray = JSONArray.fromObject(p);
			System.out.println(jsonArray);
			writer.print(jsonArray.toString());
		} else {
			writer.print(cart.allSum(cart));
		}
		return "addCartSuccess";
	}
	
	
	//��Ӧҳ��ļ���
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
	
	//��Ӧҳ���ɾ��
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
