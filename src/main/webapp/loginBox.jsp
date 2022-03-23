<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<p style="color: rgb(69,56,40);font-size: 0.9em; font-weight: bold; padding: 5px 0 15px;">여러기능을 사용하고 싶다면?</p>
<input id="loginBtn" type="button" value="로그인">	
<p style="color: rgb(69,56,40);font-size: 0.9em; font-weight: bold; padding-top: 5px;">아직 계정이 없으시다구요?</p>
<input id="resisterBtn" type="button" value="회원가입" onclick="location.href='resister.jsp'">	
<script type="text/javascript">
/* 로그인했을경우 로그인전 페이지로 다시오기위해 경로 저장 */
var back = location.pathname+location.search;
$("#loginBtn").click(function(e) {
	e.preventDefault();
	location.href = "login.jsp?back="+back;
})
</script>