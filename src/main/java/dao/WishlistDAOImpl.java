package dao;

import model.Product;
import model.Wishlist;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAOImpl implements WishlistDAO {

    @Override
    public void addToWishlist(int userId, int productId) {
        String query = "INSERT INTO tbl_wishlist (user_id, product_id) VALUES (?, ?)";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> getWishlistByUserId(int userId) {
        List<Product> wishlist = new ArrayList<>();
        String query = "SELECT p.* FROM tbl_products p JOIN tbl_wishlist w ON p.id = w.product_id WHERE w.user_id = ?";

        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("image"));
                wishlist.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return wishlist;
    }

    @Override
    public boolean isProductInWishlist(int userId, int productId) {
        String query = "SELECT COUNT(*) FROM tbl_wishlist WHERE user_id = ? AND product_id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void removeFromWishlist(int userId, int productId) {
        String query = "DELETE FROM tbl_wishlist WHERE user_id = ? AND product_id = ?";
        try (Connection con = DBConnection.openConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
