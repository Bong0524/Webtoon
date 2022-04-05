<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
<c:forEach var="webtoon" items="webtoonList">
	<fieldset style="margin-bottom: 20px; position: relative; cursor: pointer;" onclick="location.href='WebtoonPro?toon=${webtoon.toon_id}'">
		<img alt="이미지 오류.." src="img/${webtoon.toon_id}/thumbnail.jpg"
			width="200px" height="200px" style="float: left; margin-right: 10px">
		<div style="padding: 5px">
			<h1 style="display: inline;">${webtoon.title}</h1>
			<p style="display: inline;">
				(작가 : ${webtoon.writer})
			</p>
		</div>
		<p style="word-break: keep-all; padding: 10px;">
			${webtoon.info}
		</p>
	</fieldset>
</c:forEach>
</div>