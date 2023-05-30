<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	'use strict';
	
	// 아이디 / 닉네임 중복 확인 버튼 눌렀는지 확인 변수 : 버튼 클릭 후 내용 수정 X
	let idCheckSw = 0;
	let nickNameCheckSw = 0;
	
	// 아이디 중복 체크
	function idCheck() {
		let mid = $("#mid1").val();
		let url = "${ctp}/MemberIdCheck.mem?mid=" + mid;

		if (mid.trim() == "") {
			alert("아이디를 입력하세요.");
			joinForm.mid.focus();
		} else {
			idCheckSw = 1;
			joinForm.mid.readOnly = true;
			window.open(url, "nWin", "width=580px,height=250px");
		}
	}
	
	// 닉네임 중복 체크
	function nickNameCheck() {
		let nickName = joinForm.nickName.value;
		let url = "${ctp}/MemberNickNameCheck.mem?nickName=" + nickName;

		if (nickName.trim() == "") {
			alert("닉네임을 입력하세요.");
			joinForm.nickName.focus();
		} else {
			nickNameCheckSw = 1;
			joinForm.nickName.readOnly = true;
			window.open(url, "nWin", "width=580px,height=250px");
		}
	}
	
	function joinCheck() {
		// 유효성 검사
		// 아이디 닉네임 성명 이메일 홈페이지 전화번호 비밀번호
		
		let regMid = /^[a-zA-z0-9_]{4,20}$/;
		let regPwd = /(?=.*[0-9a-zA-z]).{4,20}$/;
		let regNickName = /^[a-zA-z0-9가-힣]+$/;
		let regName = /^[가-힣]+$/;
		let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		
		let mid = $("#mid1").val();
		let pwd = $("#pwd1").val();
		let nickName = $("#nickName").val();
		let name = $("#name").val();
		let email1 = joinForm.email1.value.trim();
		let email2 = joinForm.email2.value;
		let email = email1 + "@" + email2;
		
		let submitFlag = 0; // 모든 체크 정상 종료 -> submitFlag : 1로 변경 
		
		// 앞의 정규식으로 정의된 부분에 대한 유효성 체크
		if (!regMid.test(mid)) {
			alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 사용 가능합니다.");
			joinForm.mid.focus();
			return false;
		} else if (!regPwd.test(pwd)) {
			alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 6~24자리로 작성해주세요.");	
			joinForm.pwd.focus();
			return false;
		} else if (!regNickName.test(nickName)) {
			alert("닉네임은 한글과 영어 대/소문자만 사용 가능합니다.");
			joinForm.nickName.focus();
			return false;
		} else if (!regName.test(name)) {
			alert("성명은 한글만 사용 가능합니다.");	
			joinForm.name.focus();
			return false;
		} else if (!regEmail.test(email)) {
			alert("이메일 형식에 맞게 작성해주세요.");
			joinForm.email.focus();
			return false;
		} else {
			submitFlag = 1;
		}

		
		// 전송 전 모든체크 끝나면 submitFlag : 1 -> 서버 전송
		if  (submitFlag == 1) {
			if (idCheckSw == 0) {
				alert("아이디 중복확인 버튼을 누르세요.");
				document.getElementById("midBtn").focus();
			} else if (nickNameCheckSw == 0) {
				alert("닉네임 중복확인 버튼을 누르세요.");
				document.getElementById("nickNameBtn").focus();
			} else {
				let query = {
						mid			: mid,
						pwd			: pwd,
						nickName	: nickName,
						name		: name,
						email		: email
				}
				
				$.ajax({
					type	: "post",
					url		: "${ctp}/MemberJoinOk.mem",
					data	: query,
					success	: function(res) {
						if (res == "1") {
							alert("회원가입 되었습니다. 다시 로그인해주세요.");
							$('#joinModal').modal('hide');
							$('#loginModal').modal('show');
						} else {
							alert("회원가입에 실패했습니다. 다시 시도해주세요.");
							$("#mid").focus();
						}
					},
					error	: function() {
						alert("전송 오류");
					}
				});
			}
		} else {
			alert("형식을 다시 확인하세요.");
		}
	}
	
	/* function joinCheck() {
		// 유효성 검사
		// 아이디 닉네임 성명 이메일 홈페이지 전화번호 비밀번호
		
		let regMid = /^[a-zA-Z0-9_]{4,20}$/;
		let regPwd = /(?=.*[0-9a-zA-z]).{4,20}$/;
		let regNickName = /^[a-zA-z0-9가-힣]+$/;
		let regName = /^[가-힣]+$/;
		let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
		
		let mid = $("#mid1").val();
		let pwd = $("#pwd1").val();
		let nickName = $("#nickName").val();
		let name = $("#name").val();
		let email1 = $("#email1").val();
		let email2 = $("#email2").val();
		let email = email1 + "@" + email2;
		
		if (mid == "") {
			alert("아이디를 입력하세요.");
			$("#mid1").focus();
			return false;
		} else if (pwd == "") {
			alert("비밀번호를 입력하세요.");
			$("#pwd1").focus();
			return false;
		} else if (nickName == "") {
			alert("닉네임을 입력하세요.");
			$("#nickName").focus();
			return false;
		} else if (name == "") {
			alert("성명을 입력하세요.");
			$("#name").focus();
			return false;
		} else if (email == "") {
			alert("이메일을 입력하세요.");
			$("#email1").focus();
			return false;
		}

		let query = {
				mid			: mid,
				pwd			: pwd,
				nickName	: nickName,
				name		: name,
				email		: email
		}
		
		$.ajax({
			type	: "post",
			url		: "${ctp}/MemberJoinOk.mem",
			data	: query,
			success	: function(res) {
				if (res == "1") {
					alert("회원가입 되었습니다. 다시 로그인해주세요.");
					$('#joinModal').modal('hide');
					$('#loginModal').modal('show');
				} else {
					alert("회원가입에 실패했습니다. 다시 시도해주세요.");
					$("#mid").focus();
				}
			},
			error	: function() {
				alert("전송 오류");
			}
		});
	} */
	
	// mid1 autofocus
	$(document).ready(function() {
		//$("#mid1").focus();
		$(".modal").on("shown.bs.modal", function () {		
			$("#mid1").focus();
		});	
	});

	function showJoinModal() {
		$('#loginModal').modal('hide');
		$('#joinModal').modal('show');
	}
</script>
<div class="modal fade" id="joinModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content p-4">
			<form name="joinForm" method="post" class="was-validated">
				<h2 class="text-center">회 원 가 입</h2>
				<br />
				<div class="form-group">
					<label for="mid">아이디 &nbsp; &nbsp;
						<input type="button" value="아이디 중복확인" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()" />
					</label>
					<input type="text" class="form-control borederless" name="mid" id="mid1" value="${cMid}" placeholder="아이디를 입력하세요." required />
				</div>
				<div class="form-group">
					<label for="pwd">비밀번호</label>
					<input type="password" class="form-control" id="pwd1" placeholder="비밀번호 입력하세요." name="pwd" required />
				</div>
				<div class="form-group">
					<label for="nickName">닉네임 &nbsp; &nbsp;
						<input type="button" value="닉네임 중복확인" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickNameCheck()" />
					</label>
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
							<select name="email2" id="email2" class="custom-select">
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
				<div style="text-align:center;">
					<button type="button" class="btn btn-primary" onclick="joinCheck()">회원가입</button>&nbsp;
					<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}';">돌아가기</button>
				</div>
			</form>
		</div>
	</div>
</div>
