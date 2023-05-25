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
					<th> &nbsp;작성자</th>
					<th>내용</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
					<tr>
						<td class="text-center"><span class="badge badge-pill badge-secondary">LV.${vo.level}</span> ${replyVO.nickName}
							<c:if test="${sMid == replyVO.mid || sLevel == 0}">
								<a href="javascript:replyDelete(${replyVO.idx})" title="댓글삭제" id="deleteReply" style="color: red"><b>&times;</b></a>
							</c:if>
						</td>
						<td>${fn:replace(replyVO.content, newLine, "<br />")}</td>
						<td class="text-center">${fn:substring(replyVO.wDate, 0, 16)}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>