<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String root = request.getContextPath(); %>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
	<script>
		function order() {
			<%
				// 서버 측에서 장바구니 목록이 비어있는지 확인
				boolean isCartEmpty = (session.getAttribute("cartList") == null || ((List<Product>) session.getAttribute("cartList")).isEmpty());
			%>
			if (<%= isCartEmpty %>) {
				alert('장바구니에 담긴 상품이 없습니다.');
			} else {
				// 장바구니에 상품이 있는 경우 배송 정보 페이지로 이동
				window.location.href = "<%= root %>/shop/ship.jsp";
			}
		}
	</script>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	
	<div class="container order">
		<!-- 장바구니 목록 -->
		<table class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					// 세션에서 장바구니 목록을 불러오기
					List<Product> cartList = (List<Product>) session.getAttribute("cartList");
					int totalAmount = 0;
					if (cartList != null && !cartList.isEmpty()) {
						for (Product product : cartList) {
							int subtotal = product.getUnitPrice() * product.getQuantity();
							totalAmount += subtotal;
				%>
				<tr>
					<td><%= product.getName() %></td>
					<td><%= product.getUnitPrice() %> 원</td>
					<td><%= product.getQuantity() %></td>
					<td><%= subtotal %> 원</td>
					<td>
						<a href="<%= root %>/shop/deleteCart.jsp?productId=<%= product.getProductId() %>" class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
				<%
						}
					} else {
				%>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>	
				</tr>
				<%
					}
				%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3">총계</td>
					<td colspan="2"><%= totalAmount %> 원</td>
				</tr>
			</tfoot>
		</table>
	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="<%= root %>/shop/deleteCart.jsp?cartId=<%= session.getId() %>" class="btn btn-lg btn-danger">전체삭제</a>
			<a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
		</div>
	</div>
			
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
