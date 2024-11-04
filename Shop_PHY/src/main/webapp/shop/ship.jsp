<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dto.Ship"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 정보</title>
    <jsp:include page="/layout/meta.jsp" /> 
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <% String root = request.getContextPath(); %>
    <jsp:include page="/layout/header.jsp" />
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
    </div>
    
    <div class="container shop mb-5 p-4">
        <form action="<%= root %>/shop/ship_pro.jsp" class="form-horizontal" method="post">
            <input type="hidden" name="cartId" value="<%= session.getAttribute("cartId") != null ? session.getAttribute("cartId") : "guest" %>">
            
            <% User user = (User) session.getAttribute("user"); %>
            
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">성명</label>
                <input type="text" class="form-control col-md-10" name="shipName" 
                       value="<%= user != null ? user.getName() : "" %>" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">배송일</label>
                <input type="date" class="form-control col-md-10" name="date" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">국가명</label>
                <input type="text" class="form-control col-md-10" name="country" 
                       value="<%= user != null ? user.getAddress() : "" %>" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">우편번호</label>
                <input type="text" class="form-control col-md-10" name="zipCode" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">주소</label>
                <input type="text" class="form-control col-md-10" name="address" 
                       value="<%= user != null ? user.getAddress() : "" %>" required>
            </div>
            <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2" id="">전화번호</label>
                <input type="text" class="form-control col-md-10" name="phone" 
                       value="<%= user != null ? user.getPhone() : "" %>" required>
            </div>
            
            <!-- 버튼 영역 -->
            <div class="d-flex justify-content-between mt-5 mb-5">
                <div class="item">
                    <a href="<%= root %>/shop/cart.jsp" class="btn btn-lg btn-success">이전</a>
                    <a href="<%= root %>/" class="btn btn-lg btn-danger">취소</a>                
                </div>
                <div class="item">
                    <input type="submit" class="btn btn-lg btn-primary" value="등록">
                </div>
            </div>
        </form>
    </div>
        
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
