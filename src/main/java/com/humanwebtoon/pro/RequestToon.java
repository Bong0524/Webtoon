package com.humanwebtoon.pro;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humanwebtoon.base.JDBCConnection;
import com.humanwebtoon.vo.RequestInfo;

@WebServlet("/RequestToon")
public class RequestToon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String writer = request.getParameter("writer");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//이미지 경로를 지정한다.
		String path = "img\\request\\"+writer+"";
		File imgs = new File(request.getSession().getServletContext().getRealPath(path));
		//이미지리스트를 파일배열에 담는다
		File[] imgList = imgs.listFiles();
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select * from web_request where writer = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, writer);
			rs = stmt.executeQuery();
			
			RequestInfo reqToon = new RequestInfo();
			if(rs.next()) {
				reqToon.setImgs(imgList);
				reqToon.setInfo(rs.getString("info"));
				reqToon.setTitle(rs.getString("title"));
				reqToon.setWrdate(rs.getString("wrdate"));
				reqToon.setWriter(rs.getString("writer"));
			}
			request.setAttribute("reqToon", reqToon);
			RequestDispatcher dispatcher = request.getRequestDispatcher("system/requestToon.jsp");
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
