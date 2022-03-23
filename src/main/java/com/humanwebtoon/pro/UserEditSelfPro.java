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

@WebServlet("/UserEditSelfPro")
public class UserEditSelfPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		UserInfo user = (UserInfo)session.getAttribute("user");
		System.out.println(pw +"//"+ name+"//"+user.getId());
		
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "update web_user set pw = ?, name = ? where id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, pw);
			stmt.setString(2, name);
			stmt.setString(3, user.getId());
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			user.setName(name);
			user.setPw(pw);
			response.sendRedirect("index.jsp?inPage=home");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	} 

}
