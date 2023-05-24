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
	
	
	// 유효성 검사
	// 아이디 닉네임 성명 이메일 홈페이지 전화번호 비밀번호
	
	let regMid = /^[a-zA-Z0-9_]{4,20}$/;
	let regPwd = /(?=.*[0-9a-zA-z]).{4,20}$/;
	let regNickName = /^[a-zA-z0-9가-힣]+$/;
	let regName = /^[가-힣]+$/;
	let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	
		
	function joinCheck() {
		let mid = $("#mid1").val();
		let pwd = $("#pwd1").val();
		let nickName = $("#nickName").val();
		let name = $("#name").val();
		let email1 = $("#email1").val();
		let email2 = $("#email2").val();
		let email = email1 + "@" + email2;
		
		/* console.log(mid, pwd, nickName, name, email); */
		
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
	}
	
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
		<div class="modal-content">
			<form name="myform" method="post" class="was-validated">
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
				<div class="form-group">
					프로필 사진 (파일최대용량 : 2MB)
					<input type="file" name="fName" id="file" class="form-control-file border" />
				</div>
				<button type="button" class="btn btn-secondary" onclick="joinCheck()">회원가입</button>&nbsp;
				<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}';">돌아가기</button>
			</form>
		</div>
	</div>
</div>
