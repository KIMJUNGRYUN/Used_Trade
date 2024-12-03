package dao;

import model.Customer;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {

	@Override
	public List<Customer> getAllCustomers() {
	    List<Customer> customers = new ArrayList<>();
	    String query = "SELECT * FROM tbl_users";  // 고객 정보를 담고 있는 테이블은 tbl_users입니다.
	    
	    try (Connection con = DBConnection.openConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Customer customer = new Customer();
	            customer.setId(rs.getInt("id"));
	            customer.setEmail(rs.getString("email"));
	            customer.setUsername(rs.getString("username"));
	            customer.setPassword(rs.getString("password"));
	            customer.setRole(rs.getString("role"));
	            customer.setCreatedAt(rs.getTimestamp("created_at"));
	            customers.add(customer);
	        }
	    } catch (SQLException e) {
	        System.err.println("SQL Error: " + e.getMessage()); // 에러 로그 출력
	        e.printStackTrace();
	    }
	    return customers;  // 고객 목록 반환
	}

	
	 @Override
	    public boolean deleteCustomerById(int id) {
	        String query = "DELETE FROM tbl_users WHERE id = ?";
	        try (Connection con = DBConnection.openConnection();
	             PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setInt(1, id);
	            return ps.executeUpdate() > 0;  // 삭제 성공 여부 반환

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	 

	 @Override
	 public List<Customer> getCustomersByPage(int pageNumber, int pageSize) {
	     List<Customer> customers = new ArrayList<>();
	     String query = "SELECT * FROM tbl_users LIMIT ?, ?";

	     try (Connection con = DBConnection.openConnection();
	          PreparedStatement ps = con.prepareStatement(query)) {

	         ps.setInt(1, (pageNumber - 1) * pageSize); // 시작 위치 (0부터 시작)
	         ps.setInt(2, pageSize); // 보여줄 레코드 수

	         try (ResultSet rs = ps.executeQuery()) {
	             while (rs.next()) {
	                 Customer customer = new Customer();
	                 customer.setId(rs.getInt("id"));
	                 customer.setEmail(rs.getString("email"));
	                 customer.setUsername(rs.getString("username"));
	                 customer.setPassword(rs.getString("password"));
	                 customer.setRole(rs.getString("role"));
	                 customer.setCreatedAt(rs.getTimestamp("created_at"));

	                 customers.add(customer);
	             }
	         }
	     } catch (SQLException e) {
	         e.printStackTrace();
	     }
	     return customers;
	 }

	    @Override
	    public int getTotalCustomerCount() {
	        int count = 0;
	        String query = "SELECT COUNT(*) FROM tbl_users";

	        try (Connection con = DBConnection.openConnection();
	             PreparedStatement ps = con.prepareStatement(query);
	             ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                count = rs.getInt(1); // 첫 번째 컬럼 값
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return count;
	    }
}
