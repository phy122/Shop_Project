<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // 요청 파라미터로 전달받은 productId
    String productId = request.getParameter("id");

    if (productId != null && !productId.isEmpty()) {
        // ProductRepository 인스턴스 생성
        ProductRepository productRepository = new ProductRepository();

        // 상품 삭제 메서드 호출
        productRepository.delete(productId);
    }

    // 삭제 후 상품 목록 페이지로 리디렉션
    response.sendRedirect(request.getContextPath() + "/shop/editProducts.jsp");
%>