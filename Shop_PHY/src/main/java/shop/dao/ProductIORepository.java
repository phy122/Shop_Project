package shop.dao;

import java.sql.Date;
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
		
		String sql = " INSERT INTO product_io(order_no, product_id, amount, type, io_date, user_id) " +
				     " values(?,?,?,?,?,NOW(),?) ";
		

        try (
             PreparedStatement psmt = con.prepareStatement(sql)) {

        	psmt.setInt(1, product.getOrderNo());        
            psmt.setString(2, product.getProductId());
            psmt.setInt(3, product.getAmount());
            psmt.setString(4, type);                     
            psmt.setString(5, product.getIoDate());      
            psmt.setString(6, product.getUserId());      

            result = psmt.executeUpdate();               
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}