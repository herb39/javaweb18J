<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberPwdCheckForm.jsp</title>
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
		
		function fCheck() {
			let pwd = document.getElementById("pwd").value;
			
			if (pwd.trim() == "") {
				alert("기존 비밀번호를 입력하세요.");
				document.getElementById("pwd").focus();
			} else {
				pwForm.submit();
			}
		}
	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
	<p><br /></p>
	<div class="container">
		<form name="pwForm" method="post" action="${ctp}/MemberPwdCheckOk.mem" class="was-validated">
			<h2 class="text-center">회원 정보 수정</h2>
			<br />
			<table class="table table-bordered">
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd" id="pwd" autofocus required class="form-control" />
						<div class="invalid-feedback">비밀번호를 입력하세요.</div>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="비밀번호 확인" onclick="fCheck()" class="btn btn-success mr-2" />
						<input type="reset" value="다시입력" class="btn btn-warning mr-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/MemberMain.mem';" class="btn btn-secondary" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	<p><br /></p>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>