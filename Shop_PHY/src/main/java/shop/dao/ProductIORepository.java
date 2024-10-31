package shop.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product, String type) {
		int result = 0;
		
		String sql = "INSERT INTO product_io(io_no, product_id, order_no, amount, type, io_date, user_id)" +
				     "values(?,?,?,?,?,NOW(),?)";
		

        try (
             PreparedStatement psmt = con.prepareStatement(sql)) {

            psmt.setString(1, product.getProductId());   // 상품 ID
            psmt.setInt(2, product.getOrderNo());        // 주문 번호
            psmt.setInt(3, product.getQuantity());       // 입출고 수량 (장바구니 개수)
            psmt.setString(4, type);                     // 입출고 유형 (IN/OUT)
            psmt.setString(5, product.getUserId());      // 회원 ID

            result = psmt.executeUpdate();               // 쿼리 실행
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}