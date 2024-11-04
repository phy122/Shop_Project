<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 장바구니를 가져옴
    session = request.getSession();
    List<Product> cart = (List<Product>) session.getAttribute("cart");

    // 요청 파라미터에서 productId를 가져옴
    String productId = request.getParameter("productId");
    
    // cart가 null이 아니고 비어있지 않을 때
    if (cart != null && !cart.isEmpty() && productId != null) {
        // 해당 상품을 장바구니에서 제거
        cart.removeIf(product -> product.getProductId().equals(productId));
        
        // 장바구니가 비어있으면 세션에서 제거
        if (cart.isEmpty()) {
            session.removeAttribute("cart");
        } else {
            // 장바구니 업데이트
            session.setAttribute("cart", cart);
        }
    }

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>
