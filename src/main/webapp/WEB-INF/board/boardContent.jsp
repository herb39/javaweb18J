<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boardContent.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		th {
			text-align: center;
		}
		body {
		height: 100%;
		min-height: 600px;
		background: url(./images/sea-4768869_1920.jpg) no-repeat center center fixed;
		background-size: cover;
	}
	</style>
	<script>
		'use strict';
		
		function goodCheck() {
			$.ajax({
				type	: "post",
				url		: "${ctp}/BoardGoodCheckAjax.bo",
				data	: {idx : ${vo.idx}},
				success	: function(res) {
					if (res == "0") alert("이미 '좋아요'를 누르셨습니다.");
					else location.reload();
				},
				error	: function() {
					alert("전송 오류");
				}
			});
		}
		
		function boardDelete() {
			let ans = confirm("게시글을 삭제하시겠습니까?");
			if (ans) location.href="${ctp}/BoardDelete.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&nickName=${vo.nickName}";
		}
		
		/* // 댓글쓰기 (aJax)
		function replyCheck() {
			let content = $("#content").val();
			if (content.trim() == "") {
				alert("댓글을 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query = {
					boardIdx	: ${vo.idx},
					mid			: '${sMid}',
					nickName	: '${sNickName}',
					content		: content,
					hostIp		: '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/BoardReplyInput.bo",
				data	: query,
				success	: function(res) {
					if (res == "1") {
						alert("댓글 작성 완료");
						location.reload();
					} else {
						alert("댓글 작성 실패");
					}
				},
				error	: function() {
					alert("전송 오류");
				}
				
			});
		}
		
		// 댓글삭제 (aJax)
		function replyDelete(replyIdx) {
			let ans = confirm("댓글을 삭제하시겠습니까?");
			if (!ans) return false;
			
			$.ajax({
				type	:"post",
				url		:"${ctp}/BoardReplyDelete.bo",
				data	:{replyIdx: replyIdx},
				success	:function(res) {
					if (res == "1"){
						alert("댓글 삭제 완료");
						location.reload();
					} else {
						alert("댓글 삭제 실패");
					}
				},
				error	:function() {
					alert("전송 오류");
				}
			});
		} */
	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
	<p><br /></p>
	<div class="container">
		<h2 class="text-center">내 용</h2>
		<br />
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td class="text-right">접속IP : ${vo.hostIp}</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>작성자</th>
				<td>
					<span class="badge badge-pill badge-secondary">LV.${vo.level}</span> ${vo.nickName}
				</td>
				<th>작성시간</th>
				<td>${fn:substring(vo.wDate, 11, fn:length(vo.wDate)-5)}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${vo.title}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.readNum}</td>
				<th>좋아요</th>
				<td>
					${vo.good}
					(<a href="javascript:goodCheck()">
						<c:if test="${sSw == '1'}"><font color="#f00">❤</font></c:if>
						<c:if test="${sSw != '1'}"><font color="#000">❤</font></c:if>
					</a>️)
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" style="height: 220px">${fn:replace(vo.content, newLine, "<br />")}</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<c:if test="${flag == 'search'}">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/BoardSearch.bo?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
					</c:if>
					<c:if test="${flag != 'search'}">
						<input type="button" value="목록으로" onclick="location.href='${ctp}/BoardList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" /> &nbsp;
						<c:if test="${sMid == vo.mid || sLevel == 0}">
							<input type="button" value="수정" onclick="location.href='${ctp}/BoardUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" /> &nbsp;
							<input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger" />
						</c:if>
					</c:if>
				</td>
			</tr>
		</table>
		<c:if test="${flag != 'search'}">
			<!-- 이전글 / 다음 -->
			<table class="table table-borderless">
				<tr>
					<td>
						<c:if test="${nextVo.nextIdx != 0}">
							👆<a href="${ctp}/BoardContent.bo?idx=${nextVo.nextIdx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${nextVo.nextTitle}</a><br />
						</c:if>
						<c:if test="${preVo.preIdx != 0}">
							👇<a href="${ctp}/BoardContent.bo?idx=${preVo.preIdx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${preVo.preTitle}</a>
						</c:if>
					</td>
				</tr>
			</table>
		</c:if>
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>