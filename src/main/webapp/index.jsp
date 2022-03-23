<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.pro.WebtoonListPro"%>
<%@page import="com.humanwebtoon.vo.WebtoonInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
WebtoonInfo webtoon = (WebtoonInfo) request.getAttribute("webtoon");
UserInfo user = (UserInfo) session.getAttribute("user");
String inPage = request.getParameter("inPage");
/* 페이지 경로가 설정되어있지 않으면 home으로 지정한다. */
if (inPage == null) {
	inPage = "home";
}
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<meta charset="UTF-8">
<title>휴먼 웹툰</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	color: black;
	text-decoration: none;
}

#container {
	width: 960px;
	margin: 0 auto;
}

ul {
	list-style: none;
}

input {
	border: 0px;
	cursor: pointer;
}

#toonListContainer {
	display: flex;
	width: 100%;
	flex-wrap: wrap;
	margin-bottom: 50px;
}
.thumbnail {
	font-weight: bold;
	width: 32.5%; 
	text-align: center;
	cursor: pointer;
	font-size: 1em;
	border: 1px solid black;
	margin-bottom: 10px;
	margin-right: 1.25%
}

.thumbnail:nth-child(3n){ 
	margin-right: 0;
}

.thumbnail img {
	width: 100%;
	transform: scale(1);
	transition: all 0.3s ease-in-out;
}

.thumbnail:hover img{
	transform: scale(1.1);
}

#loginBtn{
	width: 226px;
	height: 55px;
	border: 0px;
	background: rgb(69, 56, 40);
	color: #ddd;
	font-weight: bold;
	font-size: 1.2em;
	border-radius: 2px;
}

#resisterBtn{
	width: 226px;
	height: 55px;
	border: 0px;
	font-weight: bold;
	font-size: 1.2em;
	border-radius: 2px;
	margin-top: 10px;
}

#logoutBtn {
	border-radius: 3px;
	width: 226px; 
	height: 45px;	
 	font-weight: bold; 
 	font-size: 1.1em; 
 	border-radius: 2px;
}

#uploadBtn {
	background: rgb(69, 56, 40);
	color: #ddd;
	border-radius: 3px;
	position: absolute;
	bottom: 10px;
	right: 10px;
	padding: 5px;
}

img {
	display: block;
}

</style>
<link rel="icon" href="img/logo/favicon.ico">
</head>
<body>
	<div id="container">
		<jsp:include page="header.jsp" />
		<div style="display: flex; justify-content: space-between;">
			<section style="float: left; width: 700px">
				<fieldset id="topBannderBox" style="margin-bottom: 10px; height: 210px; width: 700px; cursor: pointer;">
					<jsp:include page="bannerTop.jsp"/>
				</fieldset>
				<!-- 페이지가 home으로 지정되있는경우 -->
				<%if (inPage.equals("home")) {%>
				<!-- 웹툰리스트 페이지를 인클루딩한다. -->
				<jsp:include page="webtoonList.jsp" />
				<%} else {%>
				<!-- 페이지가 지정되어 있을 경우 지정된 페이지를 include한다. -->
				<jsp:include page='<%=inPage + ".jsp"%>' />
				<%}%>
			</section>
			<!-- 로그인 및 정보와 광고를 띄울 박스 -->
			<nav style="width: 250px; margin-bottom: 10px">
				<fieldset style="height: 210px; padding: 10px; width: 100%">
					<!-- 로그인 여부에 따른 로그인 박스 처리 -->
					<%if (user != null) {%>
					<jsp:include page="userBox.jsp" />
					<%} else {%>
					<jsp:include page="loginBox.jsp" />
					<%}%>
				</fieldset>
				<fieldset style="margin-top: 10px; width: 250px;">
					<jsp:include page="bannerSide.jsp"/>
				</fieldset>
			</nav>
		</div>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>