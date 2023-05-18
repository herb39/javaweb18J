<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<jsp:include page="/include/bs4.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/js/woo.js"></script>
<script>
	'use strict';

	// 아이디 / 닉네임 중복 확인 버튼 눌렀는지 확인 변수 : 버튼 클릭 후 내용 수정 X
	let idCheckSw = 0;
	let nickNameCheckSw = 0;
	
	
	function fCheck() {
		// 유효성 검사
		// 아이디 닉네임 성명 이메일 홈페이지 전화번호 비밀번호
		
		let regMid = /^[a-zA-z0-9_]{4,20}$/;
		let regPwd = /(?=.*[0-9a-zA-z]).{4,20}$/;
		let regNickName = /^[a-zA-z0-9가-힣]+$/;
		let regName = /^[가-힣]+$/;
		let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		let regTel = /\d{2,3}-\d{3,4}=\d{4}$/g;
		
		
		let mid = myform.mid.value.trim();
		let pwd = myform.pwd.value;
		let nickName = myform.nickName.value;
		let name = myform.name.value;
		let email1 = myform.email1.value.trim();
		let email2 = myform.email2.value;
		let email = email1 + "@" + email2;
		let tel1 = myform.tel1.value;
		let tel2 = myform.tel2.value.trim();
		let tel3 = myform.tel3.value.trim();
		let tel = tel1 + "-" + tel2 + "-" + tel3;
		
		let submitFlag = 0; // 모든 체크 정상 종료 -> submitFlag : 1로 변경 
		
		// 앞의 정규식으로 정의된 부분에 대한 유효성 체크
		if (!regMid.test(mid)) {
			alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 사용 가능합니다.");
			myform.mid.focus();
			return false;
		} else if (!regPwd.test(pwd)) {
			alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 6~24자리로 작성해주세요.");	
			myform.pwd.focus();
			return false;
		} else if (!regNickName.test(nickName)) {
			alert("닉네임은 한글과 영어 대/소문자만 사용 가능합니다.");
			myform.nickName.focus();
			return false;
		} else if (!regName.test(name)) {
			alert("성명은 한글만 사용 가능합니다.");	
			myform.name.focus();
			return false;
		} else if (!regEmail.test(email)) {
			alert("이메일 형식에 맞게 작성해주세요.");
			myform.email.focus();
			return false;
		}

		if (tel2 != "" && tel3 != "") {
			if (!regTel.test(tel)) {
				alert("전화번호 형식을 확인하세요.(000-0000-0000)");
				myform.tel2.focus();
				return false;
			} else {
				submitFlag = 1;
			}
		} else { // 전화번호를 입력하지 않으면 DB에 '010- - '의 형태로 저장
			tel2 = " ";
			tel3 = " ";
			tel = tel1 + "-" + tel2 + "-" + tel3;
				submitFlag = 1;
		}
		
		// 전송 전, 주소 하나로 묶기
		let postcode = myform.postcode.value + " ";
		let roadAddress = myform.roadAddress.value + " ";
		let detailAddress = myform.detailAddress.value + " ";
		let extraAddress = myform.extraAddress.value + " ";
		myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
		
		// 전송 전 모든체크 끝나면 submitFlag : 1 -> 서버 전송
		if  (submitFlag == 1) {
			if (idCheckSw == 0) {
				alert("아이디 중복확인 버튼을 누르세요.");
				document.getElementById("midBtn").focus();
			} else if (nickNameCheckSw == 0) {
				alert("닉네임 중복확인 버튼을 누르세요.");
				document.getElementById("nickNameBtn").focus();
			} else {
				myform.email.value = email;
				myform.tel.value = tel;
				
				myform.submit();		
			}
		} else {
			alert("형식을 다시 확인하세요.");
		}
	}
	
	// 아이디 중복 체크
	function idCheck() {
		let mid = myform.mid.value;
		let url = "${ctp}/MemberIdCheck.mem?mid=" + mid;

		if (mid.trim() == "") {
			alert("아이디를 입력하세요.");
			myform.mid.focus();
		} else {
			idCheckSw = 1;
			myform.mid.readOnly = true;
			window.open(url, "nWin", "width=580px,height=250px");
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
	<form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="was-validated">
		<h2>회 원 가 입</h2>
		<br />
		<div class="form-group">
			<label for="mid">아이디 &nbsp; &nbsp;
			<input type="button" value="아이디 중복확인" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()" /></label>
			<input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus />
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호</label>
			<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
		</div>
		<div class="form-group">
			<label for="nickName">닉네임 &nbsp; &nbsp;
			<input type="button" value="닉네임 중복확인" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickNameCheck()" /></label>
			<input type="text" class="form-control" id="nickName" placeholder="닉네임을 입력하세요." name="nickName" required />
		</div>
		<div class="form-group">
			<label for="name">성명</label>
			<input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
		</div>
		<div class="form-group">
			<label for="email1">이메일</label>
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="이메일을 입력하세요." id="email1" name="email1" required />
				<div class="input-group-append">
					<select name="email2" class="custom-select">
						<option value="naver.com" selected>naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.com">yahoo.com</option>
					</select>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="form-check-inline">
				<span class="input-group-text">성별</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="여자">여자
				</label>
			</div>
		</div>
		<div class="form-group">
			<label for="birthday">생일</label>
			<input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
		</div>
		<div class="form-group">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">전화번호</span> &nbsp;&nbsp;
					<select name="tel1" class="custom-select">
						<option value="010" selected>010</option>
						<option value="02">서울</option>
						<option value="031">경기</option>
						<option value="032">인천</option>
						<option value="041">충남</option>
						<option value="042">대전</option>
						<option value="043">충북</option>
						<option value="051">부산</option>
						<option value="052">울산</option>
						<option value="061">전북</option>
						<option value="062">광주</option>
					</select> -
				</div>
				<input type="text" name="tel2" size=4 maxlength=4 class="form-control" /> - 
				<input type="text" name="tel3" size=4 maxlength=4 class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label for="address">주소</label>
			<input type="hidden" name="address" id="address">
				<div class="input-group mb-1">
					<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" />
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary" />
					</div>
				</div>
			<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" />
			<div class="input-group mb-1">
				<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" /> &nbsp;&nbsp;
				<div class="input-group-append">
					<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="form-check-inline">
				<span class="input-group-text">정보공개</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="공개" checked />공개
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="비공개" />비공개
				</label>
			</div>
		</div>
		<div class="form-group">
			프로필 사진 (파일최대용량 : 2MB)
			<input type="file" name="fName" id="file" class="form-control-file border" />
		</div>
		<button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button>&nbsp;
		<button type="reset" class="btn btn-secondary">모두 지우기</button>&nbsp;
		<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}';">돌아가기</button>
		<input type="hidden" name="email" />
		<input type="hidden" name="tel" />
		<input type="hidden" name="address" />
	</form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>