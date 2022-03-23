package com.humanwebtoon.pro;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.humanwebtoon.base.JDBCConnection;

@WebServlet("/BannerEdit")
@MultipartConfig(
		fileSizeThreshold = 1024*1024,
		maxFileSize = 1024*1024*50,
		maxRequestSize = 1024*1024*10*100
)
public class BannerEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String banner_id = request.getParameter("banner_id");
		String title = request.getParameter("title");
		String intro = request.getParameter("intro");
		String link = request.getParameter("link");
		System.out.println(banner_id+"//"+title+"//"+intro+"//"+link);	
		UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());

		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			Part img = (Part)request.getPart("bannerImg");
			if(img.getSize() != 0 && img != null){
				System.out.println("이미지교체");
				if(!img.getName().equals("bannerImg")) return;
				uploadUtil.saveFiles(img, uploadUtil.createFilePath("banner"),""+banner_id+".jpg");
			}
			String sql = "update web_banner set title = ?, intro = ?, link = ? where banner_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, intro);
			stmt.setString(3, link);
			stmt.setString(4, banner_id);
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			response.sendRedirect("system/system.jsp?syspage=Banner");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}
}
