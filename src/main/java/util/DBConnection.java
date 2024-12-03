package util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBConnection {

    private static DataSource dataSource;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            dataSource = (DataSource) envCtx.lookup("jdbc/pool");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize DataSource: " + e.getMessage());
        }
    }

    public static Connection openConnection() {
        try {
            return dataSource.getConnection(); // Connection obtained from the pool
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get database connection: " + e.getMessage());
        }
    }
}
