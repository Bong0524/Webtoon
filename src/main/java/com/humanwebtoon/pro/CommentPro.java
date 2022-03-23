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

@WebServlet("/CommentPro")
public class CommentPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("GetCommentPro");
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("PostCommentPro");
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo) session.getAttribute("user");
		String id = user.getId();
		String name = user.getName();

		String comment = request.getParameter("comment");
		String target = request.getParameter("target");
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into web_comments(comm_id,writer_id,writer_name,target,comments) values((select nvl(max(comm_id)+1,0) from web_comments),?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, name);
			stmt.setString(3, target);
			stmt.setString(4, comment);
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
