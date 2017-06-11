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

<script type="text/javascript">
	
	function changeTotal(data){
		var totalPrice = $("#totalPrice");
		//var data=10;
		totalPrice.css("font-size","20px");
		totalPrice.html("总价："+data+"元");
		
	}
	
	function addForPage(data){
		 var shownum = $("tr[id='"+data+"']").find("td:eq(3)").find("input[type='text']");
		 count= parseInt(shownum.attr("value"))+parseInt(1);
		 shownum.attr("value",count);
	}
	
	function add(data){
		addForPage(data)
		 var url = "<%=path%>/productAction!addCart";
		 $.ajax({
			type:'POST',  
			traditional :true, 
		    url:url,
		    data:{"pid":data,"inOrder":"inOrder"},
		    success:function(d){
		    	//var result = eval("("+data+")");
		        //alert("add button success is "+result[0].pname);
		        changeTotal(d);
			}
		 });
		
	}
	//商品数量减1
	function cut(data){
		 var shownum = $("tr[id='"+data+"']").find("td:eq(3)").find("input[type='text']");
		 count= parseInt(shownum.attr("value"))-parseInt(1);
		 if(parseInt(count) > 0){
		 	shownum.attr("value",count);
		 	//*********************************************************8
		 	var url = "<%=path%>/productAction!cutCart";
		 	$.ajax({
		 		type:'POST',
		 		traditional:true,
		 		url:url,
		 		data:{"pid":data},
		 		success:function(data){
		 			//alert("minus success");
		 			changeTotal(data);
		 		}
		 	});
		 	
		 }
		
	}
	//删除某一购物项
	function delCart(data){
		//alert(data);
		alert("删除tr"+($("tr[id='"+data+"']").attr("id")));
		$("tr[id='"+data+"']").remove();
		var url = "<%=path%>/productAction!delCart";
		$.ajax({
			 type:'POST',  
		        traditional :true, 
		        url:url,
		        data:{"pid":data},
		        success:function(d){
		        	//alert("del success");
		        	//alert(d);
		        	changeTotal(d);
		        }
		});
		
	}
	
</script>
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
							<li><a
								href="<%=path%>/customerAction!showUserInfo?cid=${customer.cid}">个人中心</a>
							</li>
							<li><a href="<%=path%>/ordersAction!showOrders">我的订单</a></li>

							<li class="divider"></li>
							<li><a href="common/exit_c.jsp">退出</a></li>
						</ul>
					</li>
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

			<font size="10px">订单提交成功</font>
			
		</div>
	</div>
	



</body>
</html>