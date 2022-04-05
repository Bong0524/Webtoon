<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty sideBannerList}">
	<jsp:forward page="BannerLoadPro?pos=side"/>
</c:if>
<c:if test="${fn:length(sideBannerList) ne 0}">
<c:set var="ran"><%=Math.random()%></c:set>
<fmt:parseNumber var="num" integerOnly="true" type="number" value="${ran * fn:length(sideBannerList)}" />
<img alt="사이드 배너칸" id="sideBanner" width="100%" style="cursor: pointer;">
<script>
	$("#sideBanner").attr("src","img/banner/${sideBannerList[num].banner_id}.jpg");
	$("#sideBanner").click(function() {
		location.href="${sideBannerList[num].link}";
	});
</script>
</c:if>