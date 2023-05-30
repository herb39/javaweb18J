<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hello, World!</title>
<jsp:include page="/include/bs4.jsp" />
<style>
	body {
		height: 100%;
		min-height: 600px;
		background: url(./images/paper-g44ca06ba8_1280.jpg) no-repeat center center
			fixed;
		background-size: cover;
	}
	/* body::before {
			content: "";
			opacity: 0.18;
	        position: fixed;
	        min-height: 600px;
			top: 0px;
	        left: 0px;
	        right: 0px;
	        bottom: 0px;
			background-color: #000;
		} */
	.snm {
		text-align: right;
	}
	.sImg {
		width: 100%;
		background: #aaa;
	}
</style>
<script>
	
</script>
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	<div class="container" style="margin-top: 10px">
		<div class="row">
			<!-- 카운트다운 -->
			<div class="col-sm-12" style="text-align: center;">
				<jsp:include page="/include/countDown.jsp" />
			</div>
			<div class="col-sm-3">
				<!-- 명언 -->
				<h3>오늘의 명언</h3>
				<img class="sImg" alt="asd" src="${sayingVo.image}">
				<br /><br />
				<p>${sayingVo.content}</p>
				<p class="snm">${sayingVo.name}</p>
				<hr class="d-sm-none">
			</div>
			<!-- 주제선정 -->
			<div class="col-sm-9">
				
				<h2>주제 선정 게시판</h2>
				
				<c:forEach var="boardVo" items="${boardVos}" varStatus="st">
					<c:if test="${boardVo.day_diff == 0}">
						<table class="table table-hover text-center m-0">
						<tr>
							<td class="text-left">
								<a href="${ctp}/BoardContent.bo?idx=${boardVo.idx}">${boardVo.title}</a>
							</td>
							<td class="col-3 text-left">
								<span class="badge badge-pill badge-secondary">LV.${boardVo.level}</span> ${boardVo.nickName}
							</td>
							<td class="col-2">${fn:substring(boardVo.wDate,11,16)}</td>
							<td class="col-1">❤ ️${boardVo.good}</td>
						</tr>
						</table>
					</c:if>
				</c:forEach>
				<br />
				<h2>토론 게시판</h2>
				<c:forEach var="board1Vo" items="${board1Vos}" varStatus="st">
					<c:if test="${board1Vo.day_diff == 0}">
						<table class="table table-hover text-center m-0">
						<tr>
							<td class="text-left">
								<a href="${ctp}/Board1Content.tsb?idx=${board1Vo.idx}">${board1Vo.title}</a>
							</td>
							<td class="col-3">
								<span class="badge badge-pill badge-secondary">LV.${board1Vo.level}</span> ${board1Vo.nickName}
							</td>
							<td class="col-2">${fn:substring(board1Vo.wDate,0,10)}</td>
						</tr>
						</table>
					</c:if>
				</c:forEach>
				
			</div>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>