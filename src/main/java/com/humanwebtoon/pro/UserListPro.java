package com.humanwebtoon.pro;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humanwebtoon.base.JDBCConnection;
import com.humanwebtoon.vo.UserInfo;

@WebServlet("/UserListPro")
public class UserListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from web_user where not grade = 'Admin' order by grade";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			ArrayList<UserInfo> userList = new ArrayList<UserInfo>();
			while(rs.next()) {
				UserInfo user = new UserInfo();
				user.setName(rs.getString("name"));
				user.setGrade(rs.getString("grade"));
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				userList.add(user);
			}
			request.setAttribute("userList", userList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("system/system.jsp?syspage=User");
			dispatcher.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
