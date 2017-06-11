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
<title>鲜果网——商品信息</title>



<link rel="stylesheet"
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css">
<script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function buy(id){
		alert("product id is "+id);
		var url = "<%=path%>/productAction!addCart";
		$.ajax({
			type:'POST',  
	        traditional :true, 
	        url:url,
	        data:{"pid":id},
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        success:function(data){
	        	var result = eval("("+data+")");
	        	alert("product name is "+result[0].pname);
	        	
	        	var inCart = false;
	        	//判断这一项是否已经在购物车中
	        	$("#tblOrder tr").each(function(){
	    			if($(this).attr("id")!=null){
	    				//alert($(this).attr("id"));
	    				if($(this).attr("id")==id)
	    					inCart = true;
	    			}
	    		});
	        	
	        	if(!inCart){//未在购物车中
	        		var tb = $("#tblOrder");
		    		var tr = $("<tr></tr>");    		
		    		//给这一行加上id
		    		tr.attr("id",id);
		    		//给这一行的所有列配置对应的项
		    		for(var i=0;i<5;i++){
		    			var td = $("<td></td>");
		    			if(i==0){
		    				var img = $("<img></img>");
		    				img.attr("src",result[0].ppicLocation);
		    				img.css("width","70px");
		    				img.css("height","45px");
		    				img.css("margin-left","10px");
		    				td.append(img);
		    				
		    			}
		    			if(i==1){
		    				td.text(result[0].pname);
		    				td.css("padding-left","20px");
		    			}
		    			
		    			if(i==2){
		    				td.text(result[0].psellingPrice+"元");
		    				td.css("padding-left","20px");
		    			}
		    			if(i==3){
		    				
		    				var minusbtn=$("<input type='button' value='-' onclick='cut(id)'>");
		    				minusbtn.attr("id",id);
		    				//minusbtn.css("height","20px");
		    				minusbtn.css("text-align","center");
		    				minusbtn.css("width","20px");
		    				//minusbtn.css("margin-right","-15px");
		    				td.append(minusbtn);
		    				
		    				var numbtn = $("<input type='text' value='1'>");
		    				//numbtn.css("height","20px");
		    				numbtn.css("width","20px");
		    				//numbtn.css("margin-left","20px");
		    				numbtn.css("text-align","center");
		    				td.append(numbtn);
		    				
		    				
		    				var plusbtn = $("<input type='button' value='+' onclick='add(id)'>");
		    				plusbtn.attr("id",id);
		    				//plusbtn.css("height","20px");
		    				plusbtn.css("width","20px");
		    				plusbtn.css("text-align","center");
		    				//plusbtn.css("margin-left","10px");
		    				td.append(plusbtn);
		    			}
		    			if(i==4){
		    				
		    				var btn=$("<input type='button' value='删除' onclick='delCart(id)'>");
		    				btn.attr("id",id);
		    				btn.css("margin-left","18px");
		    				td.append(btn);
		    			}
		    			tr.append(td);
		    		}
		    		tb.append(tr);
		    		
	        	}else{//在购物车中
	        		addForPage(id);	
	        	}
	        }
		});
			
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
		    data:{"pid":data},
		    success:function(data){
		    	var result = eval("("+data+")");
		        alert("add button success is "+result[0].pname);
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
		 			alert("minus success");
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
		        success:function(data){
		        	alert("del success");
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
							<li><a href="#">个人中心</a></li>
							<li> <a href="<%=path%>/ordersAction!showOrders">我的订单</a></li>
							<li><a href="#">我的信息</a></li>
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
						<li><a href="<%=path%>/visitor/v_register.jsp">注册</a></li>
					</c:if>
				</c:if>
			</ul>
		</div>
		
		<!-- 购物车点击效果 -->
	<div class="dropdown" style="float: left;width: 44px;height: 44px;">
		<a type="button" id="dropdownMenu1" data-toggle="dropdown">
			<img class="img-circle" alt="140x140" src="images/gwc.jpg" 
											style="float: left;margin-left: 18em;width: 44px;height: 44px;"/></a>
									
		<table class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" align="center" width="465" id="tblOrder"
										cellpadding="4" cellspacing="4" bgcolor="black">
				<tr role="presentation" align="center">

					<td width="140">展示</td>
					<td width="140">名称</td>
					<td width="200">单价</td>
					<td width="300">数量</td>
					<td width="120">删除</td>
					<td width="120"><c:if test="${customer!=null}">
							<a class="btn btn-default btn-primary"
								href="<%=path%>/customer/order.jsp">一键购买</a>
						</c:if> <c:if test="${customer==null}">
							<a class="btn btn-default btn-primary"
								href="<%=path%>/visitor/login.jsp">一键购买</a>
						</c:if></td>
				</tr>
				
				<c:if test="${!empty cart}">
										
					<s:iterator value="#session.cart.getCartItems()" id="cartList">
						<tr role="presentation" align="center" width="840" height="55" id="${cartList.getProduct().pid}">
							<td><img alt="" src="${cartList.getProduct().ppicLocation}" style="margin-left: 10px;" width="70" height="45"></td>
							<td width="140">${cartList.getProduct().pname} </td>
							<td width="200">${cartList.getProduct().psellingPrice}元</td>
							<td width="300">
											
								<input type="button" name='btnCut' style="width: 20px; text-align: center" value="-" id="${cartList.getProduct().pid}" onclick='cut(id)'/>
								<input type="text" name="txtNum" style="width: 20px;" value="${cartList.getCount()}" /> 
								<input type="button" name='btnAdd' style="width: 20px; text-align: center" value="+" id="${cartList.getProduct().pid}" onclick='add(id)'/>
							</td>
							<td width="120">
								<input type="button" name="btnDel" value="删除" id="${cartList.getProduct().pid}" onclick='delCart(id)'>
							</td>
							<td width="120"></td>
						</tr>
					</s:iterator>
										
				</c:if>
									
		</table>
								
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

	<!-- 登录页框 -->
	<div class="container"
		style="background-color: #FFF; width: 700; height: 370; margin-top: 200px;">
		<div class="row clearfix">

			<!-- 左页框 -->
			<div class="col-md-6 column" style="margin-left: 1em;">
				<p style="margin-top: 2em;">
				<h4>
					商品详细信息<span style="margin-left: 7em;"></span><a
						href="visitor/v_register.jsp"><span style="font-size: 15px"></span></a>
				</h4>
				</p>
				<form class="form-horizontal" role="form" style="margin-top: 2em;"
					method="post">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-3 control-label">商品名称</label>
						<div class="col-sm-7">
							<label for="inputEmail3" class="col-sm-3 control-label">${SelProduct.pname}</label>
						</div>
						
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">商品类别
						</label>
						<div class="col-sm-7">
							<!-- <input class="form-control" id="pwd" type="password" name="pwd" /> -->
							<label for="inputEmail3" class="col-sm-3 control-label">&nbsp;${SelProduct.pcategory}</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">商品描述
						</label>
						<div class="col-sm-7">
							<!-- <input class="form-control" id="pwd" type="password" name="pwd" /> -->
							<label for="inputEmail3" class="col-sm-4 control-label">${SelProduct.pdescription}</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">商品产地
						</label>
						<div class="col-sm-7">
							<!-- <input class="form-control" id="pwd" type="password" name="pwd" /> -->
							<label for="inputEmail3" class="col-sm-3 control-label">${SelProduct.pproducePlace}</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">商品单价
						</label>
						<div class="col-sm-7">
							<!-- <input class="form-control" id="pwd" type="password" name="pwd" /> -->
							<label for="inputEmail3" class="col-sm-4 control-label">${SelProduct.psellingPrice}元</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							
							<div class="radio" style="margin-left: 5em;">	
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-left: 1em;">
						<div class="col-sm-offset-2 col-sm-10" style="width: 15em;">
							<%-- <button id="sub" type="button"
								class="btn btn-block btn-lg btn-info" onclick="buy(${SelProduct.pid})">
								加入购物车
							</button> --%>
							<a class="btn btn-default btn-lg btn-info" onclick="buy(${SelProduct.pid})">加入购物车</a>
							<c:if test="${customer!=null}">
								<a class="btn btn-default btn-lg btn-info" href="<%=path%>/customer/order.jsp">一键购买<span style="margin-right: 1em;"></span></a>
							</c:if>
							<c:if test="${customer==null}">
								<a class="btn btn-default btn-lg btn-info" href="<%=path%>/visitor/login.jsp">一键购买<span style="margin-right: 1em;"></span></a>
							</c:if>
						</div>
					</div>
				</form>
			</div>

			<!-- 右页框 -->
			<div class="col-md-5 column">
				
				<img alt="chengzi" src="${SelProduct.ppicLocation }" width="292.5"
					height="240" style="margin-top: 3em;">
			</div>
		</div>
	</div>





</body>
</html>