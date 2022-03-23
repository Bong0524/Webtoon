<%@page import="java.io.File"%>
<%@page import="com.humanwebtoon.vo.RequestInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	RequestInfo reqToon = (RequestInfo)request.getAttribute("reqToon");
	File[] imgs = reqToon.getImgs();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#closeBtn{
	background: rgb(69,56,40); 
	color: #ddd; 	
	border-radius: 3px;
	padding: 5px 15px;
	vertical-align: bottom;
}
</style>
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<body>
	<fieldset style="margin-bottom: 20px; position: relative; width: 700px">
	<img alt="<%=reqToon.getWriter()%> 썸네일" src="img/request/<%=reqToon.getWriter()%>/thumbnail.jpg" width="200px" height="200px" style="float: left; margin-right: 10px">
		<div style="padding: 5px">
			<h1 style="display: inline;"><%=reqToon.getTitle()%></h1>
			<p style="display: inline;">(신청자 : <%=reqToon.getWriter()%>)</p>
		</div>
	<p style="word-break : keep-all; padding: 10px;">
		<%=reqToon.getInfo() %>
	</p>
	</fieldset>
	<div id="imgContainer" style="margin: 10px auto; width: 600px;">
	<%for(int i = 0 ; i < imgs.length-2 ; i++){ %>
		<img alt="<%=i+1 %>페이지" src="img/request/<%=reqToon.getWriter()%>/<%=imgs[i].getName()%>"style="width: 600px;">
	<%} %>	
	</div>
	<div style="text-align: center;">
		<p>체크박스 클릭시 메인페이지의 체크박스도 체크됩니다.</p>
		<input type="checkbox" id="openerCheck" style="width: 25px; height: 25px">
		<input id="closeBtn" type="button" onclick="window.close()" value="창닫기">
	</div>
	<script type="text/javascript">
	$("#openerCheck").change(function() {
		opener.$("#<%=reqToon.getWriter()%>").prop('checked',$("#openerCheck").is(":checked"));
	})
	</script>
</body>
</html>