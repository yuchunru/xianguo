<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>鲜果网——首 页</title>

<link rel="stylesheet"
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css">
<script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #BBFFFF">


	<%-- 	<a href="<%=path%>/userAction!addUser?user.username=hibernate&user.email=hibernate">hibernate</a>
 --%>
	<%-- 	<a href="<%=path%>/productAction!showProductByPage">hibernate</a>
 --%>
 <div class="container navbar-fixed-top"  style="background-color: #EE4000;height: 100px;">
 
 	<div class="row clearfix" style="display: inline;margin: 2em auto;">
 		<a href="<%=path %>/productAction!showProductByPage?action=initial&pageType=first"><img class="img-circle" alt="140x140" src="images/xianguo.jpg" style="width: 60px;height: 60px;"/></a>
 	</div>
 	<div class="col-md-12 column" style="width: 70%;height: 60px;padding-left: 40em;margin-top: 8px;">
			<ul class="breadcrumb" style="background-color: #EEEE00;width: 12em;text-align: center;">
				<!-- User选项 -->
				
				<c:if test="${customer!=null}">
				<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">${customer.cusername}<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="#">个人中心</a>
								</li>
								<li>
									 <a href="#">我的订单</a>
								</li>
								<li>
									 <a href="#">我的信息</a>
								</li>
								<li class="divider">
								</li>
								<li>
									 <a href="common/exit_c.jsp">退出</a>
								</li>
							</ul>
				</li>
				</c:if>
				<c:if test="${seller!=null}">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">${seller.susername}<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									 <a href="#">我的中心</a>
								</li>
								<li>
									 <a href="#">我的信息</a>
								</li>
								<li>
									 <a href="#">销售情况</a>
								</li>
								<li class="divider">
								</li>
								<li>
									 <a href="common/exit_s.jsp">退出</a>
								</li>
							</ul>
				</li>
				</c:if>
				<c:if test="${seller==null }">
					<c:if test="${customer==null }">
					<li>
					 	<a href="visitor/v_login.jsp">登录</a>
					</li>
					<li>
					 	<a href="visitor/v_register.jsp">注册</a>
					</li>
					</c:if>
				</c:if>
			</ul>
	</div>
	<!-- 头部3-分类 -->
	<div class="row clearfix" style="background-color: #fff;margin-top: 0px;">
		<div class="col-md-12 column">
			<ul class="nav nav-tabs" style="font-style: normal">
				
				<!-- ycy -->
				<li>
					<a href="<%=path %>/productAction!showProductByPage?action=initial&pageType=first">首页</a>
				</li>
				<li>
					<a href="<%=path %>/productAction!showCategory?pcategory=berry">浆果类</a>
				</li>
				<li>
					<a href="<%=path %>/productAction!showCategory?pcategory=coreberry">核果类</a>
				</li>
				<li>
					<a href="<%=path %>/productAction!showCategory?pcategory=nut">仁果类</a>
				</li>
				<li>
					<a href="<%=path %>/productAction!showCategory?pcategory=melon">瓜类</a>
				</li>
				
			</ul>
		</div>
	</div>
	</div>
	<!-- 商品展示 -->
	<div class="container" style="margin-top: 100px;">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row">

					<!-- ycy -->
					<c:forEach items="${products}" var="product">

						<div class="col-md-3">
							<div class="thumbnail">
								<div class="caption" id="${product.pid }">
									<a href="Visitor/showProductInfo/${product.pid}">
										<div>
											<img alt="" src="${product.ppicLocation}" width="100%"
												height="185">
										</div>
									</a>

									<p>
										<a href="Visitor/showProductInfo/${product.pid}"><span
											style="color: black;">${product.pname}</span></a><br> <br>
										<a
											style="text-decoration: none; font-size: 20px; color: #de0801;">￥${product.psellingPrice}/kg</a>
										<a type="button" name="btnBuy" onclick="buy(${product.pid })"
											class="btn btn-primary" style="margin-left: 3em;">购物车</a>

									</p>
								</div>
							</div>
						</div>

					</c:forEach>

				</div>
			</div>
		</div>
	</div>
	<!-- 分页表单 -->
	<%-- <div class="container">
	<table align="left" cellSpacing=0 cellPadding=0 border="0" width="80%" style="margin-left: -16%;font-style: normal;">
		<tr>
			<td height="25"></td>
		</tr>
		<tr>
			<td align="right">第<c:out value="${pageBean.currentPage}"></c:out>页/共<c:out
					value="${pageBean.totalPages}"></c:out>页 &nbsp;&nbsp; 每页<c:out
					value="${pageBean.maxSize}"></c:out>行/共<c:out
					value="${pageBean.totalRows}"></c:out>行 &nbsp;&nbsp; 
					
				<c:choose>
					<c:when test="${pageBean.currentPage==1}">				
								首页&nbsp;上页&nbsp;
							</c:when>
					<c:otherwise>
						<a
							class="btn btn-default btn-primary"
							href="<%=path%>/productAction!showProductByPage?action=page&pageType=first">首页</a>&nbsp;<a
							class="btn btn-default btn-primary"
							href="<%=path%>/productAction!showProductByPage?action=page&pageType=previous">上页</a>&nbsp;
							</c:otherwise>
				</c:choose> 
				
				<c:choose>
					<c:when test="${pageBean.currentPage==pageBean.totalPages}">
								下页&nbsp;尾页&nbsp;
							</c:when>
					<c:otherwise>
						<a
							class="btn btn-default btn-primary"
							href="<%=path%>/productAction!showProductByPage?action=page&pageType=next">下页</a>&nbsp;<a
							class="btn btn-default btn-primary"
							href="<%=path%>/productAction!showProductByPage?action=page&pageType=last">尾页</a>&nbsp;
							</c:otherwise>
				</c:choose> &nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	</div> --%>



</body>
</html>