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
	$(document).ready(function () {
		var u=$("#user"),p=$("#pwd"),rep=$("#repwd"),ulb=$("#userlabel"),plb=$("#pwdlabel"),replb=$("#repwdlabel"),sub=$("#sub");
		var ubool=false,pbool=false,repbool=false;
		sub.click(function () {
			id=$("input[name=se]:checked").val();
			ubool=false;
			pbool=false;
			repbool=false;
			$("form").attr("onsubmit","return false");
			ulb.text("");
			plb.text("");
			replb.text("");
			var regex = /^[^0-9]*[a-z0-9_]*$/ ;
			var ret = regex.test(u.val());
			if(1){
				if(u.val()==""){
					u.css("border-color", "red");
					ulb.text("用户名不能为空");
				}else if (u.val().length<3) {
						u.css("border-color", "red");
						ulb.text("用户名必须不少于3位");
		        }else if (ret == false) {
					u.css("border-color", "red");
					//ulb.text("只能为数字、字母、下划线,不以数字开头");
		        }else{
		        		u.css("border-color", "");
		            	ubool=true;
		        }
					
			}
			if(1){
				if(p.val()==""){
					p.css("border-color", "red");
					plb.text("密码不能为空");
				}else if (p.val().length<6) {
					p.css("border-color", "red");
					plb.text("密码必须不少于6位");
				}else {
					p.css("border-color", "");
					pbool=true;
				}
			}
			if(1){
				if(rep.val()==""){
					rep.css("border-color", "red");
					replb.text("确认密码不能为空");
				}else if(rep.val()!=p.val()){
					rep.css("border-color", "red");
					replb.text("两次密码不一致");
				}else{
					rep.css("border-color", "");
					repbool=true;
				}
			}
			if(1){
				if(!(ubool&&pbool&&repbool)){
					return false;
				}else if(id=="Customer"){
					u.attr("name","cusername");
					p.attr("name","cpwd");
					
					$("form").attr("onsubmit","return true");
					alert("注册成功！去登录");
					$("form").attr("method","post");
		        	$("form").attr("action","<%=path%>/customerAction!register");
		    		$("form").submit(); 
		    		
					
				}else{
					/* u.attr("name","susername");
					p.attr("name","spwd");
					$("form").attr("onsubmit","return true");
					$("form").attr("method","post");
		        	$("form").attr("action","Visitor/CheckRegister_Seller");
		    		$("form").submit(); */
		    		
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

			<!-- 左页框 -->
			<div class="col-md-6 column" style="margin-left: 1em;">
				<p style="margin-top: 2em;">
				<h4>
					用户注册<span style="margin-left: 7em;"></span><a
						href="<%=path %>/visitor/login.jsp"><span style="font-size: 15px">去登录？</span></a>
				</h4>
				</p>
				<form class="form-horizontal" role="form" style="margin-top: 2em;">
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-3 control-label">用户名</label>
						<div class="col-sm-7">
							<input class="form-control" id="user" type="text" name="user" />
						</div>
						<label id="userlabel" for="inputPassword3"
							class="col-sm-15 control-label"
							style="margin-left: 6em; height: 1em; color: red;"></label>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">密<span
							style="margin-right: 1em;"></span>码
						</label>
						<div class="col-sm-7">
							<input class="form-control" id="pwd" type="password" name="pwd" />
						</div>
						<label id="pwdlabel" for="inputPassword3"
							class="col-sm-7 control-label"
							style="margin-left: 1em; height: 1em; color: red;"></label>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-3 control-label">确认密码</label>
						<div class="col-sm-7">
							<input class="form-control" id="repwd" type="password"
								name="repwd" />
						</div>
						<label id="repwdlabel" for="inputPassword3"
							class="col-sm-7 control-label"
							style="margin-left: 1em; height: 1em; color: red;"></label>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<p>选择注册身份：</p>
							<div class="radio" style="margin-left: 5em;">
								<label><input name="se" type="radio" value="Customer"
									checked="checked" />用户 </label> <span style="margin-right: 1em;"></span>
								<label><input name="se" type="radio" value="Seller" />商家
								</label>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-left: 1em;">
						<div class="col-sm-offset-2 col-sm-10" style="width: 15em;">
							<button id="sub" type="submit"
								class="btn btn-block btn-lg btn-info">
								注<span style="margin-right: 1em;"></span>册
							</button>
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