<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<UserInfo> userList = (ArrayList<UserInfo>) request.getAttribute("userList");
if(userList == null){%>
<jsp:forward page="../UserListPro"/>
<%} %>
<style>
td {
	padding: 8px;
}
input[type = "text"]{
	border: none;
	border-bottom: 1px solid #ccc;
	background-color: #eee;
	width:100%;
}
</style>
<form action="../UserEditPro" method="post" name="userForm">
	<table style="width: 700px; margin: 30px auto; border-collapse: collapse; text-align: center;">
		<tr style="font-weight: bold;">
			<td width="200px">ID</td>
			<td width="200px">NAME</td>
			<td width="200px">GRADE</td>
			<td width="100px">DELETE</td>
		</tr>
		<%for(int i = 0 ; i < userList.size() ; i++) {
			UserInfo user = userList.get(i);
		%>
		<tr style="border-top: 1px solid #ccc">
			<td><%=user.getId() %></td>
			<td><%=user.getName() %></td>
			<td>
				<select name="grade">
					<option value="'User' where id = '<%=user.getId() %>'" <%if(user.getGrade().equals("User")){%> selected="selected"<%}%>>유저</option>
					<option value="'Writer' where id = '<%=user.getId() %>'" <%if(user.getGrade().equals("Writer")){%> selected="selected"<%}%>>작가</option>
				</select>
			</td>
			<td><input type="checkbox" value="'<%=user.getId() %>'" name="delete" style="width: 20px; height: 20px; vertical-align:bottom;"></td>
		</tr>
		<%}%>
	</table>
	<div style="width: 500px; margin: 10px auto; text-align: center;">
		<input type="hidden" id="req" name="req">
		<input type="button" value="수정" class="btn">
		<input type="button" value="삭제" class="btn">
	</div>
</form>
<script>
	$(".btn").click(function(e) {
		e.preventDeault;
		$("#req").val($(this).val());
		userForm.submit();
	})
</script>


