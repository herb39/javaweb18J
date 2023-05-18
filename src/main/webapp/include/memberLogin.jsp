<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div class="modal fade" id="loginModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<h2 class="text-center">로그인</h2>
			<form name="myform" method="post" action="${ctp}/MemberLoginOk.mem" class="was-validated">
				<div class="form-group pl-3 pr-3">
					<label for="mid">아이디</label>
					<input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus />
					<div class="valid-feedback"></div>
					<div class="invalid-feedback"></div>
				</div>
				<div class="form-group pl-3 pr-3">
					<label for="pwd">비밀번호</label>
					<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
					<div class="valid-feedback"></div>
					<div class="invalid-feedback"></div>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary mr-1">로그인</button>
					<button type="button" onclick="location.href='${ctp}/MemberJoin.mem';" class="btn btn-info">회원가입</button>
				</div>
				<div class="row text-center pb-3" style="font-size: 12px;">
					<span class="col">
						<input type="checkbox" name="idSave" checked />아이디 저장
					</span>
					<span class="col">
						[<a href="${ctp}/member/MemberFindId">아이디 찾기</a>] / [<a href="#">비밀번호 찾기</a>]
					</span>
				</div>
			</form>
		</div>
	</div>
</div>