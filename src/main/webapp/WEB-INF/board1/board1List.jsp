<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	int level = session.getAttribute("sLevel") == null ? 101 : (int) session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>board1List.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		body {
			height: 100%;
			min-height: 600px;
			background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center fixed;
			background-size: cover;
		}
		
		/* body::before {
				content: "";
				opacity: 0.2;
		        position: fixed;
		        min-height: 600px;
				top: 0px;
		        left: 0px;
		        right: 0px;
		        bottom: 0px;
				background-color: #000;
			} */
	</style>
	<script>
		'use strict';
	
		function pageCheck() {
			let pageSize = document.getElementById("pageSize").value;
			location.href = "${ctp}/Board1List.tsb?pag=${pag}&pageSize=" + pageSize;
		}
	
		function searchCheck() {
			let searchString = $("#searchString").val();
	
			if (searchString.trim() == "") {
				alert("검색어를 입력하세요.");
				searchForm.searchString.focus();
			} else {
				searchForm.submit();
			}
		}
	
		function boardInputCheck() {
			alert("로그인 후 이용해주세요.");
			$('#loginModal').modal('show');
	
		}
	</script>
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	<p><br /></p>
	<div class="container">
		<h2 class="text-center">토 론 &nbsp;&nbsp;게 시 판</h2>
		<table class="table table-borderless">
			<tr>
				<td class="text-right">
					<!-- 한페이지 분량처리 -->
					<select name="pageSize" id="pageSize" onchange="pageCheck()">
						<option <c:if test="${pageSize == 3}">selected</c:if>>3</option>
						<option <c:if test="${pageSize == 5}">selected</c:if>>5</option>
						<option <c:if test="${pageSize == 10}">selected</c:if>>10</option>
						<option <c:if test="${pageSize == 15}">selected</c:if>>15</option>
						<option <c:if test="${pageSize == 20}">selected</c:if>>20</option>
					</select> 건
				</td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th class="col-1">번호</th>
				<th class="col-5">제목</th>
				<th class="col-3">작성자</th>
				<th class="col-2">날짜</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td>${curScrStartNo}</td>
						<td class="text-left">
							<a href="${ctp}/Board1Content.tsb?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
				        	<c:if test="${vo.replyCount != 0}">(${vo.replyCount})</c:if>
						</td>
						<td>
							<span class="badge badge-pill badge-secondary">LV.${vo.level}</span> ${vo.nickName}
						</td>
						<td>${fn:substring(vo.wDate,0,10)}</td>
					</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			</c:forEach>
			<tr>
				<td colspan="6" class="m-0 p-0"></td>
			</tr>
		</table>
		
		<!-- 블록 페이징 처리 -->
		<div class="text-center m-4">
			<ul class="pagination pagination-sm justify-content-center">
				<c:if test="${pag > 1}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=1">첫페이지</a>
					</li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${curBlock*blockSize + 1}"
					end="${curBlock*blockSize + blockSize}" varStatus="st">
					<c:if test="${i <= totPage && i == pag}">
						<li class="page-item active">
							<a class="page-link text-white bg-secondary border-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=${i}">${i}</a>
						</li>
					</c:if>
					<c:if test="${i <= totPage && i != pag}">
						<li class="page-item">
							<a class="page-link text-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=${i}">${i}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a>
					</li>
				</c:if>
				<c:if test="${pag < totPage}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/Board1List.tsb?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a>
					</li>
				</c:if>
			</ul>
		</div>
		
		<!-- 검색 -->
		<div class="container text-center">
			<form name="searchForm" method="post" action="${ctp}/Board1Search.tsb">
				<b>검색</b>&nbsp; 
				<select name="search">
					<option value="title" selected>제목</option>
					<option value="nickName">작성자</option>
					<option value="content">내용</option>
				</select>&nbsp; 
				<input type="text" name="searchString" id="searchString" />&nbsp;
				<input type="button" value="검색" onclick="searchCheck()" class="btn btn-primary btn-sm" /> 
				<input type="hidden" name="pag" value="${pag}" /> 
				<input type="hidden" name="pageSize" value="${pageSize}" />
			</form>
		</div>
		
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>