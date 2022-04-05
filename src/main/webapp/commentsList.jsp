<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${fn:length(commentsList) eq 0}">
	<div style="text-align: center;">
		댓글이 아직 없습니다. 첫번째 댓글을 달아보세요!
	</div>
</c:if>
<c:forEach items="${commentsList }" var="comment">
		<div style="border-bottom: 1px solid #aaa; padding: 15px 0;">
		<span style="font-weight: bold;">
		${comment.writer_name}(${comment.writer_id})
		</span>
		<c:if test="${user.grade eq '관리자'}">
			<span onclick="deleteComm(${comment.comm_id})" class="ss" style="margin-left: 5px; cursor: pointer; color: rgb(69, 56, 40); font-weight: bold; font-size: 0.8em;">삭제</span>
		</c:if>
		<p style="margin: 8px 0;">${comment.comments}</p>	
		<p style="color: #bbb; font-size: 0.9em;">${comment.wrdate}</p>
	</div>
</c:forEach>
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
