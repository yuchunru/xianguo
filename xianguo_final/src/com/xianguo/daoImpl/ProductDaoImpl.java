package com.xianguo.daoImpl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.xianguo.dao.ProductDao;
import com.xianguo.pojo.Product;
import com.xianguo.util.PageUtil;

public class ProductDaoImpl implements ProductDao {

	HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	@Override
	public List<Product> showProductByPage(PageUtil pageUtil) {
		// TODO Auto-generated method stub
		String sql = "from Product";
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Query query = session.createQuery(sql);
		query.setFirstResult(pageUtil.getFirstRow());
		query.setMaxResults(pageUtil.getMaxSize());
		List<Product> products = (List<Product>) query.list();
		session.close();
		return products;
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		List product = hibernateTemplate.find("select count(*) from Product");
		return Integer.parseInt(String.valueOf(product.get(0)));
	}

	@Override
	public List<Product> showCategory(String pcategory) {
		// TODO Auto-generated method stub
		Session session = hibernateTemplate.getSessionFactory().openSession();
		String sql ="from Product where pcategory = ?";
		Query query = session.createQuery(sql);
		query.setString(0, pcategory);
		List<Product> products = (List<Product>)query.list();
		session.close();
		return products;
	}

	@Override
	public Product getProductByPid(Long pid) {
		// TODO Auto-generated method stub
		Product product = hibernateTemplate.get(Product.class, pid);
		return product;
	}

	@Override
	public void delProduct(Long pid) {
		// TODO Auto-generated method stub
		
		hibernateTemplate.delete(getProductByPid(pid));
	}

	@Override
	public List<Product> getProducts() {
		// TODO Auto-generated method stub
		Session session = hibernateTemplate.getSessionFactory().openSession();
		String sql ="from Product";
		Query query = session.createQuery(sql);
		
		List<Product> products = (List<Product>)query.list();
		session.close();
		return products;
	
	}

}
