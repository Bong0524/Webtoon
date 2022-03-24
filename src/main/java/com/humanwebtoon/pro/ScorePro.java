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
import javax.servlet.http.HttpSession;

import com.humanwebtoon.base.JDBCConnection;
import com.humanwebtoon.vo.UserInfo;

@WebServlet("/ScorePro")
public class ScorePro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo)session.getAttribute("user");
		String target = request.getParameter("target");
		String did = request.getParameter("did");
		int score = Integer.parseInt(request.getParameter("score"));
		String id = user.getId();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			
			String sql = did.equals("none") ? "insert into web_score values(?,?,?)" : "update web_score set score = ? where target = ? and id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, score);
			stmt.setString(2, target);
			stmt.setString(3, id);
			
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
