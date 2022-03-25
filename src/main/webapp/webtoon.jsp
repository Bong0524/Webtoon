<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="com.humanwebtoon.vo.ToonpageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
WebtoonInfo webtoon = (WebtoonInfo) request.getAttribute("webtoon");
ArrayList<ToonpageInfo> toonpageList = (ArrayList<ToonpageInfo>)request.getAttribute("toonpageList");
UserInfo user = (UserInfo) session.getAttribute("user");
/* 마지막으로 본화 */
Cookie[] seen = request.getCookies();
String toon_ck = "1"; 
for(int i = 0 ; i < seen.length ; i++){
	if(seen[i].getName().equals(webtoon.getToon_id())) toon_ck = seen[i].getValue();
}
System.out.println(toon_ck);
%>
<style>
.scoreView{
	position: absolute;
	left: 0;
}
</style>
<fieldset style="margin-bottom: 20px; position: relative;">
	<img alt="이미지 오류.." src="img/<%=webtoon.getToon_id() %>/thumbnail.jpg" width="200px" height="200px" style="float: left; margin-right: 10px">
		<div style="padding: 5px">
			<h1 style="display: inline;"><%=webtoon.getTitle() %></h1>
			<p style="display: inline;">(작가 : <%=webtoon.getWriter()%>)</p>
		</div>
	<p style="word-break : keep-all; padding: 10px;">
		<%=webtoon.getInfo() %>
	</p>
	<div style="position: absolute; bottom: 10px; right: 10px;">
		<input id="getSeenBtn" type="button" value="<%=toon_ck.equals("1") ? "1화 보기" : "최근 본화"%>" onclick="location.href='ToonPage?toon=<%=webtoon.getToon_id()%>&page=<%=toon_ck%>'">
		<input id="uploadBtn" type="hidden" value="업로드" onclick="location.href='upload.jsp?toon=<%=webtoon.getToon_id()%>'">
	</div>
</fieldset>
<table id="pageList" style="width: 100%; text-align: center; border-spacing: 0;border-collapse: collapse;">
	<tr>
		<td width="140px">썸네일</td>
		<td width="280px">제목</td>
		<td width="150px">별점</td>
		<td width="130px">등록일</td>
	</tr>
	<%
	/* WebtoonPro에서 받아온 ArrayList를 이용해 웹툰 페이지를 뿌린다. */
	for(int i = 0 ; i < toonpageList.size() ; i++) {
	ToonpageInfo toonpage = toonpageList.get(i);
	%>
	<tr height="100px" style="border-top: 1px solid #444444;">
		<td style="padding: 10px 20px">
			<a href="ToonPage?toon=<%=toonpage.getToon_id()%>&page=<%=toonpage.getPage_num()%>">
				<img alt="<%=toonpage.getPage_num() %>화 썸네일" src="img/<%=webtoon.getToon_id() %>/<%=toonpage.getPage_num() %>/thumbnail.jpg" width="100px" height="100px">
			</a>
		</td>
		<td style="text-align: left; padding-left: 20px">
			<a href="ToonPage?toon=<%=toonpage.getToon_id()%>&page=<%=toonpage.getPage_num()%>" class="toonLink" ><%=toonpage.getPage_num()%>화.&nbsp;<%=toonpage.getTitle() %></a>
		</td>
		<td>
			<div style="position: relative; width: 80px; height: 24px; display: inline-block;">
				<span class="scoreView" style="color: #ccc;">★★★★★</span>
				<span class="scoreView" style="color: red; overflow: hidden; width: <%=toonpage.getScore()*8 %>px;">★★★★★</span>
			</div>
			<span style="vertical-align: super; text-align: right; width: 30px; font-weight: bold; font-size: 0.9em; display: inline-block;"><%=toonpage.getScore() %></span>
		</td>	
		<td>
			<p><%=toonpage.getWrdate() %></p>
		</td>
	</tr>
	<%} %>
</table>
<script>
/* 로그인했을경우에 한해서 로그인아이디와 작가의 아이디가 같을경우 업로드버튼을 보인다. */
	<% if(user!=null){	%>
	var uploadBtn = document.getElementById("uploadBtn");
	var userId = "<%=user.getId()%>";
	var writerId = "<%=webtoon.getWriter()%>";
	if(userId == writerId){
		document.getElementById("uploadBtn").type = "button";
	}
	<%}%>
</script>
