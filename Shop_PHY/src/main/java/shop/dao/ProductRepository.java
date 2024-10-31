package shop.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;
import shop.dto.User;


public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = "SELECT * " +
					 "FROM product";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Product products = new Product();
				products.setFile(rs.getString("file"));
				products.setName(rs.getString("name"));
				products.setDescription(rs.getString("description"));
				products.setUnitPrice(rs.getInt("unit_price"));
				productList.add(products);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> productList = new ArrayList<Product>();
		
		String sql = "SELECT * " +
					 "FROM product"+
					 "WHERE name LIKE CONCAT('%', ? , '%')";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Product products = new Product();
				products.setFile(rs.getString("file"));
				products.setName(rs.getString("name"));
				products.setDescription(rs.getString("description"));
				products.setUnitPrice(rs.getInt("unit_price"));
				productList.add(products);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		String sql = "SELECT* " +
				 "FROM product"+
				 "WHERE product_id = ?";
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				product = new Product();
				product.setFile(rs.getString("file"));
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getInt("units_in_stock"));
				product.setCondition(rs.getString("condition"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return product;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		String sql = "INSERT INTO product(file, product_id, name, unit_price, description, manufacturer, category, units_in_stock, condition)" +
					 "values(?,?,?,?,?,?,?,?,?)";
		
		try {
			psmt = con.prepareStatement(sql);
			
            psmt.setString(1, product.getFile());  
            psmt.setString(2,product.getProductId());
            psmt.setString(3, product.getName());       
            psmt.setInt(4, product.getUnitPrice());                  
            psmt.setString(5, product.getDescription());      
            psmt.setString(6, product.getManufacturer());      
            psmt.setString(7, product.getCategory());      
            psmt.setLong(8, product.getUnitsInStock());      
            psmt.setString(9, product.getCondition());      

            result = psmt.executeUpdate();               
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		 String sql = "UPDATE product SET file = ?, product_id = ?, name = ?, unit_price = ?, description = ?, manufacturer = ?, category = ?, units_in_stock = ?, condition = ? WHERE product_id = ?";
	     int result = 0;
	        
	     try {
	    	 	psmt = con.prepareStatement(sql);
	    	 	
	            psmt.setString(1, product.getFile()); 
	            psmt.setString(2,product.getProductId());
	            psmt.setString(3, product.getName());       
	            psmt.setInt(4, product.getUnitPrice());                  
	            psmt.setString(5, product.getDescription());      
	            psmt.setString(6, product.getManufacturer());      
	            psmt.setString(7, product.getCategory());      
	            psmt.setLong(8, product.getUnitsInStock());      
	            psmt.setString(9, product.getCondition());      

	            result = psmt.executeUpdate();               
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		        return result;
	        
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		String sql = " DELETE FROM product"
				   + " WHERE product_id = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}





























