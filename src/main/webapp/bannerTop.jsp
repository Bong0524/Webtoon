<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.vo.BannerInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<BannerInfo> topBannerList = (ArrayList<BannerInfo>)request.getAttribute("topBannerList");
if (topBannerList == null) {%>
<jsp:forward page="BannerLoadPro?pos=top"/>
<%}int ran = (int)(Math.random()*topBannerList.size());%>
<div style="background: rgb(69, 56, 40); width: 60px; height: 100%; float: right; border-left: 1px solid black;">
	<img id="upBanner" src="img/banner/arrow.png" width="60px;" height="50%" style="padding: 30px 0 20px; transform: scaleY(-1);" >
	<img id="downBanner" src="img/banner/arrow.png" width="60px;" height="50%" style="padding: 30px 0 20px; border-top: 1px solid black">
</div>
<div id="bannerBox" style="width: 636px; height: 100%; overflow: hidden;">
	<ul id="bannerScroll">
	<%if(topBannerList.size() != 0){
	for(int i = 0 ; i < topBannerList.size() ; i++){ 
		if(!topBannerList.get(i).getLink().equals("") || topBannerList.get(i).getLink() != null){%>
		<li style="height: 206px; width: 100%;" onclick="location.href = '<%=topBannerList.get(i).getLink()%>'">
			<img alt="탑 배너칸" height="100%" width="365px;" style="float: right;" src="img/banner/<%=topBannerList.get(i).getBanner_id()%>.jpg">
			<h1 style="padding: 5px; font-size: 1.3em"><%=topBannerList.get(i).getTitle()%></h1>
			<p style="padding: 5px; word-break:keep-all"><%=topBannerList.get(i).getIntro()%></p>
		<li>
		<%}}%>
	</ul>
</div>
<script>
/* 랜덤 배너 */
var size = <%=topBannerList.size()%>;
var scroll = Math.floor(Math.random()*size);
$("#bannerScroll").css("marginTop" ,scroll*(-206)+"px" );
/* 업버튼 눌렀을경우 배너 변경 */
$("#downBanner").click(function(e){
	scroll >= size-1 ? scroll = 0 : scroll++;
	$("#bannerScroll").filter(":not(:animated)").animate({ marginTop : scroll*(-206)+"px" },1000);
});
/* 다운버튼 눌렀을경우 배너 변경 */
$("#upBanner").click(function(e){
	scroll <= 0 ? scroll = size-1 : scroll--;
	$("#bannerScroll").filter(":not(:animated)").animate({ marginTop : scroll*(-206)+"px" },1000);
});
/* 10초마다 배너 자동변경 */
setInterval(function() { 
	scroll >= size-1 ? scroll = 0 : scroll++;
	$("#bannerScroll").filter(":not(:animated)").animate({ marginTop : scroll*(-206)+"px" },1000);
}, 15000)
</script>
<%}%>