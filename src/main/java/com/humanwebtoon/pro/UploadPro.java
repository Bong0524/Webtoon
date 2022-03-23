package com.humanwebtoon.pro;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.humanwebtoon.base.JDBCConnection;

@WebServlet("/UploadPro")
@MultipartConfig(
	    fileSizeThreshold = 1024*1024,
	    maxFileSize = 1024*1024*50,
	    maxRequestSize = 1024*1024*10*100
)
public class UploadPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UploadPro");
		String toon_id = request.getParameter("toon_id");
		String page = request.getParameter("page");
		String title = request.getParameter("title");
		System.out.println(toon_id+"/"+page+"/"+title);
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into web_toonpage(page_id,page_num,toon_id,title) values(?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, toon_id+"_"+page);
			stmt.setString(2, page);
			stmt.setString(3, toon_id);
			stmt.setString(4, title);
			
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			
			UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());
			/* 썸네일 저장처리 구문 */
			Part img = (Part)request.getPart("thumbnail");
			if(img.getSubmittedFileName() != null){
				System.out.println(img.getSubmittedFileName());
				if(!img.getName().equals("thumbnail")) return; //thumbnail로 들어온 Part가 아니면 스킵
				uploadUtil.saveFiles(img, uploadUtil.createFilePath(toon_id,page),"thumbnail.jpg");
			}
			/* 이미지 저장처리 구문 */
			int savenum = 0;
			List<Part> imgs = (List<Part>) request.getParts();
			for(int i = 0 ; i < imgs.size() ; i++) {
				Part part = imgs.get(i);
				System.out.println(i+"//"+part.getSubmittedFileName());
				if(!part.getName().equals("imgs")) continue; //imgs로 들어온 Part가 아니면 스킵
				savenum++;
				uploadUtil.saveFiles(part, uploadUtil.createFilePath(toon_id,page),savenum+".jpg");
			}
			response.sendRedirect("WebtoonPro?toon="+toon_id+"");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt);
		}
	}
}
