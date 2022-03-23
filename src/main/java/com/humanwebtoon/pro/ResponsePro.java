package com.humanwebtoon.pro;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humanwebtoon.base.JDBCConnection;

@WebServlet("/ResponsePro")
public class ResponsePro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] checked = request.getParameterValues("checkedBox");
		String result = request.getParameter("result");
		String toon_id = request.getParameter("toon_id");
		System.out.println(result);
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String part = "'" + checked[0] + "'";
			for (int i = 0; i < checked.length; i++) {
				System.out.println("여기");
				// 체크된 요청들을 받아와 sql문에 넣을 part를 만든다.
				if (checked.length > i + 1)
					part += " or writer = '" + checked[i + 1] + "'";

				// -----연재 승인된 페이지를 처리하는 구문------
				if (result.equals("승인")) {
					System.out.println("승인된 페이지 처리");
					sql = "select * from web_request where writer = ?";
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, checked[i]);
					rs = stmt.executeQuery();
					if (rs.next()) {
						String writer = rs.getString("writer");
						String title = rs.getString("title");
						String info = rs.getString("info");
						String subTitle = rs.getString("subTitle");
						// 복사할 폴더
						String copy = "img\\request\\" + writer;
						File copyPath = new File(request.getSession().getServletContext().getRealPath(copy));
						// 웹툰 폴더
						String toonFolder = "img\\" + toon_id;
						File toonPath = new File(request.getSession().getServletContext().getRealPath(toonFolder));
						// 웹툰의 페이지 폴더
						String toonPageFolder = "img\\" + toon_id + "\\1\\";
						File toonPagePath = new File(
								request.getSession().getServletContext().getRealPath(toonPageFolder));
						// 연재 폴더가 없으면 만든다
						if (!toonPath.exists())
							toonPath.mkdir();
						if (!toonPagePath.exists())
							toonPagePath.mkdir();

						// 메인 썸네일을 요청폴더에서 연재폴더로 복사하고 삭제한다.
						File copyThumbnail = new File(
								request.getSession().getServletContext().getRealPath(copy) + "\\thumbnail.jpg");
						File thumbnail = new File(
								request.getSession().getServletContext().getRealPath(toonFolder) + "\\thumbnail.jpg");
						Files.copy(copyThumbnail.toPath(), thumbnail.toPath(), StandardCopyOption.REPLACE_EXISTING);
						copyThumbnail.delete();

						// 서브 썸네일을 요청폴더에서 연재폴더로 복사하고 삭제한다.
						copyThumbnail = new File(
								request.getSession().getServletContext().getRealPath(copy) + "\\subThumbnail.jpg");
						thumbnail = new File(request.getSession().getServletContext().getRealPath(toonPageFolder)
								+ "\\thumbnail.jpg");
						Files.copy(copyThumbnail.toPath(), thumbnail.toPath(), StandardCopyOption.REPLACE_EXISTING);
						copyThumbnail.delete();

						File[] imgList = copyPath.listFiles();
						File pastePath = null;
						for (int j = 0; j < imgList.length; j++) {
							pastePath = new File(request.getSession().getServletContext().getRealPath(toonPageFolder)
									+ "\\" + (j + 1) + ".jpg");
							Files.copy(imgList[j].toPath(), pastePath.toPath(), StandardCopyOption.REPLACE_EXISTING);
							imgList[j].delete();
							// 요청폴더에서 지운다
							copyPath.delete();
						}
						stmt.close();
						// --연재 승인된 웹툰을 연재테이블에 추가한다.
						sql = "insert into WEB_WEBTOON values(?,?,?,?,?)";
						stmt = conn.prepareStatement(sql);
						stmt.setString(1, toon_id);
						stmt.setString(2, writer);
						stmt.setString(3, title);
						stmt.setString(4, "img/" + toon_id + "/thumbnail.jpg");
						stmt.setString(5, info);
						int cnt = stmt.executeUpdate();
						stmt.close();
						// 승인된 웹툰을 1화로 업로드 시킨다.
						sql = "insert into web_toonpage(page_id,page_num,toon_id,title) values(?,1,?,?)";
						stmt = conn.prepareStatement(sql);
						stmt.setString(1, toon_id + "_" + 1);
						stmt.setString(2, toon_id);
						stmt.setString(3, subTitle);
						cnt = stmt.executeUpdate();
						System.out.println(cnt);
						// --승인된 웹툰의 요청자를 작가로 등급을 바꾼다.
						sql = "update web_User set grade = 'Writer' where id = ?";
						stmt = conn.prepareStatement(sql);
						stmt.setString(1, writer);
						cnt = stmt.executeUpdate();
						System.out.println(cnt);
						stmt.close();
					}
				}
			}

			// 요청 테이블에서 응답된 테이블을 지운다.
			sql = "delete from web_request where writer = " + part + "";
			stmt = conn.prepareStatement(sql);
			int cnt = stmt.executeUpdate();
			System.out.println(cnt);
			response.sendRedirect("system/system.jsp?syspage=Request");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(conn, stmt, rs);
		}
	}

}
