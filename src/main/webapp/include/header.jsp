<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	int sLevel = session.getAttribute("sLevel") == null ? 101 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("sLevel", sLevel);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/member/memberLogin.jsp" />
<jsp:include page="/WEB-INF/member/memberJoin.jsp" />
<style>
	nav {
		background-color: rgba(255, 255, 255, 0.9);
	}
	
</style>
<script>
	'use strict';
	function deleteAsk() {
		let ans = confirm("정말로 탈퇴하시겠습니까?");
		if (ans) {
			let ans2 = confirm("탈퇴 후 같은 아이디로 1개월간 재가입하실 수 없습니다.\n 계속 진행하시겠습니까?");
			if (ans2) location.href="${ctp}/MemberDeleteAsk.mem";
		}
	}
</script>
<nav class="navbar navbar-expand-sm sticky-top">
	<a class="navbar-brand" href="http://localhost:9090/javaweb18J/Main"><img src="./images/globe-1348777_640.png" style="width: 50px;"> Hello World</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="${ctp}/BoardList.bo">주제선정</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${ctp}/Board1Content.tsb">오늘의주제</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${ctp}/Board1List.tsb">지난주제</a>
			</li>
			<c:if test="${sLevel <= 100}">
			
			
			
			
			
			
			
			
			
			
			<li>
			<a class="memImg" href="${ctp}/MemberMain.mem"><img src="${ctp}/images/member/${image}" width="50px" /></a>
			</li>
			
			
			
			
			
			
			
			
			
			
			
				<li>
					<div class="dropdown">
						<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">MyPage</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${ctp}/MemberMain.mem">회원 전용 페이지</a>
							<a class="dropdown-item" href="${ctp}/MemberPwdUpdate.mem">비밀번호 변경</a>
							<a class="dropdown-item" href="${ctp}/MemberPwdCheckForm.mem">회원정보수정</a>
							<c:if test="${sLevel == 0 || sLevel == 100}"><a class="dropdown-item" href="${ctp}/MemberList.mem">회원 리스트</a></c:if>
							<a class="dropdown-item" href="javascript:deleteAsk()">회원탈퇴</a>
							<c:if test="${sLevel == 0}"><a class="dropdown-item" href="${ctp}/AdminMain.ad">관리자 메뉴</a></c:if>
						</div>
					</div>
				</li>
			</c:if>
			<li>
				<c:if test="${sLevel > 100}">
					<input type="button" value="Login" class="btn" data-toggle="modal" data-target="#loginModal" />
					<input type="button" value="Join" class="btn" data-toggle="modal" data-target="#joinModal" />
				</c:if>
				<c:if test="${sLevel <= 100}"><a href="${pageContext.request.contextPath}/MemberLogout.mem">Logout</a></c:if>
			</li>
		</ul>
	</div>
</nav>
