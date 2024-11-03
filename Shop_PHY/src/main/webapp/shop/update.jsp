<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String productId = request.getParameter("product_id");
	ProductRepository productRepository = new ProductRepository();
	Product product = productRepository.getProductById(productId);
	pageContext.setAttribute("product", product);
	
	String root = request.getContextPath();  // root 변수를 선언 및 초기화
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 수정</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
	<script>
        // 상태 값에 맞게 체크박스 선택 설정
        function setCondition() {
            const condition = "${product.condition}"; // EL 사용
            document.getElementById("condition-" + condition.toLowerCase()).checked = true;
        }
        // 폼이 로드된 후 상태 값을 설정
        window.onload = setCondition;
    </script>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	
	<div class="container shop">
		<!-- [NEW] enctype 추가 -->
		<form name="product" action="<%= root %>/shop/update_pro.jsp" onsubmit="return checkProduct()" method="post" enctype="multipart/form-data">
			
			<div class="input-group mb-3 row">
				<img src="img?id=${product.file}" class="w-100 p-2">
			</div>
			
				
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-10" name="file" value="${product.file}">
			</div>	
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 코드</label>
				<input type="text" class="form-control col-md-10" name="productId" value="${product.productId}" readonly="">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품명</label>
				<input type="text" class="form-control col-md-10" name="name" value="${product.name}">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">가격</label>
				<input type="number" class="form-control col-md-10" name="unitPrice" value="${product.unitPrice}">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text w-100" id="">상세 정보</label>
				<textarea class="form-control" name="description" style="height: 200px !important;">${product.description}</textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">제조사</label>
				<input type="text" class="form-control col-md-10" name="manufacturer" value="${product.manufacturer}">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">분류</label>
				<input type="text" class="form-control col-md-10" name="category" value="${product.category}">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label>
				<input type="number" class="form-control col-md-10" name="unitsInStock" value="100">
			</div>
			<div class="input-group mb-3 row">
				<div class="col-md-2 p-0">
					<label class="input-group-text" id="">상태</label>
				</div>
				<div class="col-md-10 d-flex align-items-center">
					<div class="radio-box d-flex">
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input" name="condition" value="NEW" id="condition-new"> 
							<label for="condition-new">신규 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input " name="condition" value="OLD" id="condition-old"> 
							<label for="condition-old">중고 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input " name="condition" value="RE" id="condition-re"> 
							<label for="condition-re">재생 제품</label>
						</div>
					</div>
				</div>
			</div>
			
			<div class="d-flex justify-content-between mt-5 mb-5">
				<a href="<%= root %>/shop/products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-success" value="수정">
			</div>
		
		</form> 
	
	</div>
			
			
			<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>