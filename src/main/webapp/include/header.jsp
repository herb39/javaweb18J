<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	int level = session.getAttribute("sLevel") == null ? 99 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
	nav {
		background-color: rgba( 255, 255, 255, 0.9 )
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
	<a class="navbar-brand" href="http://localhost:9090/javaweb18J/">Hello World</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/GuestList.gu">Guest</a>
			</li>
			<c:if test="${level <= 4}">
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/BoardList.bo">Board</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">PDS</a>
				</li>
				<li>
					<div class="dropdown">
						<button type="button" class="btn text-light dropdown-toggle" data-toggle="dropdown">Study1</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/study/0428_database/login.jsp">로그인연습</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/mapping/Test1">URL 매핑(디렉토리패턴)</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/mapping/Test5.do">URL 매핑(확장자패턴)</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/mapping2/Test5.mi">URL 매핑(확장자패턴)</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/study/0428_database/Login.re">로그인연습2</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/Password.st">암호화 연습</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/UuidForm.st">UUID 연습</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/AjaxTest1">aJax 연습1</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/UserList.st">aJax 연습2</a>
						</div>
					</div>
				</li>
				<li>
					<div class="dropdown">
						<button type="button" class="btn text-light dropdown-toggle" data-toggle="dropdown">Study2</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${ctp}/FileUpLoad1.st">싱글파일 업로드 연습1</a>
							<a class="dropdown-item" href="${ctp}/FileUpLoad2.st">멀티파일 업로드 연습2</a>
							<a class="dropdown-item" href="${ctp}/FileUpLoad3.st">멀티파일 업로드 연습3</a>
							<a class="dropdown-item" href="${ctp}/FileUpLoad4.st">멀티파일 업로드 연습4</a>
							<a class="dropdown-item" href="#">로그인연습3</a>
							<a class="dropdown-item" href="#">Link 3</a>
						</div>
					</div>
				</li>
				<li>
					<div class="dropdown">
						<button type="button" class="btn text-light dropdown-toggle" data-toggle="dropdown">MyPage</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${ctp}/MemberMain.mem">회원 전용 페이지</a>
							<a class="dropdown-item" href="${ctp}/MemberPwdUpdate.mem">비밀번호 변경</a>
							<a class="dropdown-item" href="${ctp}/MemberPwdCheckForm.mem">회원정보수정</a>
							<c:if test="${sLevel != 1}"><a class="dropdown-item" href="${ctp}/MemberList.mem">회원 리스트</a></c:if>
							<a class="dropdown-item" href="javascript:deleteAsk()">회원탈퇴</a>
							<c:if test="${sLevel == 0}"><a class="dropdown-item" href="${ctp}/AdminMain.ad">관리자 메뉴</a></c:if>
						</div>
					</div>
				</li>
			</c:if>
			<li>
				<c:if test="${level > 4}"><input type="button" value="Login" class="btn" data-toggle="modal" data-target="#loginModal" /></c:if>
				<c:if test="${level <= 4}"><a href="${pageContext.request.contextPath}/MemberLogout.mem">Logout</a></c:if>
				<c:if test="${level > 4}"><input type="button" value="Join" class="btn" data-toggle="modal" data-target="#joinModal" /></c:if>
			</li>
		</ul>
	</div>
</nav>
<jsp:include page="/include/memberLogin.jsp" />
<jsp:include page="/include/memberJoin.jsp" />