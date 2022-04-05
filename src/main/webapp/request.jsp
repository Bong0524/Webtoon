<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연재신청 페이지</title>
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
#viewThumbnail{
	width: 200px;
	height: 200px;
}
#viewSubThumbnail{
	width: 100px;
	height: 100px;
}
#viewBox{
	width: 600px;
	margin: 0 auto;
}
#btnBox{
	margin: 10px 0; 
	display: flex; 
	width: 100%; 
	height: 40px; 
	justify-content: space-between;
}
.uploadBtn{
	background: rgb(69,56,40); 
	color: #ddd; 
	padding: 4px; 
	border-radius: 3px;
	cursor: pointer;
	width: 23%;
	font-size: 1em;
	line-height: 30px;
	text-align: center;
}
input {
	outline: none;
	border: none;
}
.viewImgs{
	width: 600px;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}
#infoTextarea{
	padding: 10px; 
	border:none; 
	resize: none; 
	font-size: 1.2em; 
	width: 482px; 
	height: 137px;
}
#titleText{
	padding:5px; 
	font-size: 1.5em; 
	border-bottom: 1px solid #ddd; 
	margin-bottom: 20px;
}
</style>
</head>
<body>
/* 작가가 아닌 유저가 업로드 페이지에 들어올경우 돌려보낸다. */
<c:if test="${user.grade eq '작가'}">
	response.sendRedirect("index.jsp");
</c:if>
	<jsp:include page="header.jsp"/>
	<div id="container">
		<form name="requestForm" action="RequestPro" method="post" enctype="multipart/form-data">
			<!-- 웹툰에 대한 소개 -->
			<div id="inputInfo" style="width: 700px; margin: 0 auto;">
			<fieldset style="margin-bottom: 20px; height: 204px;">
				<div id="thumbnailBox" style="width: 200px; height: 200px;float: left; margin-right: 10px;"></div>
				<input class="surely" id="titleText" type="text" name="title" placeholder="제목만 입력해주세요.">
				<textarea class="surely" id="infoTextarea" name="info" placeholder="웹툰에 대한 소개를 써주세요.(승인시 웹툰소개란에 게시 될 내용입니다.)"></textarea>
			</fieldset>
			<!-- 썸네일과 이미지 첨부 -->
			<div id="btnBox">
				<label class="uploadBtn" id="thumbnailBtn" for="thumbnail">웹툰 썸네일 첨부</label>
				<input class="surely" type="file" id="thumbnail" name="thumbnail" style="display: none;" />
				<label class="uploadBtn" id="subThumbnailBtn" for="subThumbnail">1화 썸네일 첨부</label>
				<input class="surely" type="file" id="subThumbnail" name="subThumbnail" style="display: none;" />
				<label class="uploadBtn" id="imgsBtn" for="imgs">1화 이미지 첨부</label>
				<input class="surely" type="file" id="imgs" multiple="multiple" name="imgs" style="display: none;"/>
				<input class="uploadBtn" type="button" value="업로드" onclick="submitBtn(); return false;">
			</div>
			<table style=" text-align: center; border-spacing: 0; border-collapse: collapse;">
				<tr>
					<td width="100px">썸네일</td>
					<td width="280px">제목</td>
					<td width="80px">조회수</td>
					<td width="200px">등록일</td>
				</tr>
				<tr height="100px" style="border-top: 1px solid black;">
					<td style="padding: 10px 20px; width: 140px;height: 124px;">
						<div id="subThumbnailBox"></div>
					</td>
					<td style="text-align: left; padding-left: 20px">
						1화. <input class="surely" type="text" name="subTitle" style="border-bottom: 1px solid #ddd; font-size: 0.95em; width: 200px;" placeholder="1화 제목을 입력해주세요.">
					</td>
					<td width="100px">
						0
					</td>	
					<td width="200px">
						0000-00-00
					</td>
				</tr>
			</table>
			</div>
			<div id="viewBox"></div>
		</form>
		
		<script type="text/javascript">
		
		/* 첨부밭은 썸네일을 미리 볼수 있도록 뿌려주는 함수 */
		var thumbnail = document.getElementById("thumbnail");
		var thumbnailBox = document.getElementById("thumbnailBox");
		thumbnail.onchange = function() {
			/* 변경시마다 썸네일을 비워주는 구문 */
			if(thumbnailBox.hasChildNodes()) thumbnailBox.removeChild( thumbnailBox.firstChild );
			let imgTag = document.createElement('img');
			imgTag.setAttribute('src' , URL.createObjectURL(thumbnail.files[0]));
			imgTag.setAttribute('id' , "viewThumbnail");
			thumbnailBox.appendChild(imgTag);
		}
		
		/* 첨부밭은 서브썸네일을 미리 볼수 있도록 뿌려주는 함수 */
		var subThumbnail = document.getElementById("subThumbnail");
		var subThumbnailBox = document.getElementById("subThumbnailBox");
		subThumbnail.onchange = function() {
			/* 변경시마다 서브썸네일을 비워주는 구문 */
			if(subThumbnailBox.hasChildNodes()) subThumbnailBox.removeChild( subThumbnailBox.firstChild );
			let imgTag = document.createElement('img');
			imgTag.setAttribute('src' , URL.createObjectURL(subThumbnail.files[0]));
			imgTag.setAttribute('id' , "viewSubThumbnail");
			subThumbnailBox.appendChild(imgTag);
		}
		/* 첨부밭은 이미지를 미리 볼수 있도록 뿌려주는 함수 */
		var imgs = document.getElementById("imgs");
		var viewBox = document.getElementById("viewBox");
		imgs.onchange = function() {
			/* 변경시마다 이미지를 비워주는 반복문 */
			while (viewBox.hasChildNodes()){
				viewBox.removeChild( viewBox.firstChild );
			}
			for (var i = 0; i < imgs.files.length; i++) {
				let imgTag = document.createElement('img');
				imgTag.setAttribute('src' , URL.createObjectURL(imgs.files[i]));
				imgTag.setAttribute('class' , "viewImgs");
				viewBox.appendChild(imgTag);
			}
		}
		var surely = document.getElementsByClassName("surely");		
		function submitBtn(){
			for(var i = 0 ; i < surely.length ; i++){
				if(!surely[i].value){
					alert("모든 항목을 채워야합니다.");
					return;
				}
			}
			confirm("정말 완료 하시겠습니까? 신청후 수정 할 수 없으며, 신청후 관리자가 처리하기 전에는 추가 신청 할 수 없습니다.") ? requestForm.submit() : ""; 
		}
		</script>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>