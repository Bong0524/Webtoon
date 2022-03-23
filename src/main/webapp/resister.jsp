<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴먼웹툰 회원가입</title>
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

#resisterBox {
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
</style>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
	<div id="container">
		<form action="ResisterPro" method="post" name="resisterForm">
			<a href="index.jsp?inPage=home"><img id="logo" alt="LOGO"
				src="img/logo/logo.png"></a>
			<fieldset id="resisterBox">
				<div style="text-align: left;">
					<p class="label">아이디</p>
					<input class="inputBox" type="text" name="id" id="id">
					<p class="surely" id="idMessage"></p>
					<p class="label">비밀번호</p>
					<input class="inputBox" type="password" name="pw" id="pw">
					<p class="surely" id="pwMessage"></p>
					<p class="label">비밀번호 확인</p>
					<input class="inputBox" type="password" id="pwRe">
					<p class="surely" id="pwReMessage"></p>
					<p class="label">이름</p>
					<input class="inputBox" type="text" name="name" id="name">
					<p class="surely" id="nameMessage"></p>
					<input type="checkbox" id="agree"
						style="margin-left: 10px; margin-top: 20px; width: 19px; height: 19px; vertical-align:bottom;">
					<span style="font-weight: bold;">약관동의(필수)</span>
					<p
						style="width: 400px; height: 100px; overflow: auto; margin: 10px; border: 1px solid black">
						휴먼웹툰은 서비스의 원활한 제공을 위하여 회원이 동의한 목적과 범위 내에서만 개인정보를 수집∙이용하며, 개인정보보호법에
						따라 휴먼웹툰 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 동의 거부권 및 동의
						거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 회원 가입 시에 ‘아이디,
						비밀번호, 이름’를 필수항목으로 수집합니다.</p>
					<p id="agreeMessage" style="color: red; margin-left: 10px"></p>
				</div>
				<input id="resisterBtn" type="button" value="회원가입">
			</fieldset>
		</form>
	</div>
	<script type="text/javascript">
	var inputBox = document.getElementsByClassName("inputBox");
	var surely = document.getElementsByClassName("surely");
	var overlap;
	/* 입력항목 유효성 검사 */
	$("#resisterBtn").click(function(e) {
		e.preventDefault();
		/* 유효하지 않은 항목에 대한 메세지 출력 */
		for(var i = 0 ; i < inputBox.length ; i++){
		if(!inputBox[i].value){
				surely[i].innerText = "필수 입력 항목입니다.";
			}
		}
		if(!$("#agree").is(":checked")){
			$("#agreeMessage").text("가입하시려면 약관에 동의해주세요.");
		}
		/* 유효하지 않은 항목이 있으면 가입을 막는 구문 */
		for(var i = 0 ; i < inputBox.length ; i++){
			if(!inputBox[i].value){
				inputBox[i].focus();
				return;
			}
		}
		if(overlap==1){
			$("#id").focus()
			return;
		}
		if($("#pw").val()!=$("#pwRe").val()){
			$("#pwRe").focus()
			return;
		}
		if(!$("#agree").is(":checked")){
			return;
		}
		resisterForm.submit();
	})
	
	
	/* 입력/변경시 유효한 칸의 유도문 추가/제거 */
	
	$("#pw").change(function() {
		$("#pwMessage").text($("#pw").val()!="" ? "":"필수 입력 항목입니다.");
	})
	$("#pwRe").change(function() {
		if($("#pwRe").val()==""){
			$("#pwReMessage").text("필수 입력 항목입니다.");
		}else if($("#pw").val()!=$("#pwRe").val()){
			$("#pwReMessage").text("비밀번호가 일치하지 않습니다.");
		}else{
			$("#pwReMessage").text("");
		}
	})
	$("#name").change(function() {
		$("#nameMessage").text($("#name").val()!="" ? "":"필수 입력 항목입니다.");
	})
	
	$("#agree").change(function() {
		$("#agreeMessage").text($("#agree").is(":checked") ? "":"가입하시려면 약관에 동의해주세요.");
	})
	
	/* 아이디 중복체크 및 유효성 검사 */
	$("#id").change(function() {
		$.ajax({
			type:"post",
			url:"http://localhost:8081/webtoon/IdOverlapPro",
			data:{id:$("#id").val()},
			success: function(data){
				overlap = data;
				if(overlap==1){
					$("#idMessage").css("color", "red");
					$("#idMessage").text("이미 존재하는 아이디입니다.");
				}else{
					$("#idMessage").css("color", "lime");
					$("#idMessage").text("멋진 아이디로군요!");
				}
				if($("#id").val()==""){
					$("#idMessage").css("color", "red");
					$("#idMessage").text("필수 입력 항목입니다.");
				}
			},
			error:function(){
				alert("오류");
			}
		});
	});
	
</script>
</body>
</html>