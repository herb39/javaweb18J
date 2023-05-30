<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMemberList.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		body {
			height: 100%;
			min-height: 600px;
			background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center fixed;
			background-size: cover;
		}
	</style>
	<script>
		'use strict';
		
		if (${pag} > ${totPage}) location.href="${ctp}AdminMemberList.ad?pag=${totPage}&pageSize=${pageSize}";
		
		function pageCheck() {
			let pageSize = document.getElementById("pageSize").value;
			location.href = "${ctp}/AdminMemberList.ad?pag=${pag}&pageSize="+pageSize;
		}
		
		function levelChange(e) {
			let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
			if (!ans) {
				location.reload();
				return false;
			}
			
			let items = e.value.split("/");
			let query = {
				idx		: items[1],
				level	: items[0]
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/AdminMemberLevelChange.ad",
				data	: query,
				success	: function(res) {
					if (res == "1") {
						alert("등급 수정 완료");
						location.reload();
					} else {
						alert("등급 수정 실패");
					}
				},
				error	: function() {
					alert("전송 오류");
				}
			});
		}
		
		function memberDelete(idx) {
			let ans = confirm("선택한 회원을 삭제하시겠습니까?");
			if (!ans) return false;
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/AdminMemberDelete.ad",
				data	: {idx : idx},
				success	: function(res) {
					alert("회원 삭제 완료");
					location.reload();
				},
				error	: function() {
					alert("전송 오류");
				}
			});
		}
	</script>
</head>
<body>
	<p><br /></p>
	<div class="container">
		<h2>전체 회원 리스트</h2>
		<br />
		
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td class="text-right">
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
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>성명</th>
				<th>레벨</th>
				<th>탈퇴여부</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${curScrStartNo}</td>
					<td><a href="${ctp}/AdminMemberInfor.ad?mid=${vo.mid}&pag=${pag}&pageSize=${pageSize}">${vo.mid}</a></td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>
						<form name="levelForm">
							<select name="level" onchange="levelChange(this)">
								<option value="0/${vo.idx}" ${vo.level==0 ? "selected" : ""}>관리자</option>
								
									<c:forEach var="i" begin="1" end="99">
										<option value="${i}/${vo.idx}" ${vo.level == i ? 'selected' : ''}>${i}</option>
									</c:forEach>
								
								
								<option value="3/${vo.idx}" ${vo.level==100 ? "selected" : ""}>운영자</option>
							</select>
						</form>
					</td>
					<td>
						<c:if test="${vo.userDel == 'OK'}">
							<font color="red"><b>탈퇴신청</b></font>
								<a href="javascript:memberDelete(${vo.idx})">x</a>
						</c:if>
						<c:if test="${vo.userDel == 'NO'}">활동중</c:if>
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			</c:forEach>
			<tr><td colspan="8" class="m-0 p-0"> </td></tr>
		</table>
		<!-- 블록 페이징 처리 -->
		  <div class="text-center m-4">
			  <ul class="pagination pagination-sm justify-content-center">
			    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
			    <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li></c:if>
			    <c:forEach var="i" begin="${curBlock*blockSize + 1}" end="${curBlock*blockSize + blockSize}" varStatus="st">
			      <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
			      <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a></li></c:if>
			    <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/AdminMemberList.ad?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li></c:if>
			  </ul>
		  </div>
	</div>
	<p><br /></p>
</body>
</html>