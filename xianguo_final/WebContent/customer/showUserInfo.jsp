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
							<li><a href="<%=path%>/customerAction!showMyorders">我的订单</a>
							</li>

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
						<li><a href="<%=path%>/visitor/v_register.jsp">注册</a></li>
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
						href="<%=path%>/customerAction!showUserInfo?cid=${cuser.cid}">个人信息</a>
					</li>
					<li><a
						href="<%=path%>/customer/updateUserInfo.jsp">修改信息</a>
					</li>
				<%-- 	<li><a
						href="<%=path%>/customer/updatePassword.jsp">修改密码</a>
					</li>
					 --%>

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
					个人信息<span style="margin-left: 7em;"></span><a
						href="visitor/v_register.jsp"><span style="font-size: 15px"></span></a>
				</h4>
				</p>
				<form class="form-horizontal" role="form" style="margin-top: 2em;"
					method="post">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-3 control-label">昵称：</label>
						<div class="col-sm-7">
							<label for="inputEmail3" class="col-sm-3 control-label">${cuser.cname}</label>
						</div>
						
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">性别：
						</label>
						<div class="col-sm-7">
				
						<c:if test="${cuser.csex=='f' }">
							<label for="inputEmail3" class="col-sm-3 control-label">女</label>
						</c:if>
						<c:if test="${cuser.csex=='m' }">
							<label for="inputEmail3" class="col-sm-3 control-label">男</label>
						</c:if>
						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">生日：
						</label>
						<div class="col-sm-7">
							<label for="inputEmail3" class="col-sm-5 control-label">${cuser.cbirthday}</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">手机号：
						</label>
						<div class="col-sm-7">
							<label for="inputEmail3" class="col-sm-3 control-label">${cuser.cphone}</label>

						</div>
						
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">地址：
						</label>
						<div class="col-sm-7">
							<label for="inputEmail3" class="col-sm-10 control-label">${cuser.getCaddress()}</label>
						</div>
						
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							
							<div class="radio" style="margin-left: 5em;">	
							</div>
						</div>
					</div>
					
				</form>
			</div>

			<!-- 右页框 -->
			<div class="col-md-5 column">
				
				<img alt="chengzi" src="<%=path %>/images/chengzi.jpg" width="292.5"
					height="240" style="margin-top: 3em;">
			</div>
		</div>
	</div>





</body>
</html>