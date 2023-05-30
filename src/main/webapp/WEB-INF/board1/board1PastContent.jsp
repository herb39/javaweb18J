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
	<title>board1PastContent.jsp</title>
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
			height: 220px;
			background-color: rgba( 255, 255, 255, 0.5 );
			
		}
	</style>
	<script>
	// 댓글삭제 (aJax)
	function replyDelete(replyIdx) {
		let ans = confirm("댓글을 삭제하시겠습니까?");
		if (!ans) return false;
		
		$.ajax({
			type	: "post",
			url		: "${ctp}/Board1ReplyDelete.tsb",
			data	: {replyIdx: replyIdx},
			success	: function(res) {
				if (res == "1"){
					alert("댓글 삭제 완료");
					location.reload();
				} else {
					alert("댓글 삭제 실패");
				}
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
		
		<!-- 댓글 리스트 -->
		<div class="container">
			<table class="table table-hover text-left">
				<tr>
					<th class="col-2">작성자</th>
					<th class="col-1"></th>
					<th class="col-7">내용</th>
					<th class="col-1"></th>
					<th class="col-1">좋아요</th>
				</tr>
				<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
					<tr>
						<td class="text-center col-2"><span class="badge badge-pill badge-secondary">LV.${replyVo.level}</span> ${replyVo.nickName}
							<c:if test="${sLevel == 0 || sLevel == 100}">
								<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제" id="deleteReply" style="color: red"><b>&times;</b></a>
							</c:if>
						</td>
						<td></td>
						<td class="col-7">${fn:replace(replyVo.content, newLine, "<br />")}</td>
						<td></td>
						<td class="text-center col-1">${replyVo.good}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<!-- 이전글 / 다음 -->
		<c:if test="${flag != 'search'}">
			<table class="table table-borderless">
				<tr>
					<td>
						<c:if test="${nextVo.nextIdx != 0}">
							👆<a href="${ctp}/Board1PastContent.tsb?idx=${nextVo.nextIdx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${nextVo.nextTitle}</a><br />
						</c:if>
						<c:if test="${preVo.preIdx != 0}">
							👇<a href="${ctp}/Board1PastContent.tsb?idx=${preVo.preIdx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${preVo.preTitle}</a>
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