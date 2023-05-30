<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardInput.jsp</title>
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
    
    function inputBoard() {
    	let title = boardInput.title.value;
    	let content = boardInput.content.value;
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		boardInput.title.focus();
    	}
    	else if(content.trim() == "") {
    		alert("게시글 내용을 입력하세요");
    		boardInput.content.focus();
    	}
    	else {
    		boardInput.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 글 작 성</h2>
  <form name="boardInput" method="post" action="${ctp}/BoardInputOk.bo">
    <table class="table table-bordered">
      <tr>
        <th>작성자</th>
        <td>
        	<span class="badge badge-pill badge-secondary">LV.${sLevel}</span> ${sNickName}
        </td>
      </tr>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" id="title" placeholder="제목을 입력하세요." autofocus required class="form-control"></td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea rows="6" name="content" class="form-control" required></textarea></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
        	<input type="button" value="등록" onclick="inputBoard()" class="btn btn-secondary" />
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/BoardList.bo';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>