package com.xianguo.pojo;

// Generated 2016-12-7 18:09:26 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Customer generated by hbm2java
 */
public class Customer implements java.io.Serializable {

	private Long cid;
	private String cusername;
	private String cpwd;
	private String cpwdProtection;
	private String cpwdAnswer;
	private String cname;
	private String csex;
	private Date cbirthday;
	private String cphone;
	private String cmail;
	private String caddress;
	private Date cregistrationDate;
	private Long cinUse;
	private Set<Orders> orderses = new HashSet<Orders>(0);

	public Customer() {
	}

	public Customer(String cusername, String cpwd, String cpwdProtection,
			String cpwdAnswer, String cname, String csex, Date cbirthday,
			String cphone, String cmail, String caddress,
			Date cregistrationDate, Long cinUse, Set<Orders> orderses) {
		this.cusername = cusername;
		this.cpwd = cpwd;
		this.cpwdProtection = cpwdProtection;
		this.cpwdAnswer = cpwdAnswer;
		this.cname = cname;
		this.csex = csex;
		this.cbirthday = cbirthday;
		this.cphone = cphone;
		this.cmail = cmail;
		this.caddress = caddress;
		this.cregistrationDate = cregistrationDate;
		this.cinUse = cinUse;
		this.orderses = orderses;
	}

	public Long getCid() {
		return this.cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	public String getCpwd() {
		return this.cpwd;
	}

	public void setCpwd(String cpwd) {
		this.cpwd = cpwd;
	}

	public String getCpwdProtection() {
		return this.cpwdProtection;
	}

	public void setCpwdProtection(String cpwdProtection) {
		this.cpwdProtection = cpwdProtection;
	}

	public String getCpwdAnswer() {
		return this.cpwdAnswer;
	}

	public void setCpwdAnswer(String cpwdAnswer) {
		this.cpwdAnswer = cpwdAnswer;
	}

	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCsex() {
		return this.csex;
	}

	public void setCsex(String csex) {
		this.csex = csex;
	}

	public Date getCbirthday() {
		return this.cbirthday;
	}

	public void setCbirthday(Date cbirthday) {
		this.cbirthday = cbirthday;
	}

	public String getCphone() {
		return this.cphone;
	}

	public void setCphone(String cphone) {
		this.cphone = cphone;
	}

	public String getCmail() {
		return this.cmail;
	}

	public void setCmail(String cmail) {
		this.cmail = cmail;
	}

	public String getCaddress() {
		return this.caddress;
	}

	public void setCaddress(String caddress) {
		this.caddress = caddress;
	}

	public Date getCregistrationDate() {
		return this.cregistrationDate;
	}

	public void setCregistrationDate(Date cregistrationDate) {
		this.cregistrationDate = cregistrationDate;
	}

	public Long getCinUse() {
		return this.cinUse;
	}

	public void setCinUse(Long cinUse) {
		this.cinUse = cinUse;
	}

	public Set<Orders> getOrderses() {
		return this.orderses;
	}

	public void setOrderses(Set<Orders> orderses) {
		this.orderses = orderses;
	}

}
