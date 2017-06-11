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
<title>鲜果网——登陆</title>
<link rel="stylesheet"
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css">
<script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		var name = $("#name"),pwd=$("#pwd"),sub=$("#sub");
		
		sub.click(function(){
			
			var userType = $("input[name=se]:checked").val();
			$("form").attr("onsubmit","return false");
			if(name.val()==""){
				alert("name not null");
			}else if(pwd.val()==""){
				alert("pwd not null");
			}else{
				if(userType=="Customer"){ 
					var url = "<%=path%>/customerAction!checkUserByAjax";
					$.ajax({
						type:'POST',  
				        traditional :true, 
				        url:url,
				        data:{"name":name.val(),"pwd":pwd.val()},
				        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				        success:function(data){
				        	if(data=="y"){
				        		$("form").attr("onsubmit","return true");
				        		alert("登录成功！欢迎"+name.val()+"用户");
				        		var loginUrl = "<%=path%>/customerAction!login?name="+name.val()+"&pwd="+pwd.val();
				        		alert(loginUrl);
					        	$("form").attr("action",loginUrl);
					    		$("form").submit();
				        	}else{
				        		alert("密码错误，无法登陆");
				        	}
				        }
					});
			
				}else{
					
					var url = "<%=path%>/userAction!checkUserByAjax";
					$.ajax({
						type:'POST',  
				        traditional :true, 
				        url:url,
				        data:{"name":name.val(),"pwd":pwd.val()},
				        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				        success:function(data){
				        	if(data=="y"){
				        		$("form").attr("onsubmit","return true");
				        		alert("登录成功！欢迎"+name.val()+"用户");
				        		var loginUrl = "<%=path%>/userAction!login?name="+name.val()+"&pwd="+pwd.val();
				        		alert(loginUrl);
					        	$("form").attr("action",loginUrl);
					    		$("form").submit();
				        	}else{
				        		alert("密码错误，无法登陆");
				        	}
				        }
					});
					
				}
			}
		});
		
	});
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
							<li><a href="#">我的订单</a></li>
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
		style="margin-top: 200px; background-color: #FFF; width: 800px; height: 370px">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<form class="form-horizontal" role="form" style="margin-top: 30px;">
					<p style="margin-top: 2em;">
					<h4 style="margin-left: 45px; margin-bottom: 30px;">
						会员登录<span style="margin-left: 7em;"></span><a
							href="<%=path %>/visitor/register.jsp"><span style="font-size: 15px">去注册？</span></a>
					</h4>
					</p>


					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="name" name="name"
								placeholder="请输入名字">
						</div>
					</div>


					<div class="form-group">
						<label for="lastname" class="col-sm-2 control-label">密<span
							style="margin-right: 1em;"></span>码
						</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" id="pwd" name="pwd"
								placeholder="请输入密码">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<p>选择登录身份：</p>
							<div class="radio" style="margin-left: 5em;">
								<label><input name=se type="radio" value="Customer"
									checked="checked" />用户 </label> <span style="margin-right: 1em"></span>
								<label><input name=se type="radio" value="Seller" />商家
								</label>
							</div>
							<span style="margin-right: 9em;"></span><a
								href="visitor/forgetpassword.jsp">忘记密码？</a>
						</div>
					</div>



					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10" style="width: 15em;">
							<button id="sub" type="submit"
								class="btn btn-block btn-lg btn-info">
								登<span style="margin-right: 1em;"></span>录
							</button>
						</div>
					</div>
					
					
			


				</form>
			</div>
			
			
		</div>
	</div>




</body>
</html>