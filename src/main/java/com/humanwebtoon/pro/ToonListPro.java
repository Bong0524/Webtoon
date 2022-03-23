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
import com.humanwebtoon.vo.WebtoonInfo;

@WebServlet("/ToonListPro")
public class ToonListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = JDBCConnection.getConnection();
			String sql = "select * from web_webtoon";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			/* 전체 웹툰목록을 담을 arraylist 생성 및 담기 */
			ArrayList<WebtoonInfo> webtoonList = new ArrayList<WebtoonInfo>();
			while(rs.next()) {
				WebtoonInfo webtoon = new WebtoonInfo();
				webtoon.setInfo(rs.getString("info"));
				webtoon.setThumbnail(rs.getString("thumbnail"));
				webtoon.setTitle(rs.getString("title"));
				webtoon.setToon_id(rs.getString("toon_id"));
				webtoon.setWriter(rs.getString("writer"));
				webtoonList.add(webtoon);
			}
			request.setAttribute("webtoonList", webtoonList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("system/system.jsp?syspage=Webtoon");
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
