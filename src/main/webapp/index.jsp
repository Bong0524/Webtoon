<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	margin: 90px auto 0;
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
	padding: 5px;
}

#getSeenBtn {
	background: rgb(69, 56, 40);
	color: #ddd;
	border-radius: 3px;
	padding: 5px;
}

img {
	display: block;
}

</style>
<link rel="icon" href="img/logo/favicon.ico">
</head>
<body>
<c:if test="${empty inPage}">
	<c:set var="inPage" value="home"/>
</c:if>
<jsp:include page="header.jsp" />
<div id="container">
	<div style="display: flex; justify-content: space-between;">
		<section style="float: left; width: 700px">
			<fieldset id="topBannderBox" style="margin-bottom: 10px; height: 210px; width: 700px; cursor: pointer;">
				<jsp:include page="bannerTop.jsp"/>
			</fieldset>
			<c:choose>
				<c:when test="${inPage eq 'home' || empty inPage}">
					<!-- 페이지가 home으로 지정되있는경우 웹툰리스트 페이지를 인클루딩한다. -->
					<jsp:include page="webtoonList.jsp" />
				</c:when>
				<c:otherwise>
					<!-- 페이지가 지정되어 있을 경우 지정된 페이지를 include한다. -->
					<jsp:include page="${inPage }.jsp" />
				</c:otherwise>
			</c:choose>
		</section>
		<!-- 로그인 및 정보와 광고를 띄울 우측박스 -->
		<nav style="width: 250px; margin-bottom: 10px">
			<fieldset style="height: 210px; padding: 10px; width: 100%">
				<!-- 로그인 여부에 따른 로그인 박스 처리 -->
				<c:choose>
					<c:when test="${!empty user}">
						<jsp:include page="userBox.jsp" />
					</c:when>
					<c:otherwise>
						<jsp:include page="loginBox.jsp" />
					</c:otherwise>
				</c:choose>
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