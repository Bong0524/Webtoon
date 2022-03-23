package com.humanwebtoon.pro;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humanwebtoon.base.JDBCConnection;

@WebServlet("/CommentDeletePro")
public class CommentDeletePro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String target = request.getParameter("target");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn  = JDBCConnection.getConnection();
			
			String sql = "delete web_comments where comm_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, target);
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
		
	}
}
