package dao;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import model.Login;
import model.Product;
import util.DBConnection;

public class LoginDAOImple implements LoginDAO {

	@Override
	public boolean loginCheck(Login loginBean) {
	    String query = "SELECT password FROM tbl_users WHERE email = ?";
	    try {
	        // JNDI를 사용해 Connection 가져오기
	        Context initCtx = new InitialContext();
	        Context envCtx = (Context) initCtx.lookup("java:comp/env");
	        DataSource ds = (DataSource) envCtx.lookup("jdbc/pool");

	        try (Connection con = ds.getConnection();
	             PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setString(1, loginBean.getEmail());
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    String dbPassword = rs.getString("password");
	                    return dbPassword.equals(loginBean.getPassword()); // 단순 비교
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false; // 로그인 실패
	}
	

	
	@Override
	public String getUserRole(String email) {
	    String query = "SELECT role FROM tbl_users WHERE email = ?";
	    try {
	        Context initCtx = new InitialContext();
	        Context envCtx = (Context) initCtx.lookup("java:comp/env");
	        DataSource ds = (DataSource) envCtx.lookup("jdbc/pool");

	        try (Connection con = ds.getConnection();
	             PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setString(1, email);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getString("role"); // 역할 반환
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null; // 역할을 찾을 수 없음
	}
	

public List<Product> getProductsByPage(int page, int pageSize) {
    List<Product> products = new ArrayList<>();
    String query = "SELECT * FROM tbl_products LIMIT ? OFFSET ?"; // LIMIT과 OFFSET 사용
    try (Connection con = DBConnection.openConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setInt(1, pageSize); // 페이지 크기
        ps.setInt(2, (page - 1) * pageSize); // OFFSET 계산
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setTitle(rs.getString("title"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setSellerId(rs.getInt("seller_id"));
            product.setStatus(rs.getString("status"));
            product.setCreatedAt(rs.getTimestamp("created_at"));
            product.setImage(rs.getString("image"));
            product.setCategoryId(rs.getString("category_id"));
            products.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return products;
}

// 상품의 총 개수 가져오는 메서드
public int getTotalProductCount() {
    String query = "SELECT COUNT(*) AS total FROM tbl_products";
    try (Connection con = DBConnection.openConnection();
         PreparedStatement ps = con.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        if (rs.next()) {
            return rs.getInt("total");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0; // 기본값 0
}
@Override
public boolean isEmailExists(String email) {
    String query = "SELECT COUNT(*) FROM tbl_users WHERE email = ?";
    try (Connection con = DBConnection.openConnection();
         PreparedStatement ps = con.prepareStatement(query)) {
        ps.setString(1, email);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0; // 이메일이 존재하면 true 반환
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false; // 에러가 발생하거나 이메일이 존재하지 않으면 false 반환
}
	
}
