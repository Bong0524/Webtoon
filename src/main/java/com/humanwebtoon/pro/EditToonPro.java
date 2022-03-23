package com.humanwebtoon.pro;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.humanwebtoon.base.JDBCConnection;

@WebServlet("/EditToonPro")
@MultipartConfig(
	    fileSizeThreshold = 1024*1024,
	    maxFileSize = 1024*1024*50,
	    maxRequestSize = 1024*1024*10*100
)
public class EditToonPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String req = request.getParameter("req");
		String title = request.getParameter("title");
		String info = request.getParameter("info");
		String toon_id = request.getParameter("toon_id");
		String[] select = request.getParameterValues("select");
		
		UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt = 0;
		try {
			conn = JDBCConnection.getConnection();
			
			if(req.equals("수정")) {
				/* 썸네일 수정 */
				Part img = (Part)request.getPart("thumbnail");
				System.out.println(img.getSize() != 0 && img != null);
				if(img.getSize() != 0 && img != null){
					if(!img.getName().equals("thumbnail")) return; //thumbnail로 들어온 Part가 아니면 스킵
					uploadUtil.saveFiles(img, uploadUtil.createFilePath(toon_id),"thumbnail.jpg");
				}
				/* 정보 수정 */
				sql = "update web_webtoon set title = ?, info = ? where toon_id = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, title);
				stmt.setString(2, info);
				stmt.setString(3, toon_id);
				cnt = stmt.executeUpdate();
			}else if(req.equals("삭제")) {
				String path[] = null;
				String file = null;
				File filePath = null;
				File[] imgList = null;
				String part = "'"+select[0]+"'";
				
				for(int i = 1 ; i < select.length ; i++) {
					part += " or page_id = '"+select[i]+"'";
				}
				sql = "delete from web_toonpage where page_id = "+part+"";
				stmt = conn.prepareStatement(sql);
				cnt = stmt.executeUpdate();
				stmt.close();
				
				part = "'"+select[0]+"'";
				for(int i = 1 ; i < select.length ; i++) {
					part += " or target = '"+select[i]+"'";
				}
				sql = "delete from web_comments where target = "+part+"";
				stmt = conn.prepareStatement(sql);
				cnt = stmt.executeUpdate();
				
				for(int i = 0 ; i < select.length ; i++) {
					path = select[i].split("_");
					file = "img\\"+path[0]+"\\"+path[1]; 
					filePath = new File(request.getSession().getServletContext().getRealPath(file)); 
					imgList = filePath.listFiles(); 
					// 선택 폴더에서 파일과 파일을 지운다
					for (int j = 0; j < imgList.length; j++) {
						imgList[j].delete(); 
					}
					filePath.delete(); 
				}
			}else if(req.equals("웹툰삭제")) {
				String file = null;
				File filePath = null;
				File[] imgList = null;
				sql = "delete from web_webtoon where toon_id = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, toon_id);
				cnt = stmt.executeUpdate(); 
				file = "img\\"+toon_id;
				filePath = new File(request.getSession().getServletContext().getRealPath(file)); 
				imgList = filePath.listFiles(); 
				// 선택 폴더에서 파일과 파일을 지운다
				for (int j = 0; j < imgList.length; j++) {
					imgList[j].delete(); 
				}
				filePath.delete(); 
			}
			System.out.println(cnt);
			response.sendRedirect("EditReadPro?toon_id="+toon_id+"");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
		
	}
}
