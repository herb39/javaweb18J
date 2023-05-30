<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberMain.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		body {
			height: 100%;
			min-height: 600px;
			background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center fixed;
			background-size: cover;
		}
	
		.viewCheck {
			color: red;
		}
		#memberInfo1 {
			float: left;
		}
		#memberInfo3, #memberInfo4 {
			clear: both;
		}
	</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
	<p><br /></p>
	<div class="container">
		<h2 class="text-center">회원 전용 페이지</h2>
		<hr />
		<c:if test="${sLevel >= 1 || sLevel < 100}">
			<pre>
				<font size="5" color="blue"><b>레벨업 조건</b></font>
				<div>
					1. 주제선정 게시판의 게시글 좋아요 +1 : +30point
					2. 토론 게시판의 댓글 좋아요 +1 : +20point
				</div>
				100 point를 획득하면 자동으로 레벨업되며,
				회원의 최대 레벨은 99입니다.
				(레벨업 미적용 시 재로그인 해주세요!)
				<hr />
			</pre>
		</c:if>
		<div id="memberInfo1" class="mr-5">
			<p><span class="badge badge-pill badge-secondary">LV.${level}</span><font color="blue"><b> ${sNickName}</b></font>님 환영합니다.</p>
			<p>현재 포인트 : <span class="viewCheck">${point}</span></p>
		</div>
		<hr id="memberInfo4" />
		<div id="memberInfo3">
			<h4>활동내역</h4>
			<p>게시글 작성 횟수 : <span class="viewCheck">
								<c:if test="${boardCnt == 0}">${boardCnt}</c:if>
								<c:if test="${boardCnt != 0}"><a href="${ctp}/BoardSearchMember.bo">${boardCnt}</a></c:if>						
							  </span> 건</p>
		</div>
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>