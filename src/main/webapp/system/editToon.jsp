<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="com.humanwebtoon.vo.ToonpageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 수정 팝업</title>
<style type="text/css">
*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
input {
	border: none;
}
input:focus{
	outline: none;
}
textarea:focus{
	outline: none;
}
img{
	display: block;
}
.btn{
	background: rgb(69,56,40); 
	color: #ddd; 	
	border-radius: 3px;
	padding: 5px 15px;
	cursor: pointer;
}
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<%
UserInfo user = (UserInfo) session.getAttribute("user");
WebtoonInfo webtoon = (WebtoonInfo) request.getAttribute("webtoon");
ArrayList<ToonpageInfo> toonpageList = (ArrayList<ToonpageInfo>)request.getAttribute("toonpageList");
if(webtoon != null || !(user.getGrade().equals("관리자"))){
%>
<form action="EditToonPro" method="post" name="editForm" enctype="multipart/form-data">
	<fieldset style="margin-bottom: 20px; position: relative;">
		<label style="cursor: pointer;" for="thumbnail" id="thumbnailBox">
			<img id="viewThumbnail" alt="이미지 오류.." src="img/<%=webtoon.getToon_id() %>/thumbnail.jpg" width="200px" height="200px" style="float: left; margin-right: 10px">
		</label>
		<input type="file" style="display: none;" name="thumbnail" id="thumbnail">
		
		<input type="text" name="title" placeholder="제목만 입력해주세요." style="padding:5px; font-size: 1.5em; 
		border-bottom: 1px solid #ddd;" value="<%=webtoon.getTitle()%>">
		<p style="display: inline;">(작가 : <%=webtoon.getWriter()%>)</p>
		
		<textarea style="border: 1px solid #ddd; padding: 5px; margin-top: 5px; resize: none; font-size: 1.2em; width: 482px; height: 150px;" name="info"
		 placeholder="웹툰에 대한 소개를 써주세요.(승인시 웹툰소개란에 게시 될 내용입니다.)"><%=webtoon.getInfo() %></textarea>
		<input id="uploadBtn" type="hidden" value="업로드" onclick="location.href='upload.jsp?toon=<%=webtoon.getToon_id()%>'">
	</fieldset>
	<table id="pageList" style="width: 100%; text-align: center; border-spacing: 0;border-collapse: collapse;">
		<tr>
			<td width="140px;">썸네일</td>
			<td>제목</td>
			<td width="80px">조회수</td>
			<td width="100px;">삭제</td>
		</tr>
		<%
		/* WebtoonPro에서 받아온 ArrayList를 이용해 웹툰 페이지를 뿌린다. */
		for(int i = 0 ; i < toonpageList.size() ; i++) {
		ToonpageInfo toonpage = toonpageList.get(i);
		%>
		<tr height="100px" style="border-top: 1px solid #444444;">
			<td style="padding: 10px 20px">
				<img alt="<%=toonpage.getPage_num() %>화 썸네일" src="img/<%=webtoon.getToon_id() %>/<%=toonpage.getPage_num() %>/thumbnail.jpg" width="100px" height="100px">
			</td>
			<td style="text-align: left; padding-left: 20px">
				<%=toonpage.getPage_num()%>화.&nbsp;<%=toonpage.getTitle() %>
			</td>
			<td>
				<%=toonpage.getView_cnt() %>
			</td>	
			<td>
				<input type="checkbox" name="select" value="<%=toonpage.getPage_id()%>" style="width: 25px; height: 25px; vertical-align:bottom;">
			</td>
		</tr>
		<%} %>
	</table>
	<div style="margin: 10px auto; width: 600px; text-align: center;">
		<input type="hidden" id="req" name="req">
		<input type="hidden" name="toon_id" value="<%=webtoon.getToon_id()%>">
		<input type="button" class="btn" value="수정">
		<input type="button" class="btn" value="삭제">
		<input type="button" class="btn" value="웹툰삭제">
		<input type="button" class="btn" value="닫기">
	</div>
</form>
<script type="text/javascript">
	console.log("<%=user.getGrade()%>");
	opener.location.reload();
	/* 첨부밭은 썸네일을 미리 볼수 있도록 뿌려주는 함수 */
	var thumbnail = document.getElementById("thumbnail");
	thumbnail.onchange = function() {
		$("#viewThumbnail").attr("src" , URL.createObjectURL(thumbnail.files[0]));
	}
	$(".btn").click(function(e) {
		e.preventDefault;
		if($(this).val() == "닫기") return close();
		if($(this).val() == "웹툰삭제") {
			let size = <%=toonpageList.size()%>;
			if(size > 0){
				alert("모든 화를 삭제한 후에 웹툰을 삭제 할 수 있습니다.");
				return;
			}
		}
		$("#req").val($(this).val());
		editForm.submit();
	})
</script>
</body>
<%}else{%>
<script>
	opener.location.reload();close();
</script>
<%}%>

</html>