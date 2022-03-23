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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.humanwebtoon.base.JDBCConnection;
import com.humanwebtoon.vo.UserInfo;

@WebServlet("/RequestPro")
@MultipartConfig(
	    fileSizeThreshold = 1024*1024,
	    maxFileSize = 1024*1024*50,
	    maxRequestSize = 1024*1024*10*100
)
public class RequestPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("RequestPro");
		HttpSession session = request.getSession();
		UserInfo user = (UserInfo) session.getAttribute("user");
		String writer = user.getId();
		String title = request.getParameter("title");
		String info = request.getParameter("info");
		String subTitle = request.getParameter("subTitle");
		System.out.println(writer+"/"+title);
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		RequestUtil requestUtil = RequestUtil.create(request.getServletContext());
		
		/* 썸네일 저장처리 구문 */
		Part img = (Part)request.getPart("thumbnail");
		if(img != null){
			System.out.println(img.getSubmittedFileName());
			if(!img.getName().equals("thumbnail")) return; //thumbnail로 들어온 Part가 아니면 스킵
			requestUtil.saveFiles(img, requestUtil.createFilePath(writer),"thumbnail.jpg");
		}
		/* 1화 썸네일 저장처리 구문 */
		img = (Part)request.getPart("subThumbnail");
		if(img != null){
			System.out.println(img.getSubmittedFileName());
			if(!img.getName().equals("subThumbnail")) return; //subThumbnail로 들어온 Part가 아니면 스킵
			requestUtil.saveFiles(img, requestUtil.createFilePath(writer),"subThumbnail.jpg");
		}
		/* 이미지 저장처리 구문 */
		int savenum = 0;
		List<Part> imgs = (List<Part>) request.getParts();
		for(int i = 0 ; i < imgs.size() ; i++) {
			System.out.println(i);
			Part part = imgs.get(i);
			if(!part.getName().equals("imgs")) continue; //imgs로 들어온 Part가 아니면 스킵
			savenum++;
			requestUtil.saveFiles(part, requestUtil.createFilePath(writer),savenum+".jpg");
		}
		try { 
			conn = JDBCConnection.getConnection(); 
			String sql = "insert into web_request(writer,title,info,subtitle) values(?,?,?,?)"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, writer); 
			stmt.setString(2, title);
			stmt.setString(3, info);
			stmt.setString(4, subTitle);
			
			int cnt = stmt.executeUpdate(); 
			System.out.println(cnt);
		
		response.sendRedirect("index.jsp"); 
		} catch(ClassNotFoundException e) { 
			e.printStackTrace(); 
		} catch (SQLException e) {
			e.printStackTrace(); 
		} finally { 
			JDBCConnection.close(conn, stmt); 
		}
		 
	}
}
