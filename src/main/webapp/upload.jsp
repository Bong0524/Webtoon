<%@page import="com.humanwebtoon.vo.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
UserInfo user = (UserInfo) session.getAttribute("user");
/* 작가가 아닌 유저가 업로드 페이지에 들어올경우 돌려보낸다. */
if (user == null || !user.getGrade().equals("작가")) {
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드</title>
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

#container {
	width: 960px;
	margin: 0 auto;
}

#viewBox {
	width: 600px;
	margin: 0 auto;
}

#thumbnailBox {
	width: 100px;
	height: 100px;
	margin: 0 auto;
}

.uploadBtn {
	background: rgb(69, 56, 40);
	color: #ddd;
	padding: 4px;
	border-radius: 3px;
	cursor: pointer;
	font-size: 1em;
}

input {
	outline: none;
	border: none;
}

.viewImgs {
	width: 600px;
}

#viewThumbnail {
	width: 100px;
	height: 100px;
}

input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

#inputBox {
	width: 700px;
	margin: 50px auto;
}
</style>
</head>
<body>
	<div id="container">
		<jsp:include page="header.jsp" />
		<form name="uploadForm" action="UploadPro" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="toon_id"
				value="<%=request.getParameter("toon")%>">
			<!-- 업로드할 페이지에 대한 정보 -->
			<div id="inputBox">
				<!-- 업로드할 썸네일과 이미지 첨부 -->
				<div id="btnBox" style="margin: 30px 0;">
					<label class="uploadBtn" id="thumbnailBtn" for="thumbnail">썸네일
						첨부</label> <input class="surely" type="file" id="thumbnail"
						name="thumbnail" style="display: none;" /> <label
						class="uploadBtn" id="imgsBtn" for="imgs">이미지 첨부</label> <input
						class="surely" type="file" id="imgs" multiple="multiple"
						name="imgs" style="display: none;" /> <input class="uploadBtn"
						type="button" value="업로드" onclick="submitBtn(); return false;">
				</div>
				<table
					style="text-align: center; border-spacing: 0; border-collapse: collapse;">
					<tr>
						<td width="140px">썸네일</td>
						<td width="280px">제목</td>
						<td width="80px">조회수</td>
						<td width="200px">등록일</td>
					</tr>
					<tr height="100px" style="border-top: 1px solid black;">
						<td style="padding: 10px 20px; width: 140px; height: 124px;">
							<div id="thumbnailBox"></div>
						</td>
						<td style="text-align: left; padding-left: 20px"><input
							class="surely" type="number" id="page" name="page"
							style="font-size: 0.95em; width: 34px; border-bottom: 1px solid #ddd; text-align: right;" />화.&nbsp;
							<input class="surely" type="text" name="title"
							style="border-bottom: 1px solid #ddd; font-size: 0.95em; width: 190px;"
							placeholder="제목을 입력해주세요."></td>
						<td width="100px">0</td>
						<td width="200px">0000-00-00</td>
					</tr>
				</table>
			</div>
			<!-- 첨부시킨 이미지를 뿌려줄(미리보기) 박스 -->
			<br>
			<div id="viewBox"></div>
		</form>
		<script type="text/javascript">
			var status = 1;
			var toon_id = "<%=request.getParameter("toon")%>";
			var page = document.getElementById("page");
			page.onchange = function() {
				console.log(page.value);
				$.ajax({
					type : "post",
					url : "http://localhost:8081/webtoon/PageOverlap",
					data : {
						page : page.value,
						toon_id : toon_id
						
					},
					success : function(data) {
						status = data
					}
				})
			}

			/* 첨부밭은 썸네일을 미리 볼수 있도록 뿌려주는 함수 */
			var thumbnail = document.getElementById("thumbnail");
			var thumbnailBox = document.getElementById("thumbnailBox");
			thumbnail.onchange = function() {
				for (var i = 0; i < thumbnail.files.length; i++) {
					/* 변경시마다 썸네일을 비워주는 구문 */
					if (thumbnailBox.hasChildNodes()) {
						thumbnailBox.removeChild(thumbnailBox.firstChild);
					}
					let imgTag = document.createElement('img');
					imgTag.setAttribute('src', URL
							.createObjectURL(thumbnail.files[i]));
					imgTag.setAttribute('id', "viewThumbnail");
					thumbnailBox.appendChild(imgTag);
				}
			}
			/* 첨부밭은 이미지를 미리 볼수 있도록 뿌려주는 함수 */
			var imgs = document.getElementById("imgs");
			var viewBox = document.getElementById("viewBox");
			imgs.onchange = function() {
				while (viewBox.hasChildNodes()) {
					viewBox.removeChild(viewBox.firstChild);
				}
				for (var i = 0; i < imgs.files.length; i++) {
					/* 변경시마다 이미지를 비워주는 반복문 */
					let imgTag = document.createElement('img');
					imgTag.setAttribute('src', URL.createObjectURL(imgs.files[i]));
					imgTag.setAttribute('class', "viewImgs");
					viewBox.appendChild(imgTag);
				}
			}
			var surely = document.getElementsByClassName("surely");
			function submitBtn() {
				for (var i = 0; i < surely.length; i++) {
					if (!surely[i].value) {
						alert("모든 항목을 채워야합니다.");
						return;
					}if(status > 0){
						alert("이미 등록되어 있는 화입니다.");
						return;
					}
				}
				confirm("정말 완료 하시겠습니까? 삭제를 원하실 경우 관리자에게 요청해야 합니다.") ? uploadForm.submit(): "";
			}
		</script>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>