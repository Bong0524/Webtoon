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
import com.humanwebtoon.vo.BannerInfo;

@WebServlet("/BannerLoadPro")
public class BannerLoadPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pos = request.getParameter("pos");

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = JDBCConnection.getConnection();
			sql = "select * from web_banner where position = ? and link is not null";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, pos);
			rs = stmt.executeQuery();
			ArrayList<BannerInfo> bannerList = new ArrayList<BannerInfo>();
			while(rs.next()) {
				BannerInfo banner = new BannerInfo();
				banner.setBanner_id(rs.getString("banner_id"));
				banner.setIntro(rs.getString("intro"));
				banner.setLink(rs.getString("link"));
				banner.setPosition(rs.getString("position"));
				banner.setTitle(rs.getString("title"));
				banner.setNum(rs.getInt("num"));
				bannerList.add(banner);
			}
			request.setAttribute(""+pos+"BannerList", bannerList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
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
