<%@page import="java.util.ArrayList"%>
<%@page import="com.humanwebtoon.vo.BannerInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<BannerInfo> sideBannerList = (ArrayList<BannerInfo>)request.getAttribute("sideBannerList");
if(sideBannerList == null){
%>
<jsp:forward page="BannerLoadPro?pos=side"/>
<%} 
int ran = (int)(Math.random()*sideBannerList.size());
%>
<img alt="사이드 배너칸" id="sideBannder" width="100%" style="cursor: pointer;">
<script>
	var ran = <%=ran%>+1;
	$("#sideBannder").attr("src","img/banner/side"+ran+".jpg");
	$("#sideBannder").click(function() {
		location.href="<%=sideBannerList.get(ran).getLink()%>";
	});
</script>