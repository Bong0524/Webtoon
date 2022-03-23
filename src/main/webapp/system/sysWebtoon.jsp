<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
ArrayList<WebtoonInfo> webtoonList = (ArrayList<WebtoonInfo>)request.getAttribute("webtoonList");
/* webtoonList가 null일 경우 webtoonList를 불러오기위해 webtoonListPro를 호출한다. */
if(webtoonList == null){%>
<jsp:forward page="../ToonListPro" />
<%}%>	
<table style="text-align: center; width: 700px; margin: 20px auto; border-collapse: collapse;">
	<tr>
		<td width="100px;">썸네일</td>
		<td>제목</td>
		<td width="100px;">작가</td>	
		<td width="100px;">관리ID</td>
	</tr>
	<%for(int i = 0 ; i < webtoonList.size() ; i++){
		WebtoonInfo webtoon = webtoonList.get(i);%>
	<tr style="border-top: 1px solid black;">
		<td>
			<img alt="<%=i+1 %>번째 썸네일" src="../img/<%=webtoon.getToon_id() %>/thumbnail.jpg" width="100px" height="100px">
		</td>
		<td id="<%=webtoon.getToon_id() %>" class="clickToon"><a><%=webtoon.getTitle()%></a></td>
		<td><%=webtoon.getWriter()%></td>
		<td><%=webtoon.getToon_id()%></td>
	</tr>
	<%}%>
</table>
<script type="text/javascript">
$(".clickToon").click(function(e) {
	e.preventDefault;
	window.open("../EditReadPro?toon_id="+$(this).attr("id")+"", "ReadReq", "width=720,height=800, left=200,top=100");
})
</script>
