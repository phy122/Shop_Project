<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dto.Ship" %>
<%
    // 데이터베이스 연결을 위한 변수
    String url = "jdbc:mysql://localhost:3306/your_database_name"; // 데이터베이스 URL
    String user = "joeun"; // 사용자명
    String password = "123456"; // 비밀번호

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 요청 파라미터를 가져옵니다
        String cartId = request.getParameter("cartId");
        if (cartId == null || cartId.isEmpty()) {
            out.println("<script>alert('장바구니 ID가 존재하지 않습니다.'); location.href='products.jsp';</script>");
            return; // 실행 중단
        }

        String shipName = request.getParameter("shipName");
        String date = request.getParameter("date");
        String country = request.getParameter("country");
        String zipCode = request.getParameter("zipCode");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Ship 객체 생성
        Ship ship = new Ship();
        ship.setCartId(cartId);
        ship.setShipName(shipName);
        ship.setDate(date);
        ship.setCountry(country);
        ship.setZipCode(zipCode);
        ship.setAddress(address);
        ship.setPhone(phone);

        // SQL 쿼리 준비
        String sql = "INSERT INTO shipping_info (cart_id, ship_name, date, country, zip_code, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, ship.getCartId());
        pstmt.setString(2, ship.getShipName());
        pstmt.setString(3, ship.getDate());
        pstmt.setString(4, ship.getCountry());
        pstmt.setString(5, ship.getZipCode());
        pstmt.setString(6, ship.getAddress());
        pstmt.setString(7, ship.getPhone());

        // 데이터베이스에 INSERT 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('배송 정보가 등록되었습니다.'); location.href='products.jsp';</script>");
        } else {
            out.println("<script>alert('배송 정보 등록에 실패하였습니다.'); location.href='products.jsp';</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); location.href='products.jsp';</script>");
    } finally {
        // 자원 해제
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
