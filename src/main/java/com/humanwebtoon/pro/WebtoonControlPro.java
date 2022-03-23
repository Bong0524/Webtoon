package com.humanwebtoon.pro;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humanwebtoon.base.JDBCConnection;
@WebServlet("/WebtoonControlPro")
public class WebtoonControlPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String how = request.getParameter("how").equals("다음화") ? ">" : "<";
		String now = request.getParameter("now");
		String[] part = now.split("_");

		PrintWriter out = response.getWriter();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = JDBCConnection.getConnection();
			sql = "select page_num from web_toonpage where toon_id = ? and wrdate "+ how +" (select wrdate from web_toonpage where page_id = ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, part[0]);
			stmt.setString(2, now);
			rs = stmt.executeQuery();
			
			if(rs.next()) out.print(rs.getString("page_num"));
			else out.print("none"); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
	}
}
