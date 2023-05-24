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
	<title>board1Content.jsp</title>
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
		<h2 class="text-center">오늘의 주제</h2>
		<br />
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td colspan="4" class="text-left">
					<c:if test="${flag != 'search'}">
						<input type="button" value="홈으로" onclick="location.href='${ctp}/';" class="btn btn-primary" /> &nbsp;
					</c:if>
				</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>제목</th>
				<td>${vo.title}</td>
				<th>작성자</th>
				<td>
					<span class="badge badge-pill badge-secondary">LV.${vo.level}</span> ${vo.nickName}
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" style="height: 220px">${fn:replace(vo.content, newLine, "<br />")}</td>
			</tr>
		</table>
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>