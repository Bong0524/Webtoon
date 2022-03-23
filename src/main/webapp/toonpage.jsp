<%@page import="com.humanwebtoon.vo.CommentInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@page import="com.humanwebtoon.vo.ToonpageInfo"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<CommentInfo> commentsList = (ArrayList<CommentInfo>)request.getAttribute("commentsList");
ToonpageInfo toonpage = (ToonpageInfo)request.getAttribute("toonpage");
UserInfo user = (UserInfo)session.getAttribute("user");
if(toonpage==null)
	System.out.println("TOONPAGE NULL");
File[] imgs = toonpage.getImgs();
String target = toonpage.getPage_id();
target = target.replace("_", "%20");
System.out.println(target);
%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<meta charset="UTF-8">
<title><%=toonpage.getPage_num()%>화.&nbsp;<%=toonpage.getTitle() %></title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
#container{
	width: 960px;
	margin: 0 auto;
}
#toonImage{
		width: 600px;
		margin: 0 auto;
}
input {
	cursor: pointer;
}
.controlBtn{
	margin: 5px;
	width: 100px;
}
#control{
	width: 120px; 
	position: fixed; 
	background-color: #ccc; 
	padding: 5px; 
	border-radius: 10px; 
	right: 30px; 
	top: 400px;
}
</style>
</head>
<body>
	<div id="container">
		<jsp:include page="header.jsp"/>
		<div style="margin: 50px">
			<h2 style="background: #eee; padding: 10px"><%=toonpage.getPage_num()%>화.&nbsp;<%=toonpage.getTitle() %></h2>
			조회수 : <%=toonpage.getView_cnt() %>
			<span style="margin: 0 20px;">|</span>
			등록일 : <%=toonpage.getWrdate() %>
		</div>
		<div id="toonImage">
		<%for(int i = 0 ; i < imgs.length-1 ; i++) {%>
			<img alt="<%=i+1 %>페이지" src="img/<%=toonpage.getToon_id()%>/<%=toonpage.getPage_num()%>/<%=imgs[i].getName()%>"style="width: 600px;" >
		<%} %>
		</div>
		
		<!-- 웹툰 리모컨 -->
		<div id="control" style="">
			<input class="controlBtn" type="button" value="목록" onclick="location.href = 'WebtoonPro?toon=<%=toonpage.getToon_id()%>'">
			<input class="controlBtn pageBtn" type="button" value="다음화">
			<input class="controlBtn pageBtn" type="button" value="이전화">
			<input class="controlBtn" type="button" value="홈으로" onclick="location.href ='index.jsp?inPage=home'">
		</div>
		
		<div style="width: 600px; margin: 30px auto;">
				<!-- 댓글을 달 웹툰 페이지의 id -->
				<input type="hidden" id="target" name="target" value="<%=toonpage.getToon_id()+"_"+toonpage.getPage_num()%>">
				<input id="commentBtn" type="button" value="댓글 등록" style="margin-right: 5px; height: 80px; width: 80px; border-radius: 2px; background: rgb(69,56,40); color: #ddd;">
				<textarea id="comment" name="comment" style="resize: none; vertical-align: bottom; padding: 5px; width: 509px; height: 80px;"></textarea>
		</div>
		<div id="commentsBox" style="margin: 0 auto 100px; width: 600px">
			<%if(commentsList!=null){ %>
			<jsp:include page="commentsList.jsp"/>
			<%}else{ %>
			<jsp:forward page="CommentListPro">
				<jsp:param value="<%=toonpage.getToon_id()%>" name="toon"/>
				<jsp:param value="<%=toonpage.getPage_num()%>" name="page"/>
			</jsp:forward>
			<%} %>
		</div>
		<jsp:include page="footer.jsp"/>
	</div>
	<script type="text/javascript">
	
	/* 웹툰컨트롤러 */
	var now = "<%=toonpage.getPage_id()%>";
	var how = "";
	$(".pageBtn").click(function(e) {
		how =  $(this).val()
		e.preventDefault;
		$.ajax({
			type : "post",
			url : "http://localhost:8081/webtoon/WebtoonControlPro",
			data : {
				how : how,
				now : now
			},
			success : function(data) {
				if(data == "none") alert(how+"가 존재하지 않습니다.");
				else location.href = "ToonPage?toon=<%=toonpage.getToon_id()%>&page="+data+"";
			}
		})
	})
	
	
	/* 로그인시 다시 이페이지로 오기위해 주소를 저장한다. */
	/* 주소창의 특수문자는 없어지기때문에 인코딩해서 보낸다. */
	/* 로그인하지 않은 경우 댓글창을 비활성화 시키고 클릭시 로그인을 권유한다 */  
	<%if(user == null){%>
	$("#comment").click(function(e) {
		e.preventDefault();
		$("#commentBtn").attr("disabled", "disabled");
		var back = location.pathname+location.search;
		back = back.replace("&", "%26");
		if(confirm("댓글작성을 위해서 로그인이 필요합니다. \n로그인 하시겠습니까?")){
			location.href = "login.jsp?back="+back;
		}
	})
	<%}%>
	/* 댓글 전송 ajax */
	$("#commentBtn").click(function() {
		$.ajax({
			type:"post",
			url:"http://localhost:8081/webtoon/CommentPro",
			data:{
				target:$("#target").val(),
				comment:$("#comment").val()
			},
			success: function(){
				location.reload();
			},
			error: function(){
				alert("오류");
			}
		});
	})
	</script>
	</body>
</html>