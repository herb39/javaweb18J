<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>findId.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class='container'>
	<h2 class="text-center">아이디 찾기</h2>
	<form name="myform" method="post" action="${ctp}/database/findPwd">
		<table class="table table-bordered text-center"> 
			<tr>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" class="form-control" /></td>
			</tr>		
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" class="form-control mb-3" /></td>
			</tr>		
			<tr>
				<td colspan="2">
					<input type="submit" value="확인" class="btn btn-success" />
					<input type="reset" value="다시입력" class="btn btn-info" />
					<input type="button" value="돌아가기" onclick="location.href='memberLogin.jsp';" class="btn btn-secondary" />
				</td>
			</tr>	
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>