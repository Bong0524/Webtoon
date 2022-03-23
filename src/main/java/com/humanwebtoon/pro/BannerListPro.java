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

@WebServlet("/BannerListPro")
public class BannerListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCConnection.getConnection();
			
			/* 사이드 배너 */
			String sql = "select * from web_banner where position = 'side'";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			ArrayList<BannerInfo> sideBannerList = new ArrayList<BannerInfo>();
			while(rs.next()) {
				BannerInfo banner = new BannerInfo();
				banner.setBanner_id(rs.getString("banner_id"));
				banner.setLink(rs.getString("link"));
				banner.setPosition(rs.getString("position"));
				sideBannerList.add(banner);
			}
			request.setAttribute("sideBannerList", sideBannerList);
			rs.close();
			stmt.close();
			
			/* 탑 배너 */
			sql = "select * from web_banner where position = 'top'";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			ArrayList<BannerInfo> topBannerList = new ArrayList<BannerInfo>();
			while(rs.next()) {
				BannerInfo banner = new BannerInfo();
				banner.setBanner_id(rs.getString("banner_id"));
				banner.setLink(rs.getString("link"));
				banner.setPosition(rs.getString("position"));
				banner.setTitle(rs.getString("title"));
				banner.setIntro(rs.getString("intro"));
				topBannerList.add(banner);
			}
			
			request.setAttribute("topBannerList", topBannerList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("system/system.jsp");
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
