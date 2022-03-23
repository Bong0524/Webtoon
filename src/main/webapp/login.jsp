<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String back = request.getParameter("back");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴먼웹툰 로그인</title>
<link rel="icon" href="img/logo/favicon.ico">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
#container{
	width: 700px;
	margin: 200px auto;
	text-align: center;
}
.inputBox:focus{
	outline: none;
}
.inputBox{
	border: none; 
	width: 250px; 
	height: 35px; 
	font-size: 1.02em;
}
input{
	cursor: pointer;
}
#inpTop{
	border-radius: 4px 4px 0 0;
	border: 1px solid rgb(69,56,40) ; 
	width: 350px; 
	margin: 0 auto;
	padding: 5px;
	border-bottom: none;
}
#inpBot{
	border-radius: 0 0 4px 4px;
	border: 1px solid rgb(69,56,40) ; 
	width: 350px; 
	margin: 0 auto;
	padding: 5px;
	}
#loginBtn{
	width: 226px; 
	height: 50px; 
	border: 0px; 
	background: rgb(69,56,40); 
	color: #ddd; 
	font-weight: bold; 
	font-size: 1.3em; 
	border-radius: 5px; 
	margin: 30px 0 10px;
}
#loginBox{ 
	margin: 30px auto 10px; 
	padding: 25px 30px; 	
	width: 400px;
	border-radius: 3px;
}
.subBtn{
	color: rgb(117,53,0);
	text-decoration: none;
	font-weight: bold;
}
#subBtnBox{
	display: flex; 
	height: 20px; 
	width: 400px; 
	justify-content: space-between; 
	margin: 0 auto;
}
#warning{
	text-align: left;
	color: red; 
	font-weight: bold; 
	margin-top: 5px
}
#loginP{
	font-size: 1.5em; 
	margin: 15px; 
}

</style>
</head>
<body>
<div id="container">
	<form action="LoginPro" method="post" name="loginForm">
		<a href="index.jsp?inPage=home"><img id="logo" alt="LOGO" src="img/logo/logo.png"></a>
		<fieldset id="loginBox" >
			<p id="loginP">로그인</p>
			<input type="hidden" value="<%=back %>" name="back"><br>
			<div>
				<div id="inpTop">
					<input class="inputBox" type="text" placeholder="아이디" name="id" id="id"><br>
				</div>
				<div id="inpBot">
					<input class="inputBox" type="password" placeholder="비밀번호" name="pw" id="pw"><br>
				</div>
			</div>
			<p id="warning"></p>
			<input id="loginBtn" type="button" value="로그인">	
		</fieldset>
	</form>
	<div style="text-align: left; width: 410px; margin: 0 auto;">
		<a href="resister.jsp" style="text-decoration: none; color: black; ">
			계정이 아직 없다면?&nbsp;&nbsp;
			<span class="subBtn">회원가입</span>
		</a>
	</div>
</div>
<script type="text/javascript">
	/* 각각 입력창에 대한 꾸미기 */
	$("#id").focus(function(e){
		$("#inpTop").css("border", "solid 1px rgb(69,56,40)");
		$("#inpTop").css("outline", "solid 1px rgb(69,56,40)");
		$("#inpBot").css("borderTop", "none");
	})
	$("#id").blur(function(e){
		$("#inpTop").css("border", "solid 1px rgb(69,56,40)");
		$("#inpTop").css("borderBottom", "none");
		$("#inpTop").css("outline", "none");
		$("#inpBot").css("borderTop", "solid 1px rgb(69,56,40)");
	})
	$("#pw").focus(function(e){
		$("#inpBot").css("border", "solid 1px rgb(69,56,40)");
		$("#inpBot").css("outline", "solid 1px rgb(69,56,40)");
		$("#inpTop").css("borderBottom", "none");
	})
	$("#pw").blur(function(e){
		$("#inpBot").css("border", "solid 1px rgb(69,56,40)");
		$("#inpBot").css("borderTop", "none");
		$("#inpBot").css("outline", "none");
		$("#inpTop").css("borderBottom", "solid 1px rgb(69,56,40)");
	})
	/* 로그인 버튼을 눌렀을때의 처리 */
	var inputBox = document.getElementsByClassName("inputBox");
	var back = "<%=back%>";
	var status ;
	$("#loginBtn").click(function(e){
		e.preventDefault();
		for(var i = 0 ; i < inputBox.length ; i ++){
			/* 입력창의 유효성 검사와 처리 */
			if(!inputBox[i].value){
				$("#warning").text(inputBox[i].placeholder+"가 입력되지 않았습니다.");
				return;
			}
		}
		$.ajax({
			type:"post",
			url:"http://localhost:8081/webtoon/LoginPro",
			data:{
				id:$("#id").val(),
				pw:$("#pw").val(),
				back:back
			},
			success: function(data){
				status = data;
				if(status == "success"){
					location.href = back;
				}else{
					$("#warning").text("아이디 혹은 비밀번호가 일치하지 않습니다.");
				}
			},
			error:function(){
				alert("오류");
			}
		});
	})
</script>
</body>
</html>