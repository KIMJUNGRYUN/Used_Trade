package dao;

import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM tbl_products";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

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
    
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM tbl_products WHERE title LIKE ? OR description LIKE ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    	
    

    @Override
    public boolean addProduct(Product product) {
        String query = "INSERT INTO tbl_products (title, description, price, seller_id, status, created_at, image, category_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, product.getTitle());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getSellerId());
            ps.setString(5, product.getStatus());
            ps.setTimestamp(6, new Timestamp(product.getCreatedAt().getTime()));
            ps.setString(7, product.getImage());
            ps.setString(8, product.getCategoryId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }  
    
    @Override
    public boolean updateProduct(Product product) {
        String query = "UPDATE tbl_products SET title = ?, description = ?, price = ?, category_id = ?, status = ?, image = ? WHERE id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, product.getTitle());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getCategoryId());
            ps.setString(5, product.getStatus());
            ps.setString(6, product.getImage() != null ? product.getImage() : null);
            ps.setInt(7, product.getId());

            return ps.executeUpdate() > 0;  // 업데이트 성공 여부 반환
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteProduct(int productId) {
        String query = "DELETE FROM tbl_products WHERE id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;  // 삭제된 행 수가 1 이상이면 true 반환
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int id) {
        String query = "SELECT * FROM tbl_products WHERE id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
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
                return product;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 상품을 찾지 못한 경우
    }

    @Override
    public List<Product> getAllProducts(int pageNumber, int pageSize) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM tbl_products ORDER BY created_at DESC LIMIT ?, ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, (pageNumber - 1) * pageSize);  // 페이지 번호에 맞는 시작 위치
            ps.setInt(2, pageSize);  // 한 페이지에 보여줄 상품 수

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }


    public int getTotalProductCount() {
        int total = 0;
        String query = "SELECT COUNT(*) FROM tbl_products";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    @Override
    public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM tbl_users WHERE email = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // 이메일 존재 여부 반환
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 이메일이 존재하지 않음
    }
   
    @Override
    public boolean deleteProductsByCustomerId(int customerId) {
        String query = "DELETE FROM tbl_products WHERE seller_id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, customerId);
            return ps.executeUpdate() > 0;  // 삭제된 행이 1 이상이면 true
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getProductsByCustomerId(int customerId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM tbl_products WHERE seller_id = ?";

        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
