<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	ProductRepository productRepository = new ProductRepository();
	List<Product> Productlist = productRepository.list();
	pageContext.setAttribute("Productlist", Productlist);
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 목록</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<% String root = request.getContextPath(); %>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 목록</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			
				<a href="<%= root %>/shop/add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
				<a href="<%= root %>/shop/editProducts.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 편집</a>
				<a href="<%= root %>/shop/cart.jsp" class="btn btn-warning btn-lg px-4 gap-3">장바구니</a>
				
			</div>
		</div>
	</div>
	
	
	
	<div class="container mb-5">
		<div class="row gy-4">
				<c:forEach items="${Productlist}" var="product">
				<div class="col-md-6 col-xl-4 col-xxl-3">
					<div class="card p-3">
							<div class="img-content">
							    <img src="${product.file}" class="w-100 p-2" alt="${product.name}">
							</div>
				            <h3 class="text-center" style="font-size: 20px;">${product.name}</h3>
				            <p style="font-size: 15px;">${product.description}</p>
				            <p class="text-end price">${product.unitPrice} 원</p>
				            <p class="d-flex justify-content-between">
								<a href="<%= root %>/shop/cart_pro.jsp?id=${product.productId}" class="btn btn-outline-primary">
									<i class="material-symbols-outlined">shopping_bag</i>
								</a>
								<a href="<%= root %>/shop/product.jsp?product_id=${product.productId}" class="btn btn-outline-primary">상세 정보</a>
							</p>
					</div>
				</div>
				    	</c:forEach>
			</div>
		</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>