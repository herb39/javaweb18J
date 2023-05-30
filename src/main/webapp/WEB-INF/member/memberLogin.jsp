<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
	'use strict';
	
	// mid autofocus
	$(document).ready(function() {
		// $("#mid").focus();
		$(".modal").on("shown.bs.modal", function () {		
			$("#mid").focus();
		});	
	});
	
	function loginCheck() {
		let mid = $("#mid").val();
		let pwd = $("#pwd").val();
		let idSave = $("#idSave").val();

		if (mid.trim() == "") {
			alert("아이디를 입력하세요.");
			$("#mid").focus();
			return false;
		} else if (pwd.trim() == "") {
			alert("비밀번호를 입력하세요.")
			$("#pwd").focus();
			return false;
		}

		$.ajax({
			type : "post",
			url : "${ctp}/MemberLoginOk.mem",
			data : {
				mid : mid,
				pwd : pwd,
				idSave : idSave
			},
			success : function(res) {
				if (res == "1") {
					alert("로그인 되었습니다.");
					$('#loginModal').modal('hide');
					location.reload();
				} else {
				console.log(res);
					alert("회원정보가 없습니다.");
					$("#mid").focus();
				}
			},
			error : function() {
				alert("전송오류");
			}
		});
	}
	
	
	// 로그인 모달에서 회원가입 버튼 클릭 -> 로그인 모달 닫고 회원가입 모달 띄우기
	function joinModal() {
		$('#loginModal').modal('hide');
		$('#joinModal').modal('show');
		$("#mid1").focus();
	}
</script>
<div class="modal fade" id="loginModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content p-4">
			<!-- Modal Header -->
			<div class="modal-header">
				<h2 class="modal-title text-center">로 그 인</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group">
					<form name="loginForm" method="post">
						<div class="form-group">
							<label for="mid">아이디</label>
							<input type="text" class="form-control borederless" name="mid" id="mid" value="${cMid}" placeholder="아이디를 입력하세요." required />
						</div>
						<div class="form-group">
							<label for="pwd">비밀번호</label>
							<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
						</div>
						<div style="text-align:center;">
							<button type="button" onclick="loginCheck()" class="btn btn-outline-success mr-1">로그인</button>
							<button type="button" class="btn btn-outline-primary" onclick="joinModal()">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>