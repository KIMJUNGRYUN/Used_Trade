package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/test")
public class TestCon extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청시 DB 연결
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		/*
		 * 1. DB연결 
		 * 
		 * Connection conn = null;
		 * 
		 * try { // conn = DriverManager.getConnection(주소, id, pw); 
		 * 			conn = DriverManager.getConnection(
		 * 					"jdbc:mysql://localhost:3306/webshop?useSSL=false", "root", "1234");
		 * 		out.println("DB 연결 완료");
		 * 
		 * } catch (SQLException e) { 
		 * 			out.println("DB에 연결할 수 없습니다.");
		 * 			return; 
		 * }
		 * 
		 * try {
		 * 		conn.close(); 
		 * } catch (SQLException e) { 
		 * }
		 */

		// 2. 커넥션 풀 연결

		Connection conn = null;

		try {
			// 외부에서 서버 xml 데이터를 읽어들어야 하기에
			Context initctx = new InitialContext();
			// 톰켓 서버에 정보를 담아놓은 곳으로 이동
			Context envctx = (Context) initctx.lookup("java:comp/env");
			// 데이터 소스 객체를 선언
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			// 데이터 소스를 기준으로 커넥션을 연결해주시오
			conn = ds.getConnection();
			// 연결 커넥션 리턴
			out.println("DB 연결 완료");

		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
