<%@page import="com.humanwebtoon.pro.ToonPage"%>
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
Cookie seen = new Cookie(toonpage.getToon_id(),toonpage.getPage_num()+"");
seen.setMaxAge(60*60*30);
response.addCookie(seen);
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
	margin: 90px auto 0;
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
	width: 80px;
}
#control{
	position: fixed; 
	background-color: #ccc; 
	padding: 5px; 
	border-radius: 10px; 
	right: 30px; 
	top: 400px;
	display: flex;
	flex-direction: column;
}

.scoreView{
	position: absolute;
	left: 0;
	top: 0;
	font-size: 28px;
}
.scoreInp{
	position: absolute;
	left: 0;
	top: 0;
	font-size: 42px;
}

#scoreInp{
	position: absolute;
	left: 0;
	top: 0;
	opacity: 0; 
	width: 210px;
	height: 56px;
	vertical-align: bottom;
	border-radius: 5px;
}
.scoreBtn{
	width: 49%;
	height: 55px;
	border: none;
	border-radius: 4px;
}

</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div id="container">
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
		
		<!-- 별점 -->
		<div id="scoreViewBox" style="height: 37px; width: 600px; margin: 30px auto;">
			<div style="position: relative; width: 140px; display: inline-block; height: 100%; vertical-align: bottom;">
				<span class="scoreView" style="color: #ccc;">★★★★★</span>
				<span class="scoreView" id="scoreView" style="color: red; width: <%=toonpage.getScore()*14%>px; overflow: hidden;">★★★★★</span>
			</div>
			<span id="scoreViewNum" style="font-size: 1.5em; font-weight: bold;"><%=toonpage.getScore() %></span>
			<input id="scoreOpenBtn" type="button" value="별점주기" style="padding: 3px; margin-left: 10px; vertical-align: bottom;">
		</div>
		
		<!-- 별점입력 -->
		<div id="scoreBack" style="width: 100%;height: 100%; background-color: #00000055; position: fixed; left: 0; top: 0; z-index: 1; display: none"></div>
		<div id="scoreInpPop" style="z-index: 10; top: 20%; left: 50%; position: fixed; display: none;
			width: 400px; height: 300px; background-color: white; transform: translateX(-50%); border-radius: 5px;">
			<p style="border-bottom: 1px solid #aaa; text-align: center; padding: 10px; font-size: 1.5em;">별점 주기</p>
			<p id="socoreInpNum" style="margin-top: 20px; font-size: 2em; font-weight: bold; text-align: center;">10</p>
			<div id="scoreInpBox" style="width: 210px; height: 56px; position: relative; margin: 0 auto;">
				<span class="scoreInp" style="color: #ccc;">★★★★★</span>
				<span class="scoreInp" id="scoreInpView" style="color: red; width: 210px; overflow: hidden;">★★★★★</span>
				<input id="scoreInp" type="range" value="10" step="1" min="0" max="10">
			</div>
			<p style="margin: 10px; text-align: center; font-size: 1.2em; color: #ccc; font-weight: bold">좌우로 드래그 하세요.</p>
			<div id="scoreBtnBox" style="text-align: center; position: absolute; bottom: 0; width: 100%; padding: 15px; display: flex; justify-content: space-between;">
				<input class="scoreBtn" id="scoreBtn" type="button" value="별점남기기" style="color: #ddd; background-color: rgb(69, 56, 40);">
				<input class="scoreBtn" id="closeScore" type="button" value="창닫기">
			</div>
		</div>
		
		  
		<!-- 댓글창 -->
		<div style="width: 600px; margin: 10px auto;">
				<!-- 댓글을 달 웹툰 페이지의 id -->
				<input type="hidden" id="target" name="target" value="<%=toonpage.getPage_id()%>">
				<input id="commentBtn" type="button" value="댓글 등록" style="margin-right: 5px; height: 80px; width: 80px; border-radius: 2px; background: rgb(69,56,40); color: #ddd;">
				<textarea id="comment" name="comment" style="resize: none; vertical-align: bottom; padding: 5px; width: 509px; height: 80px;"></textarea>
		</div>
	
		<!-- 웹툰 리모컨 -->
		<div id="control">
			<input class="controlBtn" type="button" value="목록" onclick="location.href = 'WebtoonPro?toon=<%=toonpage.getToon_id()%>'">
			<input class="controlBtn pageBtn" type="button" value="다음화">
			<input class="controlBtn pageBtn" type="button" value="이전화">
			<input class="controlBtn" type="button" value="홈으로" onclick="location.href ='index.jsp?inPage=home'">
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
	var back = location.pathname+location.search;
	back = back.replace("&", "%26");
	$("#comment").click(function(e) {
		e.preventDefault();
		$("#commentBtn").attr("disabled", "disabled");
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
	
	
	/* 로그인 했을경우 별점창 열기 */
	$("#scoreOpenBtn").click(function(e) {
		e.preventDefault();
	<%if(user!=null){%>
		$("#scoreBack").css("display","inline-block");
		$("#scoreInpPop").css("display","inline-block");
	})
	/* 별점등록여부 */
	var did;
	$.ajax({
		type:"post",
		url:"http://localhost:8081/webtoon/ScoreAlreadyPro",
		data:{
			target:$("#target").val()
		},
		success: function(data){
			did = data;
			$("#scoreInpView").css("width",data*21);
			$("#socoreInpNum").text(data == "none" ? 10 : data);
		},
		error: function(){
			alert("오류");
		}
	});
	
	/* 별점창 닫기 */
	function scoreClose() {
		$("#scoreBack").css("display","none");
		$("#scoreInpPop").css("display","none");
	}
	$("#closeScore").click(function() {
		scoreClose();
	});
	$("#scoreBack").click(function() {
		scoreClose();
	});

	/* 드래그시 별점 변경 */
	$("#scoreInp").on('input', function() {
		$("#scoreInpView").css("width",$(this).val()*21);
		$("#socoreInpNum").text($(this).val());
	})
	/* 별점전송 ajax */
	$("#scoreBtn").click(function() {
		$.ajax({
			type:"post",
			url:"http://localhost:8081/webtoon/ScorePro",
			data:{
				target:$("#target").val(),
				score:$("#scoreInp").val(),
				did:did
			},
			success: function(){
				scoreClose();
				location.reload();
			},
			error: function(){
				alert("오류");
			}
		});
	<%}else{%>
	/* 로그인 안했을경우 로그인 권장하기 */
		if(confirm("별점을 남기기 위해서 로그인이 필요합니다. \n로그인 하시겠습니까?")){
			location.href = "login.jsp?back="+back;
		}
	<%}%>
	})
	
	</script>
	</body>
</html>