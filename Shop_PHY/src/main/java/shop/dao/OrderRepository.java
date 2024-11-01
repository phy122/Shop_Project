package shop.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
		String sql = "insert into order(ship_name,date,country,zip_code,address,phone)"
					+ "values(?,?,?,?,?,?,?,?,?)";
		try {
			psmt = con.prepareStatement(sql);			// 쿼리 실행 객체 생성
			psmt.setString(1, order.getShipName());		// 1번 ? 에 title(제목) 매핑
			psmt.setString(5, order.getDate());
			psmt.setString(3, order.getCountry());		// 3번 ? 에 content(내용) 매핑
			psmt.setString(2, order.getZipCode());		// 2번 ? 에 writer(작성자) 매핑
			psmt.setString(4, order.getAddress());
			psmt.setString(8, order.getPhone());
			result =psmt.executeUpdate();				// SQL 실행 요청
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int lastOrderNo = 0;
		
		String sql = "SELECT MAX(order_no) FROM order";
		
		try{
				 psmt = con.prepareStatement(sql);
				 ResultSet rs = psmt.executeQuery();
				 if (rs.next()) {
					lastOrderNo = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return lastOrderNo;
		
		
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> products = new ArrayList<>();
		
		 String sql = "SELECT p.name, p.unit_price, o.order_no, io.amount " +
                 	  "FROM `order` o " +
                 	  "JOIN product_io io ON o.order_no = io.order_no " +
                 	  "JOIN product p ON io.product_id = p.product_id " +
                 	  "WHERE o.user_id = ?";
		
		 	try{
			 		 psmt = con.prepareStatement(sql);
					 psmt.setString(1, userId);

	            try (ResultSet rs = psmt.executeQuery()) {
	                while (rs.next()) {
	                    Product product = new Product();
	                    product.setName(rs.getString("name"));
	                    product.setUnitPrice(rs.getInt("unit_price"));
	                    product.setOrderNo(rs.getInt("order_no"));
	                    product.setUserId(rs.getString("user_id"));
	                    product.setAmount(rs.getInt("amount"));

	                    products.add(product);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return products;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT p.name, p.unit_price, o.order_no, io.amount " +
                "FROM `order` o " +
                "JOIN product_io io ON o.order_no = io.order_no " +
                "JOIN product p ON io.product_id = p.product_id " +
                "WHERE o.phone = ? AND o.order_pw = ?";

        try  {
        	psmt = con.prepareStatement(sql);
        	psmt.setString(1, phone);
        	psmt.setString(2, orderPw);

            try (ResultSet rs = psmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setName(rs.getString("name"));
                    product.setUnitPrice(rs.getInt("unit_price"));
                    product.setOrderNo(rs.getInt("order_no"));
                    product.setAmount(rs.getInt("amount"));

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
		
}
	































