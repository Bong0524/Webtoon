<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
header {
	height: 50px;
	margin: 20px 0;
}

#logo {
	float: left;
	width: 300px;
	height: 50px;
}

#searchForm {
	border-radius: 3px;
	cursor: pointer;
	float: right;
	height: 36px;
	border: none;
	overflow: hidden;
	margin: 7px 0;
	border: 3px solid rgb(69, 56, 40);
}

#searchBtn {
	width: 60px;
	height: 100%;
	border: none;
	background: rgb(69, 56, 40);
	color: #ddd;
	font-size: 1em;
	vertical-align: bottom;
}

#searchBox {
	border: none;
	outline: none;
	padding: 5px;
	height: 100%;
	font-size: 1em;
	width: 250px;
	vertical-align: bottom;
}

#searchOption {
	border: none;
	height: 100%;
	outline: none;
	font-size: 1em;
	width: 60px;
}
</style>
<header>
	<a href="index.jsp?inPage=home"> 
		<img id="logo" alt="LOGO" src="img/logo/logo.png">
	</a>
	<form id="searchForm" name="searchForm" action="SearchPro" method="get">
		<select name="type" id="searchOption" style="cursor: pointer;">
			<option value="title">제목</option>
			<option value="writer">작가</option>
		</select><input id="searchBox" type="text" 
		name="search"><input id="searchBtn" type="submit" value="검색">
	</form>
</header>