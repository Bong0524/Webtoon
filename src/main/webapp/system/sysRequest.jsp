<%@page import="com.humanwebtoon.vo.RequestInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
td{
	text-align: center;
}
</style>
<%
ArrayList<RequestInfo> requestList = (ArrayList<RequestInfo>)request.getAttribute("requestList");
/* requestList가 null일 경우 requestList를 불러오기위해 RequestListPro를 호출한다. */
if(requestList == null){
%>
<jsp:forward page="../RequestListPro" />
<%}else{if(requestList.size() == 0){%>	
<h2 style="width: 400px; margin: 80px auto;">
	-- 연재 신청된 웹툰이 없습니다. --
</h2>
<%}else{%>
<form name="responseForm" action="../ResponsePro" method="post" style=" width: 80%; text-align: center; margin: 30px auto;">
	<table id="pageList" style=" border-spacing: 0; border-collapse: collapse; width: 100%;">
		<tr>
			<td width="100px">썸네일</td>
			<td>제목</td>
			<td width="150px">신청일</td>
			<td width="170px">관리ID</td>
			<td width="80px">승인/삭제</td>
		</tr>
		<%	
		/* RequestListPro에서 받아온 ArrayList를 이용해 페이지를 뿌린다. */
		for(int i = 0 ; i < requestList.size() ; i++) {
		RequestInfo reqToon = requestList.get(i);
		%>
		<tr style="border-top: 1px solid #444444;">
			<td style="padding: 10px 10px">
				<a onclick="reqToon('<%=reqToon.getWriter()%>');return false;">
					<img alt="<%=reqToon.getWriter()%> 썸네일" src="../img/request/<%=reqToon.getWriter()%>/subThumbnail.jpg" width="80px" height="80px">
				</a>
			</td>
			<td style="text-align: left; padding-left: 30px">
				<a onclick="reqToon('<%=reqToon.getWriter()%>');return false;"><%=reqToon.getSubTitle() %></a>
			</td>
			<td>
				<p><%=reqToon.getWrdate() %></p>
			</td>
			<td>
				<input type="text" style="width: 100px; font-size: 1.2em;" name="toon_id" class="toon_id">
				<span style="font-size: 0.8em;"></span>
			</td>
			<td>
				<input id="<%=reqToon.getWriter()%>" value="<%=reqToon.getWriter()%>" class="checkBox" type="checkbox" name="checkedBox"  style="width: 25px; height: 25px; vertical-align:bottom;">
				<input id="result" name="result" type="hidden">
			</td>
		</tr>
		<%} %>
	</table>
<%}}%>
	<div style="margin: 10px; float: right;">
		<input id="agree" class="responseBtn btn" type="button" value="승인">
		<input id="delete" class="responseBtn btn" type="button" value="삭제">
	</div>
</form>
<script>
/* 신청작 확인을 위한 창을 띄운다 */
function reqToon(writer){
	window.open("../RequestToon?writer="+writer+"", "ReadReq", "width=755,height=800, left=200,top=100");
}

/* 아이디칸의 내용이 바꼇을경우 체크박스를 작동시키고, 중복확인한다. */
$(".toon_id").change(function() {
	let inp = this
	$.ajax({
		type : "post",
		url : "http://localhost:8081/webtoon/ToonOverlap",
		data:{
			toon_id : $(this).val()
		},
		success: function(data) {
			inp.nextElementSibling.innerHTML = data;
		}
	})
})
/* 아이디칸 입력시 자동 체크 */
$(".toon_id").keydown(function() {
	$(this).parent().next().children().first().prop("checked","true");
})


/* 체크시 사용불가 전환 및 체크해제시 아이디칸 초기화 */
$(".checkBox").change(function(){
	if($(this).is(":checked")){
		$(this).parent().prev().children().last().text("사용불가");
	}else{
		$(this).parent().prev().children().last().text("");
		$(this).parent().prev().children().first().val("");
	}
});

/* 체크된 항목의 한에 유효성 검사 및 서브밋*/
var checkBox = document.getElementsByClassName("checkBox");
$(".responseBtn").click(function(e) {
	e.preventDefault;
	$("#result").val($(this).val());
	if($(this).val()=="승인") {
		for(var i = 0 ; i < checkBox.length ; i++){
			if(checkBox[i].checked){
				if(checkBox[i].parentElement.previousElementSibling.firstElementChild.value == ""
				|| checkBox[i].parentElement.previousElementSibling.lastElementChild.innerHTML == "사용불가"
				){
					alert("체크된 항목중 사용 불가능하거나 공백인 칸이 있습니다. 변경후 다시 시도해주세요.");
					return;
				}else responseForm.submit();
			}
		}
	}else if($(this).val()=="삭제"){
		let cnt = 0;
		for(var i = 0 ; i < checkBox.length ; i++){
			if(checkBox[i].checked) cnt++;
		}
		if(cnt > 0) responseForm.submit();
	}
})
</script>
