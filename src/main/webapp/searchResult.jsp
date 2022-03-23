<%@page import="com.humanwebtoon.vo.ToonpageInfo"%>
<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<WebtoonInfo> webtoonList = (ArrayList<WebtoonInfo>)request.getAttribute("webtoonList");
ArrayList<ToonpageInfo> toonpageList = (ArrayList<ToonpageInfo>)request.getAttribute("toonpageList");
%>
<div>
<%for(int i = 0 ; i < webtoonList.size() ; i++){ 
	WebtoonInfo webtoon = webtoonList.get(i);
%>
<fieldset style="margin-bottom: 20px; position: relative; cursor: pointer;" onclick="location.href='WebtoonPro?toon=<%=webtoon.getToon_id() %>'">
	<img alt="이미지 오류.." src="img/<%=webtoon.getToon_id()%>/thumbnail.jpg"
		width="200px" height="200px" style="float: left; margin-right: 10px">
	<div style="padding: 5px">
		<h1 style="display: inline;"><%=webtoon.getTitle()%></h1>
		<p style="display: inline;">
			(작가 : <%=webtoon.getWriter()%>)
		</p>
	</div>
	<p style="word-break: keep-all; padding: 10px;">
		<%=webtoon.getInfo()%>
	</p>
</fieldset>
<%} %>
</div>