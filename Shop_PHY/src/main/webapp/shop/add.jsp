<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 목록</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
	<script>
    function checkProduct() {
        var productId = document.product.productId.value;
        var name = document.product.name.value;
        var unitPrice = document.product.unitPrice.value;
        var description = document.product.description.value;
        var manufacturer = document.product.manufacturer.value;
        var category = document.product.category.value;
        var unitsInStock = document.product.unitsInStock.value;
        var condition = document.querySelector('input[name="condition"]:checked');

        var productIdPattern = /^P\d{6}$/;
        
        // 상품 코드 유효성 검사
        if (!productIdPattern.test(productId)) {
            alert("상품 코드는 'P'로 시작하고 숫자 6자리로 입력해야 합니다.");
            document.product.productId.focus();
            return false;
        }

        // 상품명 유효성 검사
        if (!name) {
            alert("상품명을 입력해 주세요.");
            document.product.name.focus();
            return false;
        }

        // 가격 유효성 검사
        if (!unitPrice || unitPrice <= 0) {
            alert("유효한 가격을 입력해 주세요.");
            document.product.unitPrice.focus();
            return false;
        }

        // 상세 정보 유효성 검사
        if (!description) {
            alert("상세 정보를 입력해 주세요.");
            document.product.description.focus();
            return false;
        }

        // 제조사 유효성 검사
        if (!manufacturer) {
            alert("제조사를 입력해 주세요.");
            document.product.manufacturer.focus();
            return false;
        }

        // 분류 유효성 검사
        if (!category) {
            alert("분류를 입력해 주세요.");
            document.product.category.focus();
            return false;
        }

        // 재고 수 유효성 검사
        if (!unitsInStock || unitsInStock < 0) {
            alert("유효한 재고 수를 입력해 주세요.");
            document.product.unitsInStock.focus();
            return false;
        }

        // 상태 유효성 검사
        if (!condition) {
            alert("제품 상태를 선택해 주세요.");
            return false;
        }

        return true;
    }
</script>
	
</head>
<body>
	<% String root = request.getContextPath(); %>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 등록</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	
	<div class="container shop">
		<!-- [NEW] enctype 추가 -->
		<form name="product" action="<%= root %>/shop/add_pro.jsp" onsubmit="return checkProduct()" method="post" enctype="multipart/form-data">
			
			<!-- [NEW] 파일 입력 추가 -->
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-10" name="file">
			</div>	
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 코드</label>
				<input type="text" class="form-control col-md-10" name="productId">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품명</label>
				<input type="text" class="form-control col-md-10" name="name">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">가격</label>
				<input type="number" class="form-control col-md-10" name="unitPrice">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text w-100" id="">상세 정보</label>
				<textarea class="form-control" name="description" style="height: 200px !important;"></textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">제조사</label>
				<input type="text" class="form-control col-md-10" name="manufacturer">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">분류</label>
				<input type="text" class="form-control col-md-10" name="category">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label>
				<input type="number" class="form-control col-md-10" name="unitsInStock">
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
				<input type="submit" class="btn btn-lg btn-primary" value="등록">
			</div>
		
		</form> 
	
	</div>
			
			
			<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>