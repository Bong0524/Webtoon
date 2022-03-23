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
import javax.servlet.http.HttpSession;

import com.humanwebtoon.base.JDBCConnection;
import com.humanwebtoon.vo.UserInfo;

@WebServlet("/LoginPro")
public class LoginPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from WEB_USER where id = ? and pw = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			System.out.println("LoginPro//"+id+"//"+pw);
			rs = stmt.executeQuery();
			if (!rs.next()) {
				/* 일치하지 않는 아이디 혹은 비밀번호를 입력한 경우 */
				out.print("fail");
			} else {
				/* 입력된 정보와 일치하는 아이디가 있다면 아이디에 대한 정보를 세션에 담는다. */
				UserInfo user = new UserInfo();
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setName(rs.getString("name"));
				if(rs.getString("grade").equals("Writer")){
					user.setGrade("작가");					
				}else if(rs.getString("grade").equals("Admin")) {
					user.setGrade("관리자");
				}else {
					user.setGrade("회원");
				}
				session.setAttribute("user", user);
				out.print("success");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
	}

}
