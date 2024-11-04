<%@page import="java.util.List"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dto.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 페이지</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
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
                    User user = (User) session.getAttribute("loginUser");
                    List<Product> cart = (List<Product>) session.getAttribute("cart");
                    String cartId = user != null ? user.getId() : "guest";
                    int totalPrice = 0; // totalPrice 변수를 선언하고 초기화

                    if (cart != null && !cart.isEmpty()) {
                        for (Product product : cart) {
                %>
                            <tr>
                                <td><%= product.getName() %></td>            
                                <td><%= product.getUnitPrice() %></td>            
                                <td><%= product.getQuantity() %></td>
                                <td><%= product.getUnitPrice() * product.getQuantity() %></td>
                                <td>
                                    <button type="button" class="btn btn-primary deletebtn" 
                                            onclick="deleteFromCart('<%= product.getProductId() %>')">삭제</button>
                                </td>
                            </tr>
                <% 
                            totalPrice += product.getUnitPrice() * product.getQuantity(); // 소계를 총액에 더함
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" style="text-align: center;">등록된 상품이 없습니다.</td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3">총액</td>
                    <td><%= totalPrice %></td> <!-- totalPrice를 출력 -->
                    <td></td>
                </tr>
            </tfoot>
        </table>
        
        <div class="d-flex justify-content-between align-items-center p-3">
            <a href="deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-lg btn-danger">전체삭제</a>
            <button type="button" class="btn btn-lg btn-primary" onclick="order()">주문하기</button>
        </div>
    </div>
    
<footer class="container p-5">
    <p>copyright Shop</p>
</footer>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script>
    function order() {
        const cartCount = <%= (cart != null ? cart.size() : 0) %>;

        if (cartCount === 0) {
            alert('장바구니에 담긴 상품이 없습니다.');
            return;
        }

        window.location.href = 'ship.jsp?cartId=<%= cartId %>'; // 배송정보 페이지로 이동
    }
    
    function deleteFromCart(productId) {
        const isConfirmed = confirm("이 상품을 장바구니에서 삭제하시겠습니까?");
        
        if (isConfirmed) {
            const form = document.createElement("form");
            form.method = "post";
            form.action = "deleteCart.jsp";
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "productId";
            input.value = productId;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

<style>
    .deletebtn {
        background-color: rgb(236, 48, 48);
        border: 1px solid rgb(236, 48, 48);
    }
    .deletebtn:hover,
    .deletebtn:active {
        background-color: rgb(192, 36, 36) !important;
        border: 1px solid rgb(192, 36, 36) !important;
    }
</style>
</body>
</html>
