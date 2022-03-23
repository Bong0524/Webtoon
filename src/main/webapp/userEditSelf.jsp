<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저정보 수정</title>
<link rel="icon" href="img/logo/favicon.ico">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

#container {
	width: 800px;
	margin: 80px auto;
	text-align: center;
}

.inputBox:focus {
	outline: none;
}

.inputBox {
	width: 400px;
	height: 50px;
	font-size: 1.02em;
	margin: 10px;
	padding-left: 10px;
}

input {
	cursor: pointer;
}

#resisterBtn {
	width: 226px;
	height: 50px;
	border: 0px;
	background: rgb(69, 56, 40);
	color: #ddd;
	font-weight: bold;
	font-size: 1.3em;
	border-radius: 5px;
	margin: 30px 0 10px;
}

#editBox {
	margin: 30px auto 10px;
	padding: 25px 30px;
	width: 400px;
	border-radius: 3px;
}

#warning {
	text-align: left;
	color: red;
	font-weight: bold;
	margin-top: 5px
}

.label {
	font-weight: bold;
	margin: 20px 0 0 10px;
}

.surely {
	color: red;
	margin-left: 10px;
}

.btn {
	background: rgb(69, 56, 40);
	color: #ddd;
	border-radius: 3px;
	padding: 5px 15px;
	width: 100px;
	font-size: 1em;
}
</style>
<%
UserInfo user = (UserInfo) session.getAttribute("user");
%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
	<div id="container">
		<form action="UserEditSelfPro" method="post" name="UserEditSelfForm">
			<a href="index.jsp?inPage=home"><img id="logo" alt="LOGO"
				src="img/logo/logo.png"></a>
			<fieldset id="editBox">
				<div style="text-align: left; margin-bottom: 20px;">
					<p style="text-align: center; font-size: 1.5em">정보 수정</p>
					<p class="label">아이디</p>
					<input class="inputBox" type="text" value="<%=user.getId()%>"
						disabled="disabled">
					<p class="label">비밀번호</p>
					<input class="inputBox" type="text" name="pw" id="pw"
						value="<%=user.getPw()%>">
					<p class="surely"></p>
					<p class="label">이름</p>
					<input class="inputBox" type="text" name="name" id="name"
						value="<%=user.getName()%>">
					<p class="surely"></p>
				</div>
				<input id="updateBtn" class="btn" type="button" value="수정">
				<input class="btn" type="reset" value="취소"> <input id="back"
					class="btn" type="button"
					onclick="location.href = 'index.jsp?inPage=home'" value="돌아가기">
			</fieldset>
		</form>
	</div>
	<script type="text/javascript">
		var inputBox = document.getElementsByClassName("inputBox");
		/* 입력항목 유효성 검사 */
		$("#updateBtn").click(function(e) {
			e.preventDefault();
			/* 유효하지 않은 항목에 대한 메세지 출력 */
			for (var i = 0; i < inputBox.length; i++) {
				if (!inputBox[i].value) {
					inputBox[i].nextElementSibling = "필수 입력 항목입니다.";
				}
			}
			/* 유효하지 않은 항목이 있으면 가입을 막는 구문 */
			for (var i = 0; i < inputBox.length; i++) {
				if (!inputBox[i].value) {
					inputBox[i].focus();
					return;
				}
			}
			UserEditSelfForm.submit();
		})
		/* 입력/변경시 유효한 칸의 유도문 추가/제거 */
		$(".inputBox").change(function() {
			$(this).next().text($(this).val() != "" ? "" : "필수 입력 항목입니다.");
		})
	</script>
</body>
</html>