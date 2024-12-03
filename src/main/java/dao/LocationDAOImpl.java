package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.DBConnection;

public class LocationDAOImpl {

    public void updateLocation(int userId, String latitude, String longitude) {
        String query = "INSERT INTO user_locations (user_id, latitude, longitude) " +
                       "VALUES (?, ?, ?) " +
                       "ON DUPLICATE KEY UPDATE latitude = ?, longitude = ?, timestamp = CURRENT_TIMESTAMP";
        try (Connection conn = DBConnection.openConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setString(2, latitude);
            ps.setString(3, longitude);
            ps.setString(4, latitude);
            ps.setString(5, longitude);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
