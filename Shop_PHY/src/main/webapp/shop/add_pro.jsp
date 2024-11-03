<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository"%>
<%@ page import="shop.dto.Product"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 가져오기
    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
    String description = request.getParameter("description");
    String manufacturer = request.getParameter("manufacturer");
    String category = request.getParameter("category");
    long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"));
    String condition = request.getParameter("condition");

    // 파일 저장 경로 지정 및 파일 처리
    String savePath = application.getRealPath("/uploads");
    File fileSaveDir = new File(savePath);
    if (!fileSaveDir.exists()) {
        fileSaveDir.mkdirs();
    }

    String fileName = "";
    if (request.getPart("file") != null) {
        try {
            Part filePart = request.getPart("file");
            fileName = filePart.getSubmittedFileName();
            filePart.write(savePath + File.separator + fileName);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    // Product 객체 생성 및 필드 설정
    Product product = new Product();
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    product.setFile("uploads/" + fileName);

    // ProductRepository 인스턴스 생성 및 insert 호출
    ProductRepository productRepository = new ProductRepository();
    int result = productRepository.insert(product);

    // 결과 처리
    if (result > 0) {
        out.println("<script>alert('상품이 성공적으로 등록되었습니다.'); location.href='products.jsp';</script>");
    } else {
        out.println("<script>alert('상품 등록에 실패하였습니다. 다시 시도해 주세요.'); history.back();</script>");
    }
%>
