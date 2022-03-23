<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "java.lang.annotation.*"%>
<%
ArrayList<WebtoonInfo> webtoonList = (ArrayList<WebtoonInfo>)request.getAttribute("webtoonList");
/* webtoonList가 null일 경우 webtoonList를 불러오기위해 webtoonListPro를 호출한다. */
if(webtoonList == null){%>
<jsp:forward page="WebtoonListPro" />
<%}%>	
	<div id="toonListContainer">
	<%
		for(int i = 0 ; i < webtoonList.size() ; i++){
			WebtoonInfo webtoon = webtoonList.get(i);
	%>	
	<div class="thumbnail" onclick="location.href='WebtoonPro?toon=<%=webtoon.getToon_id() %>'">
		<div style="overflow: hidden;">
			<img alt="<%=i+1 %>번째 썸네일" src="img/<%=webtoon.getToon_id() %>/thumbnail.jpg">
		</div>
		<p style="text-align:left; padding: 10px; font-size: 1em;"><%=webtoon.getTitle() %></p>
	</div>
	<%}%>
</div>