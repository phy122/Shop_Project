<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.MultipartConfig"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.Part"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정 처리</title>
</head>
<body>

<%
    // 파일 저장 경로 지정
    String savePath = application.getRealPath("/img"); // 이미지 파일 저장 경로
    File fileSaveDir = new File(savePath);
    if (!fileSaveDir.exists()) {
        fileSaveDir.mkdirs(); // 디렉토리가 없으면 생성
    }

    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
    String description = request.getParameter("description");
    String manufacturer = request.getParameter("manufacturer");
    String category = request.getParameter("category");
    long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"));
    String condition = request.getParameter("condition");
    String fileName = ""; // 파일 이름 초기화

    // 파일 처리
    if (request.getPart("file") != null) {
        try {
            Part filePart = request.getPart("file");
            fileName = filePart.getSubmittedFileName(); // 업로드된 파일 이름 가져오기
            filePart.write(savePath + File.separator + fileName); // 파일 저장
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    // Product 객체 생성 및 데이터 설정
    Product product = new Product();
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    product.setFile(fileName); // 저장된 파일 경로 설정

    // 상품 정보 업데이트
    ProductRepository productRepository = new ProductRepository();
    int result = productRepository.update(product); // update 메서드를 호출하여 DB에 업데이트

    if (result > 0) {
        out.println("<script>alert('상품이 성공적으로 수정되었습니다.');</script>");
    } else {
        out.println("<script>alert('상품 수정에 실패했습니다.');</script>");
    }
%>
    <a href="products.jsp">상품 목록으로 돌아가기</a>
</body>
</html>
