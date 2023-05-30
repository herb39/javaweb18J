<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	pageContext.setAttribute("newLine", "\n");
	int level = session.getAttribute("sLevel") == null ? 101 : (int) session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
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
			background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center fixed;
			background-size: cover;
		}
		#cBox {
			height: 130px;
			background-color: rgba( 255, 255, 255, 0.5 );
			text-align:center;
			line-height: 110px;
			font-size: 30px;
		}
	
	</style>
	<script>
		'use strict';
		
		// 댓글쓰기 (aJax)
		function replyCheck(board1Idx) {
			console.log("board1Idx: " + board1Idx);
			let content = $("#content").val();
			if (content.trim() == "") {
				alert("댓글을 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query = {
					board1Idx	: board1Idx,
					mid			: '${sMid}',
					nickName	: '${sNickName}',
					content		: content,
					level		: ${level}
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/Board1ReplyInput.tsb",
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
		
		// 댓글삭제
		function replyDelete(replyIdx) {
			let ans = confirm("댓글을 삭제하시겠습니까?");
			if (!ans) return false;
			
			$.ajax({
				type	:"post",
				url		:"${ctp}/Board1ReplyDelete.tsb",
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
		}
		
		// 댓글 좋아요
		function goodCheck(replyIdx) {
			$.ajax({
				type	: "post",
				url		: "${ctp}/Board1ReplyGoodCheckAjax.tsb",
				data	: {replyIdx : replyIdx},
				success	: function(res) {
					if (res == "0") alert("이미 '좋아요'를 누르셨습니다.");
					else location.reload();
				},
				error	: function() {
					alert("전송 오류");
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
	<p><br /></p>
	<div class="container">
		<h2 class="text-center">${vo.title}</h2>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td colspan="2" class="text-left">
					<c:if test="${flag != 'search'}">
						<input type="button" value="홈으로" onclick="location.href='${ctp}/';" class="btn btn-primary" /> &nbsp;
					</c:if>
				</td>
				<td class="text-right">
					<span class="badge badge-pill badge-secondary">LV.${vo.level}</span> ${vo.nickName}
				</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<td id="cBox">${fn:replace(vo.content, newLine, "<br />")}</td>
			</tr>
		</table>
		
		<!-- 비회원 댓글 작성 제한 -->
		<c:if test="${level > 100}">
			<div style="text-align:center;"><b>댓글을 작성하려면 <a type="text" data-toggle="modal" data-target="#loginModal" style="cursor:pointer; color:blue;">로그인</a>하세요!</b></div><br />
		</c:if>
		
		<!-- 댓글 리스트 -->
		<div class="container">
			<table class="table table-hover text-left">
				<tr>
					<th>작성자</th>
					<th>내용</th>
					<th>작성시간</th>
					<th>좋아요</th>
					
				</tr>
				<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
					<tr>
						<td class="text-center col-2"><span class="badge badge-pill badge-secondary">LV.${replyVo.level}</span> ${replyVo.nickName}
							<c:if test="${sMid == replyVo.mid || sLevel == 0 || sLevel == 100}">
								<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제" id="deleteReply" style="color: red"><b>&times;</b></a>
							</c:if>
						</td>
						<td>${fn:replace(replyVo.content, newLine, "<br />")}</td>
						<td class="text-center col-3">${fn:substring(replyVo.wDate, 0, 16)}</td>
						<td class="text-center col-1">
							<c:if test="${level <= 100}">
								<a href="javascript:goodCheck(${replyVo.idx})">
									<c:if test="${sSw == '1'}"><font color="#f00">❤</font></c:if>
									<c:if test="${sSw != '1'}"><font color="#000">❤</font></c:if>
								</a>
							</c:if>
							${replyVo.good}
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<c:if test="${level <= 100}">
			<!-- 댓글 입력 -->
			<form name="replyForm">
				<table class="table table-center">
					<tr>
						<td style="width: 85%" class="text-left">
							<span>${sNickName}님의 의견을 들려주세요!</span> &nbsp;
							<input type="button" value="댓글작성" onclick="replyCheck(${vo.idx})" class="btn btn-info btn-sm" />
							<textarea rows="4" name="content" id="content" class="form-control mt-2"></textarea>
						</td>
						<td style="width: 15%">
							<br />
						</td>
					</tr>
				</table>
			</form>
		</c:if>
		
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>