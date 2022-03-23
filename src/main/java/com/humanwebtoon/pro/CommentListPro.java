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
import com.humanwebtoon.vo.CommentInfo;

@WebServlet("/CommentListPro")
public class CommentListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String toon = request.getParameter("toon");
		String page = request.getParameter("page");
		String back = "toon="+toon+"&page="+page+"";
		String target = toon+"_"+page;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select comm_id,substr(writer_id,1,3) || lpad('*',length(writer_id)-2,'*') as writer_id,writer_name,target,comments,to_char(wrdate,'yyyy-mm-dd hh:mi') as wrdate from web_comments where target = ? order by wrdate desc";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, target);
			rs = stmt.executeQuery();
			
			ArrayList<CommentInfo> commentsList = new ArrayList<CommentInfo>();
			while(rs.next()) {
				CommentInfo comment  = new CommentInfo();
				comment.setComm_id(rs.getInt("comm_id"));
				comment.setComments(rs.getString("comments"));
				comment.setTarget(rs.getString("target"));
				comment.setWrdate(rs.getString("wrdate"));
				comment.setWriter_id(rs.getString("writer_id"));
				comment.setWriter_name(rs.getString("writer_name"));
				commentsList.add(comment);
			}
			request.setAttribute("commentsList", commentsList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("ToonPage?"+back+"");
			dispatcher.include(request, response);
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
