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
		let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		let regTel = /\d{2,3}-\d{3,4}=\d{4}$/g;
		
		let nickNmae = myform.nickName.value;
		let name = myform.name.value;
		let email1 = myform.email1.value.trim();
		let email2 = myform.email2.value;
		let email = email1 + "@" + email2;
		let homePage = myform.homePage.value;
		let tel1 = myform.tel1.value;
		let tel2 = myform.tel2.value.trim();
		let tel3 = myform.tel3.value.trim();
		let tel = tel1 + "-" + tel2 + "-" + tel3;
		
		let submitFlag = 0; // 모든 체크 정상 종료 -> submitFlag : 1로 변경 
		
		// 앞의 정규식으로 정의된 부분에 대한 유효성 체크
		/* if (!regNickName.test(nickName)) {
			alert("닉네임은 한글과 영어 대/소문자만 사용 가능합니다.");
			myform.nickName.focus();
			return false;
		} else */ if (!regName.test(name)) {
			alert("성명은 한글만 사용 가능합니다.");	
			myform.name.focus();
			return false;
		} else if (!regEmail.test(email)) {
			alert("이메일 형식에 맞게 작성해주세요.");
			myform.email.focus();
			return false;
		} else if ((homePage != "http://" && homePage != "")) {
			if (!regURL.test(homePage)) {
				alert("작성하신 홈페이지 주소가 URL 형식에 맞지 않습니다.");
				myform.homePage.focus();
				return false;
			} else {
				submitFlag = 1;
			}
		}
		
		/* if (tel2 != "" && tel3 != "") {
			if (!regTel.test(tel)) {
				alert("전화번호 형식을 확인하세요.(000-0000-0000)");
				myform.tel2.focus();
				return false;
			} else {
				submitFlag = 1;
			}
		} else { */
			tel2 = " ";
			tel3 = " ";
			tel = tel1 + "-" + tel2 + "-" + tel3;
			submitFlag = 1;
		/* } */
		
		// 주소 하나로 묶기
		let postcode = myform.postcode.value + " ";
		let roadAddress = myform.roadAddress.value + " ";
		let detailAddress = myform.detailAddress.value + " ";
		let extraAddress = myform.extraAddress.value + " ";
		myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
		
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
				myform.tel.value = tel;
				
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
			<label for="nickName">닉네임 &nbsp; &nbsp;
				<input type="button" value="닉네임 중복확인" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickNameCheck()" />
			</label>
			<input type="text" class="form-control" id="nickName" value="${sNickName}" name="nickName" required />
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
		<div class="form-group">
			<div class="form-check-inline">
				<span class="input-group-text">성별</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="여자"<c:if test="${vo.gender == '여자'}">checked</c:if>>여자
				</label>
			</div>
		</div>
		<div class="form-group">
			<label for="birthday">생일</label>
			<input type="date" name="birthday" value="${birthday}" class="form-control"/>
		</div>
		<div class="form-group">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">전화번호</span> &nbsp;&nbsp;
					<select name="tel1" class="custom-select">
						<option value="010" ${tel1 == "010" ? "selected" : ""}>010</option>
						<option value="02"  ${tel1 == "02"  ? "selected" : ""}>서울</option>
						<option value="031" ${tel1 == "031" ? "selected" : ""}>경기</option>
						<option value="032" ${tel1 == "032" ? "selected" : ""}>인천</option>
						<option value="041" ${tel1 == "041" ? "selected" : ""}>충남</option>
						<option value="042" ${tel1 == "042" ? "selected" : ""}>대전</option>
						<option value="043" ${tel1 == "043" ? "selected" : ""}>충북</option>
						<option value="051" ${tel1 == "051" ? "selected" : ""}>부산</option>
						<option value="052" ${tel1 == "052" ? "selected" : ""}>울산</option>
						<option value="061" ${tel1 == "061" ? "selected" : ""}>전북</option>
						<option value="062" ${tel1 == "062" ? "selected" : ""}>광주</option>
					</select>-
				</div>
				<input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control" /> - 
				<input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label for="address">주소</label>
			<input type="hidden" name="address" id="address">
				<div class="input-group mb-1">
					<input type="text" name="postcode" value="${postcode}" id="sample6_postcode" placeholder="우편번호" class="form-control" />
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary" />
					</div>
				</div>
			<input type="text" name="roadAddress" value="${roadAddress}" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" />
			<div class="input-group mb-1">
				<input type="text" name="detailAddress" value="${detailAddress}" id="sample6_detailAddress" placeholder="상세주소" class="form-control" /> &nbsp;&nbsp;
				<div class="input-group-append">
					<input type="text" name="extraAddress" value="${extraAddress}" id="sample6_extraAddress" placeholder="참고항목" class="form-control" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="homepage">홈페이지 주소</label>
			<input type="text" class="form-control" name="homePage" value="${vo.homePage}" placeholder="홈페이지를 입력하세요." id="homePage" />
		</div>
		<div class="form-group">
			<label for="name">직업</label>
			<select class="form-control" id="job" name="job">
				<option ${vo.job == "학생" ? "selected" : ""}>학생</option>
				<option ${vo.job == "회사원" ? "selected" : ""}>회사원</option>
				<option ${vo.job == "공무원" ? "selected" : ""}>공무원</option>
				<option ${vo.job == "군인" ? "selected" : ""}>군인</option>
				<option ${vo.job == "의사" ? "selected" : ""}>의사</option>
				<option ${vo.job == "법조인" ? "selected" : ""}>법조인</option>
				<option ${vo.job == "세무인" ? "selected" : ""}>세무인</option>
				<option ${vo.job == "자영업" ? "selected" : ""}>자영업</option>
				<option ${vo.job == "기타" ? "selected" : ""}>기타</option>
			</select>
		</div>
		<div class="form-group">
			<%-- <div class="form-check-inline">
				<span class="input-group-text">취미</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="등산" name="hobby" />등산
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="낚시" name="hobby" />낚시
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="수영" name="hobby" />수영
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="독서" name="hobby" />독서
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="영화감상" name="hobby" />영화감상
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="바둑" name="hobby" />바둑
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="축구" name="hobby" />축구
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" value="기타" name="hobby" checked />기타
				</label>
			</div>
		</div>
		<div class="form-group">
			<label for="content">자기소개</label>
			<textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요.">${vo.content}</textarea>
		</div>
		<div class="form-group">
			<div class="form-check-inline">
				<span class="input-group-text">정보공개</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="공개" ${vo.userInfor == "공개" ? "checked" : ""} />공개
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="비공개" ${vo.userInfor == "비공개" ? "checked" : ""}/>비공개
				</label>
			</div> --%>
			취미 &nbsp;&nbsp;
			<c:set var="varHobbys" value="${fn:split('등산/낚시/수영/독서/영화감상/바둑/축구/기타', '/')}" />
			<c:forEach var="tempHobby" items="${varHobbys}" varStatus="st">
				<input type="checkbox" value="${tempHobby}" name="hobby" <c:if test="${fn:contains(hobby, varHobbys[st.index])}">checked</c:if> />${tempHobby}&nbsp;
			</c:forEach>
		</div>
		<div class="form-group">
			<label for="content">자기소개</label>
			<textarea rows="5" class="form-control" id="content" name="content">${vo.content}</textarea>
		</div>
		<div class="form-group">
			<div class="form-check-inline">
				<span class="input-group-text">정보공개</span> &nbsp; &nbsp;
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="공개" ${vo.userInfor=="공" ? "checked" : ""} />공개
				</label>
			</div>
			<div class="form-check-inline">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="비공개" ${vo.userInfor=="비공개" ? "checked" : ""} />비공개
				</label>
			</div>		
		</div>
		<div class="form-group">
			프로필 사진 (파일최대용량 : 2MB)
			<img src="${ctp}/images/member/${vo.photo}" width="100px" />
			<input type="file" name="fName" id="file" class="form-control-file border" />
		</div>
		<button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button>&nbsp;
		<button type="reset" class="btn btn-secondary">모두 지우기</button>&nbsp;
		<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/MemberMain.mem';">돌아가기</button>
		<input type="hidden" name="email" />
		<input type="hidden" name="tel" />
		<input type="hidden" name="address" />
	</form>
</div>
<p><br /></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>