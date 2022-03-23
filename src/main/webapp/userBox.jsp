<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
UserInfo user = (UserInfo) session.getAttribute("user");
%>
<a href="userEditSelf.jsp" style="float: right;">정보수정</a>
<p style="font-weight: bold"><%=user.getName()%>(<%=user.getGrade()%>)님</p>
<p style="color: rgb(100, 100, 100); font-size: 0.8em"><%=user.getId()%></p>
<%if(user.getGrade().equals("관리자")){%>
<p style="font-size: 0.9em; padding: 5px;">웹툰사이트 관리시스템</p>
<a href="system/system.jsp?=home" target="_blank">
	<input id="logoutBtn" type="button" value="관리창" style="width: 100%; height: 45px; 
	background: rgb(69, 56, 40); color: #ddd; font-weight: bold; font-size: 1.1em; border-radius: 2px;">
</a>
<%}else{%>
<p style="font-size: 0.9em; padding: 5px;">당신도 작가가 되고 싶다면?!</p>
<input type="button" onclick="request();return false;" style="width: 100%; height: 45px;	
background: rgb(69, 56, 40); color: #ddd; font-weight: bold; font-size: 1.1em; border-radius: 2px;" value="연재신청">
<%} %>
<p style="font-size: 0.9em; padding: 5px;">당신의 정보는 소중하답니다!</p>
<input id="logoutBtn" type="button" value="로그아웃" onclick="location.href='LogoutPro'">
<script>
function request() {
	$.ajax({
		type:"post",
		url:"http://localhost:8081/webtoon/RequestAlreadyPro",
		success: function(data){
			data == 0 ? location.href="request.jsp" : alert("한번에 하나의 작품만 신청하실 수 있습니다.\n신청하신 작품을 검토중이니 기다려 주세요.");
		}, //요청 응답에 성공했을경우의 처리 구문
		error:function(){
			alert("실패");
		},
		complete:function(){
			
		}
	});
}
</script>