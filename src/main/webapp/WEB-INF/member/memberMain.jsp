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
		#memberInfo1, #memberInfo2 {
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
				<font size="5" color="blue"><b>정회원 등업 조건</b></font>
				<div>
					1. 방명록 5회 이상 작성
					2. 방문 횟수 10회 이상
				</div>
				위의 2가지 조건이 만족되면 정회원으로 자동 등업됩니다.
				<hr />
			</pre>
		</c:if>
		<div id="memberInfo1" class="mr-5">
			<p><span class="badge badge-pill badge-secondary">LV.${level}</span><font color="blue"><b> ${sNickName}</b></font>님 환영합니다.</p>
			<p>누적 포인트 : ${level}<span class="viewCheck">${point}</span></p>
		</div>
		<div id="memberInfo2">
			<p>프로필 사진<br/><img src="${ctp}/images/member/${image}" width="200px" /></p>
		</div>
		<hr id="memberInfo4" />
		<div id="memberInfo3">
			<h4>활동내역</h4>
			<p>방명록 작성 횟수 : <span class="viewCheck">${guestCnt}</span> 건</p>
			<p>게시글 작성 횟수 : <span class="viewCheck">
								<c:if test="${boardCnt == 0}">${boardCnt}</c:if>
								<c:if test="${boardCnt != 0}"><a href="${ctp}/BoardSearchMember.bo">${boardCnt}</a></c:if>						
							  </span> 건</p>
		</div>
		<a class="dropdown-item" href="${ctp}/MemberPwdCheckForm.mem">회원정보수정</a>
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>