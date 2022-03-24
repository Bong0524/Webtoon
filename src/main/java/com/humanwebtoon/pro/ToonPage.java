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
import com.humanwebtoon.vo.ToonpageInfo;

@WebServlet("/ToonPage")
public class ToonPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String toon_id = request.getParameter("toon");
		String page_num = request.getParameter("page");
		String page_id = toon_id+"_"+page_num;
		System.out.println(page_id);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		//이미지 경로를 지정한다.
		String path = "img\\"+toon_id+"\\"+page_num+"";
		File imgs = new File(request.getSession().getServletContext().getRealPath(path));
		//이미지리스트를 파일배열에 담는다
		File[] imgList = imgs.listFiles();
		String sql = null;
		try {
			conn = JDBCConnection.getConnection();
			/* 조회수 카운팅 구문 */
			sql = "update web_toonpage set view_cnt = (select view_cnt+1 from web_toonpage where page_id = ?) where page_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, page_id);
			stmt.setString(2, page_id);
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			stmt.close();
			/* 출력할 웹툰의 페이지 검색 후 담는 구문 */
			sql = "select t.*, nvl(round(avg(s.score),2),0) as score from web_toonpage t join web_score s on t.page_id = s.target(+) where page_id = ? group by page_id,page_num,toon_id,title,view_cnt,wrdate";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, page_id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				ToonpageInfo toonpage = new ToonpageInfo();
				toonpage.setPage_id(rs.getString("page_id"));
				toonpage.setPage_num(rs.getInt("page_num"));
				toonpage.setTitle(rs.getString("title"));
				toonpage.setToon_id(rs.getString("toon_id"));
				toonpage.setView_cnt(rs.getInt("view_cnt"));
				toonpage.setWrdate(rs.getDate("wrdate"));
				toonpage.setScore(rs.getDouble("score"));
				toonpage.setImgs(imgList);
				request.setAttribute("toonpage", toonpage);
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("toonpage.jsp");
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
