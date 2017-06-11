package com.xianguo.util;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.xianguo.pojo.Product;

public class Cart {

	// ���ﳵ��Ŷ��������:
		// Map��������Ʒ��ID��ΪMap��key , ��������ΪMap��value
		private Map<Long,CartItem> map = new HashMap<Long,CartItem>();
		
		
		// �ṩ���map��value�ļ���:
		// �൱����һ������:cartItems
		public Collection<CartItem> getCartItems(){
			return map.values();
		}
		
		// �ܼ�:
		private Double total = 0d;
		
		public Double getTotal() {
			return total;
		}

		// �ṩ��������:
		// ����������ӵ����ﳵ:
		public void addCart(CartItem cartItem){
			
			
			// ��ù������ʶid
			Long pid = cartItem.getProduct().getPid();
			if(map.containsKey(pid)){
				// ���ﳵ���Ѿ��й�����
				// ���ﳵ���Ѿ��еĹ�������Ϣ
				CartItem _cartItem = map.get(pid);
				_cartItem.setCount(_cartItem.getCount()+cartItem.getCount());
			}else{
				// ���ﳵ�в����ڸù�����
				map.put(pid, cartItem);
			}
			// �ܼ�:
			total += cartItem.getSubtotal();
		}
		
		public void minusCart(CartItem cartItem){
			Long pid = cartItem.getProduct().getPid();
			if (map.containsKey(pid)) {
				CartItem _carItem = map.get(pid);
				_carItem.setCount(_carItem.getCount()-1);
			}
			total -= cartItem.getSubtotal();
		}
		
		
		
		// ��������ӹ��ﳵ���Ƴ�:
		public void removeCart(Long pid){
			// ���������map�������Ƴ�:
			CartItem cartItem = map.remove(pid);
			// �����ܼ�Ǯ�� 
			total -= cartItem.getSubtotal();
		}
		
		// ��չ��ﳵ:
		public void clearCart(){
			// ���map
			map.clear();
			// �ܼ�����Ϊ0
			total = 0d;
		}
		
		public Double allSum(Cart cart) {
			Collection<CartItem> items = cart.getCartItems();
			Double sum = 0d;
			for (CartItem cartItem : items) {
				sum = sum + cartItem.getSubtotal();
			}
			return sum;
		}
		
		public static void main(String[] args) {
			Cart cart = new Cart();
			
			Collection<CartItem> items= cart.getCartItems();
			
			
		}
		
}
