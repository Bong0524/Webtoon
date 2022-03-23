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
import com.humanwebtoon.vo.RequestInfo;

@WebServlet("/RequestListPro")
public class RequestListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCConnection.getConnection();
			String sql = "select writer,title,to_char(wrdate,'yyyy-mm-dd') as wrdate,subTitle from web_request order by sysdate desc";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			ArrayList<RequestInfo> requestList = new ArrayList<RequestInfo>();
			while(rs.next()) {
				RequestInfo reqToon = new RequestInfo();
				reqToon.setTitle(rs.getString("title"));
				reqToon.setWrdate(rs.getString("wrdate"));
				reqToon.setWriter(rs.getString("writer"));
				reqToon.setSubTitle(rs.getString("subTitle"));;
				requestList.add(reqToon);
			}
			request.setAttribute("requestList", requestList);
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
