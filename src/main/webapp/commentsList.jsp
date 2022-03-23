<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="com.humanwebtoon.vo.CommentInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
UserInfo user = (UserInfo) session.getAttribute("user");
ArrayList<CommentInfo> commentsList = (ArrayList<CommentInfo>)request.getAttribute("commentsList");
if(commentsList.size()==0){%>
	<div style="text-align: center;">
		댓글이 아직 없습니다. 첫번째 댓글을 달아보세요!
	</div>
<%}
for(int i = 0 ; i < commentsList.size() ; i++){
	CommentInfo comment = commentsList.get(i);
%>
	<div style="border-bottom: 1px solid #aaa; padding: 15px 0;">
		<span style="font-weight: bold;"><%=comment.getWriter_name() %>(<%=comment.getWriter_id() %>)</span>
		<%if(user != null && user.getGrade().equals("관리자")){ %>
		<span onclick="deleteComm(<%=comment.getComm_id() %>)" class="ss" style="margin-left: 5px; cursor: pointer; color: rgb(69, 56, 40); font-weight: bold; font-size: 0.8em;">삭제</span>
		<%} %>
		<p style="margin: 8px 0;"><%=comment.getComments() %></p>	
		<p style="color: #bbb; font-size: 0.9em;"><%=comment.getWrdate() %></p>
	</div>
	
<%}%>
<script type="text/javascript">

function deleteComm(target) {
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"http://localhost:8081/webtoon/CommentDeletePro",
			data:{
				target:target
			},
			success: function(){
				location.reload();
			},
			error: function(){
				alert("오류");
			}
		})
	}
}

</script>
