<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");

    OrderRepository orderRepository = new OrderRepository();
    List<Product> orderList = orderRepository.list(phone, orderPw);

    if (orderList != null && !orderList.isEmpty()) {
        session.setAttribute("orderList", orderList);
        response.sendRedirect(root + "/user/order.jsp");
    } else {
        // 조회 실패 시 에러 메시지를 전달하고 다시 조회 페이지로 이동
        session.setAttribute("errorMessage", "일치하는 주문 내역이 없습니다.");
        response.sendRedirect(root + "/user/order.jsp");
    }
%>