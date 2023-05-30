<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberUpdate.jsp</title>
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

	// 아이디 / 닉네임 중복 확인 버튼 눌렀는지 확인 변수 : 버튼 클릭 후 내용 수정 X
	let nickNameCheckSw = 0;
	
	
	function fCheck() {
		// 유효성 검사
		// 닉네임 성명 이메일 전화번호
		
		let regName = /^[가-힣]+$/;
		let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		let name = myform.name.value;
		let email1 = myform.email1.value.trim();
		let email2 = myform.email2.value;
		let email = email1 + "@" + email2;
		
		let submitFlag = 0; // 모든 체크 정상 종료 -> submitFlag : 1로 변경 
		
		// 앞의 정규식으로 정의된 부분에 대한 유효성 체크
		if (!regName.test(name)) {
			alert("성명은 한글만 사용 가능합니다.");	
			myform.name.focus();
			return false;
		} else if (!regEmail.test(email)) {
			alert("이메일 형식에 맞게 작성해주세요.");
			myform.email.focus();
			return false;
		} else {
			submitFlag = 1;
		}
		
		// 전송 전 모든체크 끝나면 submitFlag : 1 -> 서버 전송
		if  (submitFlag == 1) {
			if (nickName == '${sNickName}'){
				nickNameCheckSw = 1;
			}
			if (nickNameCheckSw == 0) {
				alert("닉네임 중복확인 버튼을 누르세요.");
				document.getElementById("nickNameBtn").focus();
			} else {
				myform.email.value = email;
				
				myform.submit();		
			}
		} else {
			alert("형식을 다시 확인하세요.");
		}
	}
	
	// 닉네임 중복 체크
	function nickNameCheck() {
		let nickName = myform.nickName.value;
		let url = "${ctp}/MemberNickNameCheck.mem?nickName=" + nickName;

		if (nickName.trim() == "") {
			alert("닉네임을 입력하세요.");
			myform.nickName.focus();
		} else {
			nickNameCheckSw = 1;
			myform.nickName.readOnly = true;
			window.open(url, "nWin", "width=580px,height=250px");
		}
	}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br /></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/MemberUpdateOk.mem" class="was-validated">
		<h2>회 원 정 보 수 정</h2>
		<br />
		<div class="form-group">
			아이디 &nbsp; ${sMid}
		</div>
		<div class="form-group">
			닉네임 &nbsp; ${sNickName}
		</div>
		<div class="form-group">
			<label for="name">성명</label>
			<input type="text" class="form-control" id="name" name="name" value="${vo.name}" required />
		</div>
		<div class="form-group">
			<label for="email1">이메일</label>
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="이메일을 입력하세요." id="email1" name="email1" value="${email1}" required />
				<div class="input-group-append">
					<select name="email2" class="custom-select">
						<option value="naver.com"   <c:if test="${email2 == 'naver.com'}">selected</c:if>>naver.com</option>
						<option value="hanmail.net" <c:if test="${email2 == 'hanmail.net'}">selected</c:if>>hanmail.net</option>
						<option value="hotmail.com" <c:if test="${email2 == 'hotmail.com'}">selected</c:if>>hotmail.com</option>
						<option value="gmail.com"   <c:if test="${email2 == 'gmail.com'}">selected</c:if>>gmail.com</option>
						<option value="nate.com"    <c:if test="${email2 == 'nate.com'}">selected</c:if>>nate.com</option>
						<option value="yahoo.com"   <c:if test="${email2 == 'yahoo.com'}">selected</c:if>>yahoo.com</option>
					</select>
				</div>
			</div>
		</div>
		<button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button>&nbsp;
		<button type="reset" class="btn btn-secondary">모두 지우기</button>&nbsp;
		<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/MemberMain.mem';">돌아가기</button>
		<input type="hidden" name="email" />
	</form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>