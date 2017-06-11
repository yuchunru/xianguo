<%@page import="com.xianguo.util.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>鲜果网——注册</title>

<link rel="stylesheet"
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css">
<script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>


</head>
<body style="background-color: #BBFFFF">

	<div class="container navbar-fixed-top"
		style="background-color: #EE4000; height: 100px;">

		<div class="row clearfix" style="display: inline; margin: 2em auto;">
			<a
				href="<%=path%>/productAction!showProductByPage?action=initial&pageType=first"><img
				class="img-circle" alt="140x140" src="images/xianguo.jpg"
				style="width: 60px; height: 60px;" /></a>
		</div>
		<div class="col-md-12 column"
			style="width: 70%; height: 60px; padding-left: 40em; margin-top: 8px;">
			<ul class="breadcrumb"
				style="background-color: #EEEE00; width: 12em; text-align: center;">
				<!-- User选项 -->

				<c:if test="${customer!=null}">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">${customer.cusername}<strong
							class="caret"></strong></a>
						<ul class="dropdown-menu">
							<li><a href="#">个人中心</a></li>
							<li><a href="#">我的订单</a></li>
							<li class="divider"></li>
							<li><a href="common/exit_c.jsp">退出</a></li>
						</ul></li>
				</c:if>
				<c:if test="${seller!=null}">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">${seller.susername}<strong
							class="caret"></strong></a>
						<ul class="dropdown-menu">
							<li><a href="#">我的中心</a></li>
							<li><a href="#">我的信息</a></li>
							<li><a href="#">销售情况</a></li>
							<li class="divider"></li>
							<li><a href="common/exit_s.jsp">退出</a></li>
						</ul></li>
				</c:if>
				<c:if test="${seller==null }">
					<c:if test="${customer==null }">
						<li><a href="<%=path%>/visitor/login.jsp">登录</a></li>
						<li><a href="<%=path%>/visitor/register.jsp">注册</a></li>
					</c:if>
				</c:if>
			</ul>
		</div>
		
		
		
		<!-- 头部3-分类 -->
		<div class="row clearfix"
			style="background-color: #fff; margin-top: 0px;">
			<div class="col-md-12 column">
				<ul class="nav nav-tabs" style="font-style: normal">

					<!-- ycy -->
					<li><a
						href="<%=path%>/productAction!showProductByPage?action=initial&pageType=first">首页</a>
					</li>
					<li><a
						href="<%=path%>/productAction!showCategory?pcategory=berry">浆果类</a>
					</li>
					<li><a
						href="<%=path%>/productAction!showCategory?pcategory=coreberry">核果类</a>
					</li>
					<li><a
						href="<%=path%>/productAction!showCategory?pcategory=nut">仁果类</a>
					</li>
					<li><a
						href="<%=path%>/productAction!showCategory?pcategory=melon">瓜类</a>
					</li>

				</ul>
			</div>
		</div>
	</div>

	
	<div class="container"
		style="background-color: #FFF; width: 700; height: 400; margin-top: 200px;">
		<div class="row clearfix">

			<font size="5px" style="margin-left: 360px">订单展示</font>
			<table align="center" width="465" id="tblOrder"
										cellpadding="4" cellspacing="4" bgcolor="black">
				<tr role="presentation" align="center">

					<td width="140">展示</td>
					<td width="140">名称</td>
					<td width="200">单价</td>
					<td width="300">数量</td>

				</tr>

				<c:if test="${!empty oproducts}">
										
					<s:iterator value="#session.oproducts" id="product" status="status">
						<tr role="presentation" align="center" width="840" height="55" id="${product.pid}">
							<td><img alt="" src="${product.ppicLocation}" style="margin-left: 10px;" width="70" height="45"></td>
							<td width="140">${product.pname} </td>
							<td width="200">${product.psellingPrice}元</td>
							<td width="300">
								${product.pnumber}
							</td>
						</tr>
					</s:iterator>
					<tr>
					<td id="totalPrice" width="120" role="presentation" align="center" height="55">
						<font size="5">总价： ${total}元</font> 
					</td>
				</tr>					
				</c:if>
				
			</table>
		</div>
	</div>




</body>
</html>