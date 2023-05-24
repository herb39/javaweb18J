<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	background: url(./images/sea-4768869_1920.jpg) no-repeat center center
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
.fakeimg {
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
				<br />
				<img class="fakeimg" alt="asd" src="https://cdn.pixabay.com/photo/2017/03/08/19/53/stone-2127669_1280.png">
				<br /><br />
				<p>"아무런 위험을 감수하지 않는다면 더 큰 위험을 감수하게 될 것이다."</p>
				<p>- Erica Jong</p>
				<hr class="d-sm-none">
			</div>
			<!-- 주제선정 -->
			<div class="col-sm-9">
				<h2>TITLE HEADING</h2>
				<h5>Title description, Dec 7, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa nostrud exercitation ullamco.</p>
				<br>
				<h2>TITLE HEADING</h2>
				<h5>Title description, Sep 2, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa exercitation ullamco.</p>
			</div>
			<!-- 메인게시판 -->
			<!-- <div class="col-sm-4">
				<h2>TITLE HEADING</h2>
				<h5>Title description, Dec 7, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa nostrud exercitation ullamco.</p>
				<br>
				<h2>TITLE HEADING</h2>
				<h5>Title description, Sep 2, 2017</h5>
				<div class="fakeimg">Fake Image</div>
				<p>Some text..</p>
				<p>Sunt in culpa exercitation ullamco.</p>
			</div> -->
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>