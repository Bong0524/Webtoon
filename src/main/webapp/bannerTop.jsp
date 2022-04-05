<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${empty topBannerList}">
	<jsp:forward page="BannerLoadPro?pos=top"/>
</c:if>
<div style="background: rgb(69, 56, 40); width: 60px; height: 100%; float: right; border-left: 1px solid black;">
	<img id="upBanner" src="img/banner/arrow.png" width="60px;" height="50%" style="padding: 30px 0 20px; transform: scaleY(-1);" >
	<img id="downBanner" src="img/banner/arrow.png" width="60px;" height="50%" style="padding: 30px 0 20px; border-top: 1px solid black">
</div>
<div id="bannerBox" style="width: 636px; height: 100%; overflow: hidden;">
	<ul id="bannerScroll">
	<c:if test="${fn:length(topBannerList) != 0}">
		<c:forEach var="topBanner" items="${topBannerList }">
			<li style="height: 206px; width: 100%;" onclick="location.href = '${topBanner.link }'">
				<img alt="탑 배너칸" height="100%" width="365px;" style="float: right;" src="img/banner/${topBanner.banner_id }.jpg">
				<h1 style="padding: 5px; font-size: 1.3em">${topBanner.title }</h1>
				<p style="padding: 5px; word-break:keep-all">${topBanner.intro }</p>
			<li>
		</c:forEach>
	</c:if>
	</ul>
</div>
<script>
/* 랜덤 배너 */
var size = ${fn:length(topBannerList)};
var scroll = Math.floor(Math.random()*size);
$("#bannerScroll").css("marginTop" ,scroll*(-206)+"px" );
/* 다운버튼 눌렀을경우 배너 변경 */
$("#downBanner").click(function(e){
	if(!$("#bannerScroll").is(":animated")){
		scroll >= size-1 ? scroll = 0 : scroll++;
		$("#bannerScroll").animate({ marginTop : scroll*(-206)+"px" },1000);
	}
});
/* 업버튼 눌렀을경우 배너 변경 */
$("#upBanner").click(function(e){
	if(!$("#bannerScroll").is(":animated")){
		scroll <= 0 ? scroll = size-1 : scroll--;
		$("#bannerScroll").animate({ marginTop : scroll*(-206)+"px" },1000);
	}
});
/* 10초마다 배너 자동변경 */
setInterval(function() { 
	if(!$("#bannerScroll").is(":animated")){
		scroll >= size-1 ? scroll = 0 : scroll++;
		$("#bannerScroll").animate({ marginTop : scroll*(-206)+"px" },1000);
	}
}, 15000)
</script>
