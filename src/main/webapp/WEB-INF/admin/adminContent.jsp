<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminContent.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		body {
			height: 100%;
			min-height: 600px;
			background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center fixed;
			background-size: cover;
		}
	</style>
</head>
<body>
	<p><br /></p>
	<div class="container">
		<p style="font-size:30px;">관리자 / 운영자 페이지입니다.</p>
		<p></p>
		<p></p>
		<p></p>
		<br />
		<br />
		<p>회원 리스트</p>
		<p>회원 레벨 변경 / 회원 탈퇴 관리</p>
	</div>
	<p><br /></p>
</body>
</html>