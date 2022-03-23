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
import com.humanwebtoon.vo.ToonpageInfo;
import com.humanwebtoon.vo.WebtoonInfo;

@WebServlet("/WebtoonPro")
public class WebtoonPro extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String toon_id = request.getParameter("toon");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			conn = JDBCConnection.getConnection();
			sql = "select * from web_webtoon where toon_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, toon_id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				WebtoonInfo webtoon = new WebtoonInfo();
				webtoon.setInfo(rs.getString("info"));
				webtoon.setThumbnail(rs.getString("thumbnail"));
				webtoon.setTitle(rs.getString("title"));
				webtoon.setToon_id(rs.getString("toon_id"));
				webtoon.setWriter(rs.getString("writer"));
				request.setAttribute("webtoon", webtoon);
			}
			rs.close();
			stmt.close();
			
			sql = "select * from WEB_TOONPAGE where toon_id = ? order by wrdate desc";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, toon_id);
			rs = stmt.executeQuery();
			
			ArrayList<ToonpageInfo> toonpageList = new ArrayList<ToonpageInfo>();
			while(rs.next()) {
				ToonpageInfo toonpage = new ToonpageInfo();
				toonpage.setPage_id(rs.getString("page_id"));
				toonpage.setPage_num(rs.getInt("page_num"));
				toonpage.setTitle(rs.getString("title"));
				toonpage.setToon_id(rs.getString("toon_id"));
				toonpage.setView_cnt(rs.getInt("view_cnt"));
				toonpage.setWrdate(rs.getDate("wrdate"));
				toonpageList.add(toonpage);
			}
			request.setAttribute("toonpageList", toonpageList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp?inPage=webtoon");
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
