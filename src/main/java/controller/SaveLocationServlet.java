package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.DBConnection;


@WebServlet("/SaveLocationServlet")
public class SaveLocationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read JSON data from the request
        BufferedReader reader = request.getReader();
        StringBuilder json = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            json.append(line);
        }

        // Parse JSON
        JSONObject jsonObject = new JSONObject(json.toString());
        double latitude = jsonObject.getDouble("latitude");
        double longitude = jsonObject.getDouble("longitude");

        // Get the user ID (from session)
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            // Database connection and operations
            try (Connection con = DBConnection.openConnection()) {
                // Step 1: Delete existing location for the user
                try (PreparedStatement deleteStmt = con.prepareStatement("DELETE FROM tbl_locations WHERE user_id = ?")) {
                    deleteStmt.setInt(1, userId);
                    deleteStmt.executeUpdate();
                }

                // Step 2: Insert new location
                try (PreparedStatement insertStmt = con.prepareStatement("INSERT INTO tbl_locations (user_id, latitude, longitude) VALUES (?, ?, ?)")) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setDouble(2, latitude);
                    insertStmt.setDouble(3, longitude);
                    insertStmt.executeUpdate();
                }

                // Step 3: Send success response
                response.getWriter().write("Location saved successfully.");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("Error saving location.");
            }
        } else {
            response.getWriter().write("User not logged in.");
        }
    }
}
