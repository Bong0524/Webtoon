<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserInfo user = (UserInfo) session.getAttribute("user"); 
String syspage = request.getParameter("syspage");
if (syspage == null){
	syspage = "Home";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
html{
	background: #eee;
}
#container{
	width: 960px;
	margin: 100px auto;
}
a{
	color: black;
	text-decoration: none;
	cursor: pointer;
}
a:hover{
	text-decoration: underline;
}

ul {
	list-style: none;
}
li {
	width: 19%;
	padding: 10px;
	cursor: pointer;
	background: rgb(69,56,40); 
	color: #ddd; 
	border-radius: 2px;
}
.btn{
	background: rgb(69,56,40); 
	color: #ddd; 	
	border-radius: 3px;
	padding: 5px 15px;
}
textarea:focus {
	outline: none;
}
input:focus {
	outline: none;
}
img{
	display: block;
}
.thumbnailBtn{
	cursor: pointer;
}
</style>
<title>웹툰사이트 관리 시스템</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<div id="container">
	<h1>휴먼웹툰사이트 관리자 페이지</h1>
	<nav style="margin: 20px 0">
		<ul style="display: flex; justify-content: space-between;">
			<li onclick="location.href='system.jsp?syspage=Home'">홈/설명페이지</li>
			<li onclick="location.href='system.jsp?syspage=Request'">웹툰 연재신청작 확인</li>
			<li onclick="location.href='system.jsp?syspage=Webtoon'">웹툰 관리</li>
			<li onclick="location.href='system.jsp?syspage=User'">유저 관리</li>
			<li onclick="location.href='system.jsp?syspage=Banner'">광고 관리</li>
		</ul>
	</nav>
	<jsp:include page='<%="sys"+syspage+".jsp"%>'/>
</div>

<script type="text/javascript">
<%if(user == null || !user.getGrade().equals("관리자")){%>
	close();
<%}%>
</script>
</body>
</html>