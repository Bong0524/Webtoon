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

@WebServlet("/UserEditPro")
public class UserEditPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] grade = request.getParameterValues("grade");
		String[] delete = request.getParameterValues("delete");
		String req = request.getParameter("req");
		String part = null;
				
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		int cnt = 0;
		
		try {
			conn = JDBCConnection.getConnection();
			if(req.equals("삭제")) {
				part = delete[0];
				for(int i = 1 ; i < delete.length ; i++) {
					part += delete[i];
				}
				sql = "delete from web_user where id = "+part+"";
				stmt = conn.prepareStatement(sql);
				cnt = stmt.executeUpdate();
			}else if(req.equals("수정")) {
				for(int i = 0 ; i < grade.length ; i++) {
					sql = "update web_user set grade = " + grade[i]+"";
					System.out.println(sql);
					stmt = conn.prepareStatement(sql);
					cnt = stmt.executeUpdate();
					stmt.close();
				}
			}
			System.out.println(cnt);
			response.sendRedirect("system/system.jsp?syspage=User");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
		
	}
}
